//
//  OYOResponse.m
//  OYOConsumer
//
//  Created by chengshaohua on 2018/7/9.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import "OYOResponse.h"

@implementation OYOResponse

+ (OYOResponse *)responseWithCode:(OYOHTTPCode)code message:(NSString *)message {
    OYOResponse *response = [[OYOResponse alloc] init];
    response.code = code;
    response.message = message;
    return response;
}

+ (OYOResponse *)responseWithCode:(OYOHTTPCode)code responseObj:(id)obj {
    OYOResponse *response = [[OYOResponse alloc] init];
    response.code = code;
    response.responseObj = obj;
    return response;
}

+ (OYOResponse *)responseWithCode:(OYOHTTPCode)code status:(NSInteger)status message:(NSString *)message {
    OYOResponse *response = [[OYOResponse alloc] init];
    response.code = code;
    response.status = status;
    response.message = message;
    return response;
}

+ (NSString *)messageMapCode:(NSInteger)code {
    NSString *messageCode = @"";
    if ([[[self dictionaryMessageOfCodeMap] allKeys] containsObject:@(code)]) {
        messageCode = [[self dictionaryMessageOfCodeMap] objectForKey:@(code)];
    }
    return messageCode;
}

- (NSString *)message {
    if (!_message || [_message isEqualToString:@""]) {
        return @"网络异常";
    }
    return _message;
}

+ (NSDictionary *)dictionaryMessageOfCodeMap {
    // 2000 UAA
    return @{@(2001):@"用户已经存在",
             @(2002):@"用户不存在",
             @(2003):@"验证码输入错误",
             @(2004):@"校验码错误",
             @(2005):@"密码错误",
             @(2006):@"密码无效",
             @(2007):@"手机号无效",
             @(2009):@"验证码无效",
             @(2011):@"邀请码无效",
             @(3007):@"该社交账号已绑定其他账户",
             @(3056):@"无操作权限",
             @(6602):@"已删除"
             };
}

@end
