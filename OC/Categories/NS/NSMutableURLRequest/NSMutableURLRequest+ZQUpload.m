//
//  NSMutableURLRequest+ZQUpload.m
//  
//
//  Created by FZQ on 16/6/2.
//  Copyright © 2016年 FZQ. All rights reserved.


#import "NSMutableURLRequest+ZQUpload.h"

@implementation NSMutableURLRequest (ZQUpload)

/****** 单文件上传-服务器的文件名与本地的文件名一致 *****/
+ (instancetype)zq_requestWithURL:(NSURL *)URL fileURL:(NSURL *)fileURL name:(NSString *)name {
    
    // 调用“多文件上传-服务器的文件名与本地的文件名一致”方法
    return [self zq_requestWithURL:URL fileURLs:@[fileURL] name:name];
}

/****** 单文件上传-服务器的文件名自定义 *****/
+ (instancetype)zq_requestWithURL:(NSURL *)URL fileURL:(NSURL *)fileURL fileName:(NSString *)fileName name:(NSString *)name {
    
    // 调用“多文件上传-服务器的文件名自定义”方法
    return [self zq_requestWithURL:URL fileURLs:@[fileURL] fileNames:@[fileName] name:name];
}

/****** 多文件上传-服务器的文件名与本地的文件名一致 *****/
+ (instancetype)zq_requestWithURL:(NSURL *)URL fileURLs:(NSArray *)fileURLs name:(NSString *)name {
    
    // 遍历要上传的本地文件，获取文件名作为服务器的文件名
    NSMutableArray *fileNames = [NSMutableArray arrayWithCapacity:fileURLs.count];
    [fileURLs enumerateObjectsUsingBlock:^(NSURL *fileURL, NSUInteger idx, BOOL *stop) {
        [fileNames addObject:fileURL.path.lastPathComponent];
    }];
    
    // 调用“多文件上传-服务器的文件名自定义”方法
    return [self zq_requestWithURL:URL fileURLs:fileURLs fileNames:fileNames name:name];
}

#pragma mark - core code(核心代码)
/****** 多文件上传-服务器的文件名自定义 *****/
+ (instancetype)zq_requestWithURL:(NSURL *)URL fileURLs:(NSArray *)fileURLs fileNames:(NSArray *)fileNames name:(NSString *)name {
    // 由url创建可变request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    // 设置请求方式
    request.HTTPMethod = @"POST";
    
    // 拼接数据
    NSMutableData *data = [NSMutableData data];
    NSString *boundary = multipartFormBoundary(); // 自定义函数
    
    if (fileURLs.count > 1) {
        name = [name stringByAppendingString:@"[]"];
    }
    
    [fileURLs enumerateObjectsUsingBlock:^(NSURL *fileURL, NSUInteger idx, BOOL *stop) {
        NSString *bodyStr = [NSString stringWithFormat:@"\n--%@\n", boundary];
        [data appendData:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSString *fileName = fileNames[idx];
        bodyStr = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\" \n", name, fileName];
        [data appendData:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[@"Content-Type: application/octet-stream\n\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[NSData dataWithContentsOfURL:fileURL]];
        
        [data appendData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    
    NSString *tailStr = [NSString stringWithFormat:@"--%@--\n", boundary];
    [data appendData:[tailStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    request.HTTPBody = data;
    
    NSString *headerString = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:headerString forHTTPHeaderField:@"Content-Type"];
    
    return request;
}

static NSString * multipartFormBoundary() {
    return [NSString stringWithFormat:@"Boundary+%08X%08X", arc4random(), arc4random()];
}
@end
