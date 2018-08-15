//
//  OYONetwork.m
//  OYOConsumer
//
//  Created by chengshaohua on 2018/7/9.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import "OYONetwork.h"
#import "AFHTTPSessionManager+AutoRetry.h"
#import "OYORequest.h"
#import "OYOResponse.h"

#define OYO_TIME_OUT_INTERVAL 130
#define OYOLock() dispatch_semaphore_wait(self->_lock, DISPATCH_TIME_FOREVER)
#define OYOUnlock() dispatch_semaphore_signal(self->_lock)

@interface OYONetwork () {
    AFJSONResponseSerializer *_jsonResponseSerializer;
    AFXMLParserResponseSerializer *_xmlParserResponseSerialzier;
    dispatch_semaphore_t _lock;
}

// 是否阻塞请求
@property (nonatomic, assign)BOOL isBarrage;

@property (nonatomic, strong)dispatch_queue_t taskQueue;

@property (nonatomic, strong)NSMutableDictionary *reqPoolDict;

// 超时时间
@property (nonatomic, assign)CGFloat timeoutInterval;

@property (nonatomic, copy)NetTokenObj *(^acquireTokenBlock)(void);
@property (nonatomic, copy)void (^cacheTokenBlock)(id obj);
@property (nonatomic, copy)void (^errorHandleBlock)(OYOApiError error);

@property (nonatomic, strong)NSMutableDictionary *chainReqDict;
@property (nonatomic, strong)NSMutableDictionary *downloadReqDict;

@property (nonatomic, strong)AFJSONRequestSerializer *JSONSerializer;
@property (nonatomic, strong)AFHTTPRequestSerializer *HTTPSerializer;


@end

@implementation OYONetwork

+ (void) load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (instancetype)shareManager {
    static OYONetwork *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)setNetWorkConfigWithBaseUrl:(NSString *)baseUrl {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl] sessionConfiguration:configuration];
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    //是否验证主机名
    policy.validatesDomainName = NO;
    //是否允许CA不信任的证书通过
    policy.allowInvalidCertificates = YES;
    self.sessionManager.securityPolicy = policy;
    self.sessionManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    responseSerializer.readingOptions = NSJSONReadingAllowFragments;
    self.sessionManager.responseSerializer = responseSerializer;
    self.sessionManager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    
    _taskQueue = dispatch_queue_create("com.task.request.queue", DISPATCH_QUEUE_CONCURRENT);
    _lock = dispatch_semaphore_create(1);
    
    self.debugLogEnabled = YES;
    self.isCancleSendWhenExciting = YES;
    oyo_addObserver(self, AFNetworkingTaskDidResumeNotification, @selector(doApiTaskResume:));
    oyo_addObserver(self, AFNetworkingTaskDidCompleteNotification, @selector(doApiTaskComplect:));
    
    self.timeoutInterval = OYO_TIME_OUT_INTERVAL;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            self.timeoutInterval = OYO_TIME_OUT_INTERVAL;
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            self.timeoutInterval = OYO_TIME_OUT_INTERVAL-10;
        }else if (status == AFNetworkReachabilityStatusUnknown) {
            self.timeoutInterval = OYO_TIME_OUT_INTERVAL;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)setAcquireToken:(NetTokenObj * (^_Nonnull)(void))tokenBlock {
    self.acquireTokenBlock = tokenBlock;
}

- (void)setCacheTokenInfo:(void (^)(id tokenObj))cacheBlock {
    self.cacheTokenBlock = cacheBlock;
}

- (void)setHandleError:(void (^)(OYOApiError error))errorBlock {
    self.errorHandleBlock = errorBlock;
}

- (void)setHttpAuthorizationHeaderWithReq:(OYORequest *)req {
    self.sessionManager.requestSerializer = [self requestSerializerForRequest:req];
}

