//
//  AFNetwork.m
//  OYOConsumer
//
//  Created by chengshaohua on 2018/7/15.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import "AFNetwork.h"

@implementation NetTokenObj

@end


@interface AFNetwork() 

@property (nonatomic, strong) NSSet *acceptableContentTypes;
@end

@implementation AFNetwork

- (NSSet *)acceptableContentTypes {
    NSArray *contents = @[@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", @"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",@"application/pdf"];
    return kLazyLoad(_acceptableContentTypes, {
        [NSSet setWithArray:contents];
    });
}

- (void)setHttpAuthorizationHeader:(NSDictionary*)headers {
    if(!headers) return;
    
    for (NSString *key in headers) {
        [self.sessionManager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
    }
}

- (void)setHttpHeaderField:(NSDictionary * (^)(void))headerFieldBlock {
    self.headerFieldBlock = headerFieldBlock;
}

- (void)setRequestParameter:(NSDictionary * (^)(void))parameterBlock {
    self.parameterBlock = parameterBlock;
}


- (id)jsonObjWithErrorData:(NSData *)errorData {
    NSError * jsonError;
    id jsonObj;
    if (errorData) {
        jsonObj = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingAllowFragments error:&jsonError];
    }
    if (jsonError) {
        NSLog(@"%s%@",__func__, jsonError);
    }
    return jsonObj;
}

- (NSString *)errorMessageWithCode:(NSInteger)code {
    if (code == NSURLErrorCancelled) {
        return @"";
    }
    if (code == NSURLErrorUnknown || code == NSURLErrorBadURL) {
        return @"无效的URL地址";
    }else if (code == NSURLErrorTimedOut) {
        return @"网络不给力，请稍后再试";
    }else if (code == NSURLErrorUnsupportedURL) {
        return @"不支持的URL地址";
    }else if (code == NSURLErrorCannotFindHost) {
        return @"找不到服务器";
    }else if (code == NSURLErrorCannotConnectToHost) {
        return @"连接不上服务器";
    }else if (code == NSURLErrorNetworkConnectionLost) {
        return @"网络连接异常";
    }else if (code == NSURLErrorNotConnectedToInternet) {
        return @"无网络连接";
    }else {
        return @"服务器或接口异常";
    }
}

- (void)alertNetError:(NSString *)msg alert:(BOOL)isAlert {
    if (isAlert && msg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            oyo_showTost(msg);
        });
    }
}

- (void)printLogWith:(NSString *)url header:(NSDictionary *)header result:(id)result {
    NSLog(@"\n\n--- start GET request--\n--> interface : %@ \n--> header : \n%@ \n --> responseObj: \n%@", url, header, result);
}

@end
