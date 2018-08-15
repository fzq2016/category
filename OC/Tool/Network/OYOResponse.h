//
//  OYOResponse.h
//  OYOConsumer
//
//  Created by chengshaohua on 2018/7/9.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, OYOHTTPCode) {
    OYOHTTPSuccess = 0,
    OYOHTTPWorkError,         // 业务异常
    OYOHTTPNetError,          // 网络异常
    OYOHTTPInvalidTokenError, // Token 失效
    OYOHTTPInvalidRefreshTokenError, // Token 失效
    OYOHTTPUnKnownError,      // 未知错误
};

@interface OYOResponse : NSObject

// 请求状态码
@property (nonatomic, assign) OYOHTTPCode code;

// 业务失败状态码 code 为 OYOHTTPWorkStatus 可用
@property (nonatomic, assign) NSInteger status;

// 错误信息
@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *fileName;

// 返回数据
@property (nonatomic, copy) id responseObj;

@property (nonatomic, copy) id responseData;

@property (nonatomic, copy) NSString *responseString;

+ (OYOResponse *)responseWithCode:(OYOHTTPCode)code message:(NSString *)message;

+ (OYOResponse *)responseWithCode:(OYOHTTPCode)code responseObj:(id)obj;

+ (OYOResponse *)responseWithCode:(OYOHTTPCode)code status:(NSInteger)status message:(NSString *)message;

+ (NSString *)messageMapCode:(NSInteger)code;

@end
