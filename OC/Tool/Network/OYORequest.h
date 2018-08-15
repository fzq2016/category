//
//  OYORequest.h
//  OYOConsumer
//
//  Created by chengshaohua on 2018/7/9.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OYOResponse;

typedef NS_ENUM(NSInteger, OYOReqNetType) {
    OYOGETReqType,
    OYOPOSTReqType,
    OYOPUTReqType,
    OYODeleteReqType,
    OYOUploadReqType,
    OYODownloadReqType,
};

typedef NS_ENUM(NSInteger, OYOResponseSerializerType) {
    /// NSData type
    OYOResponseSerializerTypeHTTP,
    /// JSON object type
    OYOResponseSerializerTypeJSON,
    /// NSXMLParser type
    OYOResponseSerializerTypeXMLParser,
};


typedef NS_ENUM(NSInteger, OYOReqHeaderType) {
    OYOJSONHeaderType,   // 协议头
    OYOFormHeaderType,   // 表单
};

@interface OYORequest : NSObject

// 业务出错是否弹出错信息 默认为 YES
@property (nonatomic, assign) BOOL isAlertWorkError;

// 网络有问题时是否弹框提示 默认为YES
@property (nonatomic, assign) BOOL isAlertNetError;

// 是否需要添加 Auth header 默认为YES
@property (nonatomic, assign) BOOL isNeedAuthHeader;

// 401 时是否重试
@property (nonatomic, assign) BOOL unAuthRetry;

// 失败重连次数
@property (nonatomic, assign) int retryTimes;

// 重试间隔时间
@property (nonatomic, assign) int retryInterval;

// 忽略底层错误处理（ 默认不忽略 ）
@property (nonatomic, assign) BOOL ignoreRespondError;

@property (nonatomic, copy) NSString *fileName;

@property (nonatomic, assign) OYOReqNetType reqMethod;

@property (nonatomic, assign) OYOReqHeaderType reqHeaderType;

@property (nonatomic, assign) OYOResponseSerializerType responseSerializerType;

//@property (nonatomic, copy, nullable) AFConstructingBlock constructingBodyBlock;

@property (nonatomic, copy)NSString * _Nonnull interface;

@property (nonatomic, strong)id _Nullable param;

@property (nonatomic, strong)id _Nullable queryParam;

@property (nonatomic, strong)NSDictionary * _Nullable requestHeaderFields;

@property (nonatomic, strong)void (^ _Nullable progressBlock)(NSProgress * _Nullable);

@property (nonatomic, copy)void (^ _Nullable complecteBlock)(OYOResponse * _Nonnull res); // success

// 请求 Key
@property (nonatomic, copy)NSString * _Nonnull reqKey;

@property (nonatomic, strong)NSURLSessionDataTask * _Nonnull reqTask;

- (NSString *_Nonnull)wholeInterface;

@end


@interface OYOUploadRequest : OYORequest

// 0 image 1: avatar
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) UIImage * _Nonnull readyUploadImg;

@end



@interface OYODownloadRequest : OYORequest

@property (nonatomic, copy) NSString * _Nonnull toFilePath;
@property (nonatomic, copy) void (^ _Nullable downloadComplect)(OYOResponse * _Nonnull res, NSURL * _Nullable filePath);

@end


NSString * _Nonnull JOMethodWithType(OYOReqNetType type);

NSString * _Nullable const OYOKeyFromParamAndURLString(NSDictionary * _Nullable paramDic, NSString * _Nonnull url,OYOReqNetType reqType);

NSString * _Nonnull const OYOStringFromDictionary(id _Nullable paramDict);

NSString * _Nonnull const OYOStringFromArrary(id _Nullable paramAry);

NSString * _Nonnull const OYO_MD5(NSString * _Nonnull value);