- (AFHTTPRequestSerializer *)requestSerializerForRequest:(OYORequest *)request {
    AFHTTPRequestSerializer *requestSerializer = nil;
    if (request.reqHeaderType == OYOFormHeaderType) {
        requestSerializer = [AFHTTPRequestSerializer serializer];
    } else if (request.reqHeaderType == OYOJSONHeaderType) {
        requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    if (self.timeoutInterval > 5) {
        requestSerializer.timeoutInterval = self.timeoutInterval;
    }
    
    // 设置 http 的 Authorization
    [self setHttpAuthorizationHeader:requestSerializer request:request];
    
    // If api needs to add base value to HTTPHeaderField
    [requestSerializer setValue:oyo_bundleShortVersion() forHTTPHeaderField:@"appVersion"];
    [requestSerializer setValue:@"IOS" forHTTPHeaderField:@"firstChannel"];
    [requestSerializer setValue:@"AppStore" forHTTPHeaderField:@"secondChannel"];
    [requestSerializer setValue:kVersionSystemDevice forHTTPHeaderField:@"osVersion"];
    [requestSerializer setValue:kVersionUUIDString forHTTPHeaderField:@"deviceToken"];
    [requestSerializer setValue:[[UIDevice currentDevice] model] forHTTPHeaderField:@"deviceName"];
    
    return requestSerializer;
}

// 设置HeaderField、Parameters
- (void)setHttpAuthorizationHeader:(AFHTTPRequestSerializer *)serializer request:(OYORequest *)req {
    // If api needs server headerfield and parameters
    if (!req.isNeedAuthHeader) {
        [serializer clearAuthorizationHeader];
    } else {
        void(^serializerBlock)(id) = ^(id dictionary) {
            for (NSString *key in dictionary) {
                [serializer setValue:dictionary[key] forHTTPHeaderField:key];
            }
        };
        if(req.requestHeaderFields) {
            serializerBlock(req.requestHeaderFields);
        }
        if(self.headerFieldBlock) {
            serializerBlock(self.headerFieldBlock());
        }
    }
    if(self.parameterBlock) {
        NSMutableDictionary *combinParams = [NSMutableDictionary dictionaryWithDictionary:self.parameterBlock()];
        [combinParams setValuesForKeysWithDictionary:req.param];
        req.param = combinParams;
    }
}

- (void)setHttpAuthorizationHeaderWithContentType:(BOOL)isJSON api:(NSString *)api {
    self.sessionManager.requestSerializer = isJSON?self.JSONSerializer:self.HTTPSerializer;
    NetTokenObj *tokenObj = [self doGenerateTheTokenObject];
    // 测试Token.
    NSString *token = @"";
    if (tokenObj && tokenObj.accessToken && tokenObj.accessToken.length > 0) {
        token = tokenObj.accessToken;
    }
    [self.sessionManager.requestSerializer setValue:token forHTTPHeaderField:@"access_token"];
}

// 获取Token.
- (NetTokenObj *)doGenerateTheTokenObject {
    NetTokenObj *tokenObj;
    if (self.acquireTokenBlock) {
        tokenObj = self.acquireTokenBlock();
    }else {
        tokenObj = [[NetTokenObj alloc] init];
    }
    return tokenObj;
}

- (void)doHandleHttpError:(OYOApiError)error {
    if (self.errorHandleBlock) {
        self.errorHandleBlock(error);
    }
}

// 重新生成Token.
- (void)refreshUserToken {
    NSLog(@"-->> refreshUserToken %s", __func__);
    NetTokenObj *tokenObj = [self doGenerateTheTokenObject];
    BOOL enableRefresh = (tokenObj.refreshToken && tokenObj.refreshToken.length != 0);
    self.isBarrage = enableRefresh;
    if(!enableRefresh) {
        [self.reqPoolDict removeAllObjects];
        [self doHandleHttpError:InvalidRefreshToken];
    }
}

- (void)refreshUserTokenInOverdue {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NetTokenObj *tokenObj = [self doGenerateTheTokenObject];
        NSString *access_token = tokenObj.accessToken;
        if (access_token && access_token.length != 0) {
            NSTimeInterval expireTimeInterval = tokenObj.expires_in;
            NSTimeInterval nowTimeInterval = [[NSDate date] timeIntervalSince1970];
            if (expireTimeInterval < nowTimeInterval) {
                [self refreshUserToken];
            }
        }
    });
}

- (void)handleRefreshTokenError {
    [self cancleAllRequest];
    [self cancleAllRequestRespondError];
    [self doHandleHttpError:InvalidRefreshToken];
}

- (OYOResponse *)handleTokenOverdueParam:(id)param {
    self.isBarrage = NO;
    if ([param[@"grant_type"] isEqualToString:@"refresh_token"]) {
        [self handleRefreshTokenError];
        return [OYOResponse responseWithCode:OYOHTTPInvalidRefreshTokenError
                                    message:@"refresh token invalid"];
    } else if ([param[@"grant_type"] isEqualToString:@"password"]) {
        oyo_showTost(@"账号或密码错误");
        return [OYOResponse responseWithCode:OYOHTTPWorkError message:@"password error or invalid"];
    }
    return [OYOResponse responseWithCode:OYOHTTPWorkError  message:@"login api error"];
}

