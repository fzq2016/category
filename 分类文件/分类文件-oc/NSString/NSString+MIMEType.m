//
//  NSString+MIMEType.m
//  
//
//  Created by FZQ on 15/11/8.
//  Copyright © 2015年 FZQ. All rights reserved.
//

#import "NSString+MIMEType.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation NSString (MIMEType)

+ (NSString *)mimeTypeForFileAtPath:(NSString *)path
{
    if (![[[NSFileManager alloc] init] fileExistsAtPath:path]) {
        return nil;
    }
    
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType) {
        return @"application/octet-stream";
    }
    return (__bridge NSString *)(MIMEType);
}

+ (NSString *)getMIMETypeWithPath:(NSString *)path
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    NSHTTPURLResponse *res = nil;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&res error:nil];
//    NSLog(@"%@",res.MIMEType);
    return res.MIMEType;
}

@end
