//
//  NSMutableURLRequest+ZQUpload.h
//  
//
//  Created by FZQ on 16/6/2.
//  Copyright © 2016年 FZQ. All rights reserved.
//  文件上传分类


#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (ZQUpload)

/**
 *  生成单文件上传的 multipart/form-data 请求
 *
 *  @param URL     上传地址
 *  @param fileURL 要上传的本地文件地址
 *  @param name    服务器参数名称
 *
 *  @return multipart/form-data POST 请求，保存到服务器的文件名与本地的文件名一致
 */
+ (instancetype)zq_requestWithURL:(NSURL *)URL fileURL:(NSURL *)fileURL name:(NSString *)name;

/**
 *  生成单文件上传的 multipart/form-data 请求
 *
 *  @param URL      上传地址
 *  @param fileURL  要上传的本地文件地址
 *  @param fileName 要保存在服务器上的文件名
 *  @param name     服务器参数名称
 *
 *  @return multipart/form-data POST 请求
 */
+ (instancetype)zq_requestWithURL:(NSURL *)URL fileURL:(NSURL *)fileURL fileName:(NSString *)fileName name:(NSString *)name;

/**
 *  生成多文件上传的 multipart/form-data 请求
 *
 *  @param URL      上传地址
 *  @param fileURLs 要上传的本地文件地址 数组
 *  @param name     服务器参数名称
 *
 *  @return multipart/form-data POST 请求，保存到服务器的文件名与本地的文件名一致
 */
+ (instancetype)zq_requestWithURL:(NSURL *)URL fileURLs:(NSArray *)fileURLs name:(NSString *)name;

/**
 *  生成多文件上传的 multipart/form-data 请求
 *
 *  @param URL       上传地址
 *  @param fileURLs  要上传的本地文件地址 数组
 *  @param fileNames 要保存在服务器上的文件名 数组
 *  @param name      服务器参数名称
 *
 *  @return multipart/form-data POST 请求
 */
+ (instancetype)zq_requestWithURL:(NSURL *)URL fileURLs:(NSArray *)fileURLs fileNames:(NSArray *)fileNames name:(NSString *)name;


@end