- (OYOResponse *)handleWorkErrorWithInfo:(id)errorInfo  httpCode:(NSInteger)httpCode isShowError:(BOOL)isShow {
    NSError *jsonError;
    NSData *data = [errorInfo dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObj;
    if (data) {
        jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
    }
    
    if (!jsonError && jsonObj && [[jsonObj allKeys] containsObject:@"error"]) {
        NSInteger code = httpCode;
        NSString *message;
        NSDictionary *errorValue = jsonObj[@"error"];
        if (errorValue && [[errorValue allKeys] containsObject:@"code"]) {
            code = [jsonObj[@"code"] integerValue];
            message = [OYOResponse messageMapCode:code];
            if (message.length == 0 && [[errorValue allKeys] containsObject:@"message"]) {
                message = errorValue[@"message"];
            }
        } else {
            message = jsonObj[@"message"]; 
        }
        [self alertNetError:message alert:isShow];
        return [OYOResponse responseWithCode:OYOHTTPWorkError status:code message:message];
    }
    return [OYOResponse responseWithCode:OYOHTTPNetError message:@"无返回数据，或返回数据格式不正确"];
}

#pragma mark - return image method -
- (NSString *)returnImageName {
    NSString *timeStr = oyo_timeInterval();
    NSString *fileName = [NSString stringWithFormat:@"%@.png", timeStr];
    
    return fileName;
}

- (NSString * _Nonnull)startImgUpload:(void (^_Nonnull)(OYOUploadRequest * _Nonnull request))reqBlock
                       handleComplete:(nullable OYORequestComplecteBlock)complecteBlock {
    OYOUploadRequest *req = [[OYOUploadRequest alloc] init];
    req.reqMethod = OYOUploadReqType;
    req.reqHeaderType = OYOJSONHeaderType;
    req.complecteBlock = complecteBlock;
    NSAssert(reqBlock, @"请先配置请求信息");
    reqBlock(req);
//    req.interface = request;
    return [self dispenseTask:req].reqKey;
}


#pragma mark - request -
- (void)startJSONUpload:(NSString * _Nonnull)URLString
             parameters:(nullable id)parameters
               progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
               fileType:(NSString * _Nonnull)fileType
               fileName:(NSString * _Nonnull)fileName
                   data:(NSData * _Nonnull)uploadData
         handleComplete:(nullable OYORequestComplecteBlock)complecteBlock {
    [self setHttpAuthorizationHeaderWithContentType:YES api:URLString];
    [self startUpload:URLString parameters:parameters progress:uploadProgress fileType:fileType fileName:fileName data:uploadData handleComplete:complecteBlock];
}


- (void)startUpload:(NSString * _Nonnull)URLString
         parameters:(nullable id)parameters
           progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
           fileType:(NSString * _Nonnull)fileType
           fileName:(NSString * _Nonnull)fileName
               data:(NSData * _Nonnull)uploadData
     handleComplete:(nullable OYORequestComplecteBlock)complecteBlock {
    if (fileName.length == 0) {
        fileName = oyo_timeInterval();
    }
    
    OYOUploadRequest *req = [[OYOUploadRequest alloc] init];
    req.interface = URLString;
    req.param = parameters;
    req.reqMethod = OYOPOSTReqType;
    req.complecteBlock = complecteBlock;
    
    [self.sessionManager POST:URLString parameters:parameters constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        [formData appendPartWithFileData:uploadData name:fileType fileName:fileName mimeType:@"image/png"];
    } progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (complecteBlock) {
            OYOResponse * res = [self responseWithResponseObj:responseObject req:req];
            complecteBlock(res);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errMsg = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        if (complecteBlock) {
            OYOResponse *res = [self responseWithError:error req:req];
            res.message = errMsg;
            complecteBlock(res);
        }
    }];
}

- (OYORequest *)dispenseTask:(OYORequest *)req {
    NSString *url = [self getWholeURLString:req.interface];
    NSString *reqKey = OYOKeyFromParamAndURLString(req.param, url, req.reqMethod);
    req.reqKey = reqKey;
    NSLog(@"\n\n---- dispenseTask ----- \n%@\n\n\n", url);
    if (!self.isBarrage || !req.isNeedAuthHeader) {
        if ([AFNetworkReachabilityManager sharedManager].reachable) {
            [self startRequest:req];
        } else {
            NSLog(@"%s无网络 ---\n%@", __func__, req.debugDescription);
            [self alertNetError:@"网络异常，请检查网络后重试" alert:req.isAlertNetError];
            if (req.complecteBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    OYOResponse *res = [OYOResponse responseWithCode:OYOHTTPNetError message:@"网络异常"];
                    req.complecteBlock(res);
                });
            }
        }
    }
    return req;
}

