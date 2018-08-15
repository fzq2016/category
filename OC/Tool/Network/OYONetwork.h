//
//  OYONetwork.h
//  iOSBaseProject
//
//  Created by Felix on 2018/7/9.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetwork.h"
#import "OYORequest.h"
@class OYOResponse;

#define KNetWorkManager ([OYONetwork shareManager])

typedef NS_ENUM(NSInteger, OYOApiError) {
    Unknown,              // 未知的
    Kickout,              // 踢出
    InvalidToken,         // Token 失效
    InvalidRefreshToken,  // refreshToken 失效
};

typedef void (^ OYORequestComplecteBlock)(OYOResponse *res);                   // success
typedef void (^ OYODownloadComplecteBlock)(OYOResponse *res, NSURL *filePath); // success

@interface OYONetwork : AFNetwork

@property (nonatomic, assign)BOOL isCancleSendWhenExciting;

@property (nonatomic, assign)BOOL debugLogEnabled;


// instance
+ (instancetype)shareManager;

// Set base url
- (void)setNetWorkConfigWithBaseUrl:(NSString *)baseUrl;

// 获取token
- (void)setAcquireToken:(NetTokenObj * (^)(void))tokenBlock;

- (void)setCacheTokenInfo:(void (^)(id tokenObj))cacheBlock;

- (void)setHandleError:(void (^)(OYOApiError error))errorBlock;

// 0 image 1 : avatar
- (NSString * _Nonnull)startImgUpload:(void (^_Nonnull)(OYOUploadRequest * _Nonnull req))reqBlock
                       handleComplete:(nullable OYORequestComplecteBlock)complecteBlock;


- (void)startJSONUpload:(NSString * _Nonnull)URLString
             parameters:(nullable id)parameters
               progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
               fileType:(NSString * _Nonnull)fileType
               fileName:(NSString * _Nonnull)fileName
                   data:(NSData * _Nonnull)uploadData
         handleComplete:(nullable OYORequestComplecteBlock)complecteBlock;

- (NSString * _Nonnull)startDownload:(void (^_Nonnull)(OYODownloadRequest * _Nonnull req))reqBlock;

- (void)cancleAllRequest;

- (void)cancleRequestWithReqKey:(NSString * _Nullable)reqkey;

- (void)cancleAllRequestRespondError;

- (OYORequest * _Nonnull)dispenseTask:(OYORequest * _Nonnull)req;

// 刷新Token
- (void)refreshUserTokenInOverdue;

- (void)refreshUserToken;

@end


@interface OYONetwork (specific)


- (NSString * _Nonnull)startJSONGET:(NSString * _Nonnull)URLString
                         parameters:(nullable id)parameters
                     handleComplete:(nullable OYORequestComplecteBlock)complecteBlock;

- (NSString *_Nonnull)startFormGET:(NSString * _Nonnull)URLString
                        parameters:(nullable id)parameters
                    handleComplete:(nullable OYORequestComplecteBlock)complecteBlock;

- (NSString *_Nonnull)startGET:(void (^_Nonnull)(OYORequest * _Nonnull req))reqBlock
               completeHandler:(nullable OYORequestComplecteBlock)complecteBlock;


- (NSString *_Nonnull)startJSONPOST:(NSString * _Nonnull)URLString
                         parameters:(nullable id)parameters
                     handleComplete:(nullable OYORequestComplecteBlock)complecteBlock;


- (NSString *_Nonnull)startFormPOST:(NSString * _Nonnull)URLString
                         parameters:(nullable id)parameters
                     handleComplete:(nullable OYORequestComplecteBlock)complecteBlock;

- (NSString *_Nonnull)startPOST:(void (^_Nonnull)(OYORequest * _Nonnull req))reqBlock
                completeHandler:(nullable OYORequestComplecteBlock)complecteBlock;

- (NSString *_Nonnull)startJSONDELETE:(NSString * _Nonnull)URLString
                           parameters:(nullable id)parameters
                       handleComplete:(nullable OYORequestComplecteBlock)complecteBlock;

- (NSString *_Nonnull)startFormDELETE:(NSString * _Nonnull)URLString
                           parameters:(nullable id)parameters
                       handleComplete:(nullable OYORequestComplecteBlock)complecteBlock;


- (NSString *_Nonnull)startDELETE:(void (^_Nonnull)(OYORequest * _Nonnull req))reqBlock
                  completeHandler:(nullable OYORequestComplecteBlock)complecteBlock;


- (NSString *_Nonnull)startPUT:(NSString * _Nonnull)URLString
                    parameters:(nullable id)parameters
                handleComplete:(nullable OYORequestComplecteBlock)complecteBlock;


- (NSString *_Nonnull)startPUT:(void (^_Nonnull)(OYORequest * _Nonnull req))reqBlock
               completeHandler:(nullable OYORequestComplecteBlock)complecteBlock;


- (void)startPostDownload:(NSString * _Nonnull)URLString
                    param:(id _Nullable)param
                 progress:(void (^_Nullable)(NSProgress * _Nonnull))progressBlock
               toFilePath:(NSString * _Nonnull)filePath
           handleComplete:(_Nullable OYODownloadComplecteBlock)complecteBlock;

- (void)startGetDownload:(NSString * _Nonnull)URLString
                   param:(_Nullable id)param
                progress:(void (^_Nullable)(NSProgress * _Nonnull))progressBlock
              toFilePath:(NSString * _Nullable)filePath
          handleComplete:(_Nullable OYODownloadComplecteBlock)complecteBlock;


@end

