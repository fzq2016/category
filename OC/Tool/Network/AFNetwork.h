//
//  AFNetwork.h
//  OYOConsumer
//
//  Created by chengshaohua on 2018/7/15.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "OYOUtils.h"

#define NOTIFICATION_LOGIN @"oyo_notification_login"
#define NOTIFICATION_SIGN_UP @"oyo_notification_sign_up"
#define NOTIFICATION_LOGOUT @"oyo_notification_logout"
#define NOTIFICATION_ACCESS_TOKEN @"oyo_notification_access_token"


typedef void (^ requestSuccessBlock) (id response);                            // success
typedef void (^ requestFailureBlock) (NSError *error);                         // failed

@interface NetTokenObj : NSObject

@property (nonatomic, copy) NSString * accessToken;
@property (nonatomic, copy) NSString * refreshToken;
@property (nonatomic, assign) NSTimeInterval expires_in;

@end


@protocol NetworkPortocol

@optional

- (NetTokenObj*)networkAccessToken;
- (NSDictionary*)networkHeaderFields;
- (NSDictionary*)networkParameters;

@end


@interface AFNetwork : NSObject

@property (nonatomic, strong)AFHTTPSessionManager *sessionManager;
@property (nonatomic, copy)NSDictionary *(^headerFieldBlock)(void);
@property (nonatomic, copy)NSDictionary *(^parameterBlock)(void);

- (NSSet *)acceptableContentTypes;

- (void)setHttpAuthorizationHeader:(NSDictionary*)headers;

- (void)setHttpHeaderField:(NSDictionary * (^)(void))headerFieldBlock;

// 设置参数
- (void)setRequestParameter:(NSDictionary * (^)(void))parameterBlock;

- (id)jsonObjWithErrorData:(NSData *)errorData;
- (NSString *)errorMessageWithCode:(NSInteger)code;
- (void)alertNetError:(NSString *)msg alert:(BOOL)isAlert;

@end