// 开始请求
- (void)startRequest:(OYORequest *)req {
    dispatch_async(self.taskQueue, ^{
        NSLog(@"-->> startRequest  %s", __func__);
        switch (req.reqMethod) {
            case OYOGETReqType:
            {
                req.reqTask = [self dataTaskWithHTTPMethod:@"GET" request:req error:nil];
            }
                break;
            case OYOPOSTReqType:
            {
                req.reqTask = [self dataTaskWithHTTPMethod:@"POST" request:req error:nil];
            }
                break;
            case OYOUploadReqType:
            {
                [self setHttpAuthorizationHeaderWithReq:req];
                [self startUpload:(OYOUploadRequest *)req];
            }
                break;
            case OYOPUTReqType:
            {
                req.reqTask = [self dataTaskWithHTTPMethod:@"PUT" request:req error:nil];
            }
                break;
            case OYODeleteReqType:
            {
                req.reqTask = [self dataTaskWithHTTPMethod:@"DELETE" request:req error:nil];
            }
                break;
            case OYODownloadReqType:
            {
                
            }
                break;
            default:
                break;
        }
        req.reqKey = [NSString stringWithFormat:@"%ld",req.reqTask.taskIdentifier];
        OYOLock();
        [self.reqPoolDict setObject:req forKey:@(req.reqTask.taskIdentifier)];
        OYOUnlock();
    });
}

- (NSString *)buildRequestUrl:(OYORequest *)req {
    NSString *url = [[NSURL URLWithString:req.interface relativeToURL:self.sessionManager.baseURL] absoluteString];
    return url;
}


/////// 上传资源 ///////////
- (void)startUpload:(OYOUploadRequest * _Nonnull)req {
    NSString *name = req.type == 0?@"image":@"avatar";
    req.reqTask = [self.sessionManager POST:req.interface parameters:req.param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImageJPEGRepresentation(req.readyUploadImg, 0.1);
        [formData appendPartWithFileData:data name:name fileName:[self returnImageName] mimeType:@"image/png"];
    } progress:req.progressBlock  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (req.complecteBlock) {
            OYOResponse *res = [self responseWithResponseObj:responseObject req:req];
            res.fileName = req.fileName;
            dispatch_async(dispatch_get_main_queue(), ^{
                req.complecteBlock(res);
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errMsg = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        if (req.complecteBlock) {
            OYOResponse *res = [self responseWithError:error req:req];
            res.message = errMsg;
            dispatch_async(dispatch_get_main_queue(), ^{
                req.complecteBlock(res);
            });
        }
    }];
}
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                         request:(OYORequest *)req
                                           error:(NSError * _Nullable __autoreleasing *)error {
    AFHTTPRequestSerializer *requestSerializer = [self requestSerializerForRequest:req];
    NSString *url = [self buildRequestUrl:req];
    NSURLSessionDataTask *task = [self dataTaskWithHTTPMethod:method requestSerializer:requestSerializer URLString:url parameters:req.param constructingBodyWithBlock:nil error:error autoRetry:req.retryTimes retryInterval:req.retryInterval];
    [task resume];
    return task;
}


- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                               requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                           error:(NSError * _Nullable __autoreleasing *)error
                                       autoRetry:(int)timesToRetry
                                   retryInterval:(int)intervalInSeconds  {
    return [self dataTaskWithHTTPMethod:method requestSerializer:requestSerializer URLString:URLString parameters:parameters constructingBodyWithBlock:nil error:error autoRetry:timesToRetry retryInterval:intervalInSeconds];
}

// AFNetwork请求
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                               requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                       constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                                           error:(NSError * _Nullable __autoreleasing *)error
                                       autoRetry:(int)timesToRetry
                                   retryInterval:(int)intervalInSeconds {
    NSMutableURLRequest *request = nil;
    
    if (block) {
        request = [requestSerializer multipartFormRequestWithMethod:method URLString:URLString parameters:parameters constructingBodyWithBlock:block error:error];
    } else {
        request = [requestSerializer requestWithMethod:method URLString:URLString parameters:parameters error:error];
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    typeof(self) weakself = self;
    dataTask = [self.sessionManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakself handleRequestResult:dataTask responseObject:responseObject error:NULL];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [weakself handleRequestResult:dataTask responseObject:nil error:error];
    } autoRetry:timesToRetry retryInterval:intervalInSeconds];
    return dataTask;
}

- (void)handleRequestResult:(NSURLSessionTask *)task responseObject:(id)responseObject error:(NSError *)error {
    oyo_dismissHUD();
    
    OYOLock();
    OYORequest *req = self.reqPoolDict[@(task.taskIdentifier)];
    OYOUnlock();
    
    if (!req) {
        NSLog(@"未找到缓存的Req %s", __func__);
        return;
    }
    
    NSString *errMsg = @"";
    if (error) {
        errMsg = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
    }
    
    NSError * __autoreleasing serializationError = nil;
    id responseObj = responseObject;
    if ([responseObject isKindOfClass:[NSData class]]) {
        switch (req.responseSerializerType) {
            case OYOResponseSerializerTypeHTTP:
                // Default serializer. Do nothing.
                break;
            case OYOResponseSerializerTypeJSON:
                responseObj = [self.jsonResponseSerializer responseObjectForResponse:task.response data:responseObject error:&serializationError];
                break;
            case OYOResponseSerializerTypeXMLParser:
                responseObj = [self.xmlParserResponseSerialzier responseObjectForResponse:task.response data:responseObject error:&serializationError];
                break;
        }
    }
    OYOResponse *res;
    if (error) {  // 网络报错
        res = [self responseWithError:error req:req];
    } else if (serializationError) {  // 解析出错
        res = [self responseWithError:serializationError req:req];
    }else {  // 有数据返回
        res = [self responseWithResponseObj:responseObj req:req];
    }
    if (res.code != OYOHTTPInvalidTokenError && res.code != OYOHTTPInvalidRefreshTokenError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (req.complecteBlock) {
                req.complecteBlock(res);
            }
            req.complecteBlock = nil;
            [self.reqPoolDict removeObjectForKey:@(task.taskIdentifier)];
        });
    }
}

- (NSString * _Nonnull)startDownload:(void (^_Nonnull)(OYODownloadRequest * _Nonnull req))reqBlock {
    __block OYODownloadRequest *req = [[OYODownloadRequest alloc] init];
    req.reqMethod = OYODownloadReqType;
    req.reqHeaderType = OYOFormHeaderType;
    NSAssert(reqBlock, @"请先配置下载文件的路径");
    reqBlock(req);
    OYOWeakSelf
    
    NSString *url = [self buildRequestUrl:req];
    AFHTTPRequestSerializer *requestSerializer = [self requestSerializerForRequest:req];
    NSString *requestType = (req.reqMethod == OYOPOSTReqType)?@"POST":@"GET";
    NSURLRequest *urlRequest = [requestSerializer requestWithMethod:requestType URLString:url parameters:req.param error:nil];
    __block NSURLSessionDownloadTask *task = [self.sessionManager downloadTaskWithRequest:urlRequest progress:req.progressBlock destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if(((NSHTTPURLResponse *)response).statusCode >= 400) {
            return targetPath;
        } else {
            NSString *fileName = [response suggestedFilename];
            if (req.fileName.length != 0) {
                fileName = req.fileName;
            }
            return [NSURL fileURLWithPath:fileName];
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        OYOStrongSelf
        [self handleDownload:task filePath:filePath req:req error:error];
    }];
    [task resume];
    return req.reqKey;
}


- (void)handleDownload:(NSURLSessionDownloadTask *)task filePath:(NSURL *)filePath req:(OYODownloadRequest *)req error:(NSError *)error {

    if (error) {
//        NSDictionary *userInfo = error.userInfo;
//        NSData *resumeData = [userInfo objectForKey:@"NSURLSessionDownloadTaskResumeData"];
    }
    if (error) {
        if (req.downloadComplect) {
            OYOResponse *response = [OYOResponse responseWithCode:OYOHTTPWorkError message:@"文件下载失败"];
            req.downloadComplect(response, nil);
        }
    } else {
        OYOResponse *response = [OYOResponse responseWithCode:OYOHTTPSuccess message:@"文件下载成功"];
        req.downloadComplect(response, filePath);
    }
}

- (void)removeReqKeyFromTaskPool:(OYORequest *)req {
    OYOLock();
    if (req.reqKey && [[self.reqPoolDict allKeys] containsObject:req.reqKey] && !req.unAuthRetry) {
        [self.reqPoolDict removeObjectForKey:req.reqKey];
    }
    OYOUnlock();
}

- (OYOResponse *)responseWithResponseObj:(id)obj req:(OYORequest *)req {
    [self removeReqKeyFromTaskPool:req];
    return [OYOResponse responseWithCode:OYOHTTPSuccess responseObj:obj];
}

- (OYOResponse *)responseWithError:(NSError *)error req:(OYORequest *)req {
    if (req.ignoreRespondError) {
        [self removeReqKeyFromTaskPool:req];
        return [OYOResponse responseWithCode:OYOHTTPWorkError message:@""];
    }
    
    if ([error.domain isEqualToString:NSURLErrorDomain]) {
        [self removeReqKeyFromTaskPool:req];
        NSString *message = [self errorMessageWithCode:error.code];
        [self alertNetError:message alert:YES];
        return [OYOResponse responseWithCode:OYOHTTPNetError message:message];
    } else {
        id errorObj = [self jsonObjWithErrorData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]];
        NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
//        NSString *urlPath = response.URL.path;
//        if ([urlPath containsString:API_LGOIN]) {
//            [self removeReqKeyFromTaskPool:req];
//            return [self handleTokenOverdueParam:req.param];
//        } else
        if (response.statusCode == 401) {
            // token失效
            [self doHandleAuthorizedError:errorObj request:req];
            return [OYOResponse responseWithCode:OYOHTTPInvalidTokenError message:@"token invalid"];
        }
        if (response.statusCode == 500) {
            [self alertNetError:@"未知错误" alert:req.isAlertWorkError];
            [self.reqPoolDict removeObjectForKey:req.reqKey];
            return [OYOResponse responseWithCode:OYOHTTPUnKnownError message:@"未知错误"];
        }
        NSString *errMsg = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        return [self handleWorkErrorWithInfo:errMsg httpCode:response.statusCode isShowError:req.isAlertWorkError];
    }
}

- (void)doHandleAuthorizedError:(NSDictionary *)error request:(OYORequest *)req {
    if (error && [error isKindOfClass:[NSDictionary class]] && [[error allKeys] containsObject:@"error"]) {
        // 退出
        if (error[@"error"] && [error[@"error"] isKindOfClass:[NSDictionary class]]) {
            if (!req.ignoreRespondError) {
                [self cancleAllRequestRespondError];
                [self cancleAllRequest];
                [self doHandleHttpError:Kickout];
            }
        }
        else {
            if (!req.ignoreRespondError && req.isNeedAuthHeader) {
                if (!self.isBarrage) {
                    [self doHandleHttpError:InvalidToken];
                    [self refreshUserToken];
                }
            }
        }
    }
    else {
        if (!req.ignoreRespondError && req.isNeedAuthHeader) {
            if (!self.isBarrage) {
                [self doHandleHttpError:InvalidToken];
                [self refreshUserToken];
            }
        }
    }
}

- (void)cancleAllRequestRespondError {
    [self.reqPoolDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[OYORequest class]]) {
            ((OYORequest *)obj).ignoreRespondError = YES;
        }
    }];
}

- (NSString *)getWholeURLString:(NSString * )URLString {
    if ([URLString hasPrefix:@"http"]) {
        return URLString;
    } else {
        return [self.sessionManager.baseURL.absoluteString stringByAppendingString:URLString];
    }
}

- (void)cancleAllRequest {
    [self.reqPoolDict removeAllObjects];
    NSArray *tasks = self.sessionManager.tasks;
    if (tasks.count != 0) {
        [self.sessionManager.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj cancel];
        }];
    }
}

- (void)cancleRequestWithInterface:(NSString *)api {
    NSArray *tasks = self.sessionManager.tasks;
    if (tasks.count != 0) {
        [self.sessionManager.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.currentRequest.URL.absoluteString containsString:api]) {
                [obj cancel];
            }
        }];
    }
}

- (void)cancleRequestWithReqKey:(NSString *)reqkey {
    if ([[self.reqPoolDict allKeys] containsObject:reqkey]) {
        OYORequest *req = self.reqPoolDict[reqkey];
        [(NSURLSessionTask *)req.reqTask cancel];
    }
}

#pragma mark - getter -
- (NSMutableDictionary *)reqPoolDict {
    if (!_reqPoolDict) {
        _reqPoolDict = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _reqPoolDict;
}

- (NSMutableDictionary *)chainReqDict {
    if (!_chainReqDict) {
        _chainReqDict = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _chainReqDict;
}

- (NSMutableDictionary *)downloadReqDict {
    if (!_downloadReqDict) {
        _downloadReqDict = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _downloadReqDict;
}

- (AFJSONRequestSerializer *)JSONSerializer {
    if (!_JSONSerializer) {
        self.JSONSerializer = [AFJSONRequestSerializer serializer];
        _JSONSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        _JSONSerializer.timeoutInterval = 30;
        _JSONSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET",@"HEAD", nil];
    }
    return _JSONSerializer;
}

- (AFHTTPRequestSerializer *)HTTPSerializer {
    if (!_HTTPSerializer) {
        self.HTTPSerializer = [AFHTTPRequestSerializer serializer];
        _HTTPSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        _HTTPSerializer.timeoutInterval = 30;
        _HTTPSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET",@"HEAD", nil];
    }
    return _HTTPSerializer;
}

- (AFJSONResponseSerializer *)jsonResponseSerializer {
    if (!_jsonResponseSerializer) {
        _jsonResponseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _jsonResponseSerializer;
}

- (AFXMLParserResponseSerializer *)xmlParserResponseSerialzier {
    if (!_xmlParserResponseSerialzier) {
        _xmlParserResponseSerialzier = [AFXMLParserResponseSerializer serializer];
    }
    return _xmlParserResponseSerialzier;
}


- (void)doApiTaskResume:(NSNotification *)notication {
    NSURLSessionDataTask *task = (NSURLSessionDataTask *)notication.object;
//    NSLog(@"-->> Resume Task:: %@",task.currentRequest);
}

- (void)doApiTaskComplect:(NSNotification *)notication {
    NSURLSessionDataTask *task = (NSURLSessionDataTask *)notication.object;
//    NSLog(@"-->> Complect Task:: %@",task.response);
}


@end




@implementation OYONetwork (specific)

- (NSString *)startJSONGET:(NSString * _Nonnull)URLString
                parameters:(nullable id)parameters
            handleComplete:(nullable OYORequestComplecteBlock)complecteBlock {
    OYORequest *req = [[OYORequest alloc] init];
    req.interface = URLString;
    req.param = parameters;
    req.reqMethod = OYOGETReqType;
    req.reqHeaderType = OYOJSONHeaderType;
    req.complecteBlock = complecteBlock;
    
    return [self dispenseTask:req].reqKey;
}

- (NSString *)startFormGET:(NSString * _Nonnull)URLString
                parameters:(nullable id)parameters
            handleComplete:(nullable OYORequestComplecteBlock)complecteBlock {
    OYORequest *req = [[OYORequest alloc] init];
    req.interface = URLString;
    req.param = parameters;
    req.reqMethod = OYOGETReqType;
    req.reqHeaderType = OYOFormHeaderType;
    req.complecteBlock = complecteBlock;
    
    return [self dispenseTask:req].reqKey;
}

- (NSString *_Nonnull)startGET:(void (^_Nonnull)(OYORequest * _Nonnull req))reqBlock
               completeHandler:(nullable OYORequestComplecteBlock)complecteBlock {
    OYORequest *req = [[OYORequest alloc] init];
    req.reqMethod = OYOGETReqType;
    req.reqHeaderType = OYOFormHeaderType;
    req.complecteBlock = complecteBlock;
    NSAssert(reqBlock, @"请先配置请求信息");
    reqBlock(req);
    return [self dispenseTask:req].reqKey;
}


- (NSString *)startJSONPOST:(NSString * _Nonnull)URLString
                 parameters:(nullable id)parameters
             handleComplete:(nullable OYORequestComplecteBlock)complecteBlock {
    OYORequest *req = [[OYORequest alloc] init];
    req.interface = URLString;
    req.param = parameters;
    req.reqMethod = OYOPOSTReqType;
    req.reqHeaderType = OYOJSONHeaderType;
    req.complecteBlock = complecteBlock;
    return [self dispenseTask:req].reqKey;
}

- (NSString *)startFormPOST:(NSString * _Nonnull)URLString
                 parameters:(nullable id)parameters
             handleComplete:(nullable OYORequestComplecteBlock)complecteBlock {
    OYORequest *req = [[OYORequest alloc] init];
    req.interface = URLString;
    req.param = parameters;
    req.reqMethod = OYOPOSTReqType;
    req.reqHeaderType = OYOFormHeaderType;
    req.complecteBlock = complecteBlock;
    
    return [self dispenseTask:req].reqKey;
}


- (NSString *_Nonnull)startPOST:(void (^_Nonnull)(OYORequest * _Nonnull req))reqBlock
                completeHandler:(nullable OYORequestComplecteBlock)complecteBlock {
    OYORequest *req = [[OYORequest alloc] init];
    req.reqMethod = OYOPOSTReqType;
    req.reqHeaderType = OYOFormHeaderType;
    req.complecteBlock = complecteBlock;
    NSAssert(reqBlock, @"请先配置请求信息");
    reqBlock(req);
    return [self dispenseTask:req].reqKey;
}


- (NSString *)startJSONDELETE:(NSString * _Nonnull)URLString
                   parameters:(nullable id)parameters
               handleComplete:(nullable OYORequestComplecteBlock)complecteBlock {
    OYORequest *req = [[OYORequest alloc] init];
    req.interface = URLString;
    req.param = parameters;
    req.reqMethod = OYODeleteReqType;
    req.reqHeaderType = OYOJSONHeaderType;
    req.complecteBlock = complecteBlock;
    
    return [self dispenseTask:req].reqKey;
}

- (NSString *)startFormDELETE:(NSString * _Nonnull)URLString
                   parameters:(nullable id)parameters
               handleComplete:(nullable OYORequestComplecteBlock)complecteBlock {
    OYORequest *req = [[OYORequest alloc] init];
    req.interface = URLString;
    req.param = parameters;
    req.reqMethod = OYODeleteReqType;
    req.reqHeaderType = OYOFormHeaderType;
    req.complecteBlock = complecteBlock;
    
    return [self dispenseTask:req].reqKey;
}



- (NSString *_Nonnull)startDELETE:(void (^_Nonnull)(OYORequest * _Nonnull req))reqBlock
                  completeHandler:(nullable OYORequestComplecteBlock)complecteBlock {
    OYORequest *req = [[OYORequest alloc] init];
    req.reqMethod = OYODeleteReqType;
    req.reqHeaderType = OYOFormHeaderType;
    req.complecteBlock = complecteBlock;
    
    NSAssert(reqBlock, @"请先配置请求信息");
    reqBlock(req);
    
    return [self dispenseTask:req].reqKey;
}


- (NSString *)startPUT:(NSString * _Nonnull)URLString
            parameters:(nullable id)parameters
        handleComplete:(nullable OYORequestComplecteBlock)complecteBlock {
    OYORequest *req = [[OYORequest alloc] init];
    req.interface = URLString;
    req.param = parameters;
    req.reqMethod = OYOPUTReqType;
    req.reqHeaderType = OYOJSONHeaderType;
    req.complecteBlock = complecteBlock;
    return [self dispenseTask:req].reqKey;
}

- (NSString *_Nonnull)startPUT:(void (^_Nonnull)(OYORequest * _Nonnull req))reqBlock
               completeHandler:(nullable OYORequestComplecteBlock)complecteBlock {
    OYORequest *req = [[OYORequest alloc] init];
    req.reqMethod = OYOPUTReqType;
    req.reqHeaderType = OYOJSONHeaderType;
    req.complecteBlock = complecteBlock;
    
    NSAssert(reqBlock, @"请先配置请求信息");
    reqBlock(req);
    return [self dispenseTask:req].reqKey;
}


- (void)startPostDownload:(NSString * _Nonnull)URLString
                    param:(id)param
                 progress:(nullable void (^)(NSProgress * _Nonnull))progressBlock
               toFilePath:(NSString *)filePath
           handleComplete:(nullable OYODownloadComplecteBlock)complecteBlock {
    [self startDownload:^(OYODownloadRequest * _Nonnull req) {
        req.interface = URLString;
        req.param = param;
        req.fileName = filePath;
        req.reqHeaderType = OYOJSONHeaderType;
        req.reqMethod = OYOPOSTReqType;
        req.progressBlock = progressBlock;
        req.downloadComplect = complecteBlock;
    }];
}

- (void)startGetDownload:(NSString * _Nonnull)URLString
                   param:(id)param
                progress:(nullable void (^)(NSProgress * _Nonnull))progressBlock
              toFilePath:(NSString *)filePath
          handleComplete:(nullable OYODownloadComplecteBlock)complecteBlock {
    [self startDownload:^(OYODownloadRequest * _Nonnull req) {
        req.interface = URLString;
        req.param = param;
        req.fileName = filePath;
        req.reqHeaderType = OYOFormHeaderType;
        req.reqMethod = OYOGETReqType;
        req.progressBlock = progressBlock;
        req.downloadComplect = complecteBlock;
    }];
}


@end
