//
//  NSString+MIMEType.h
//  
//
//  Created by FZQ on 15/11/8.
//  Copyright © 2015年 FZQ. All rights reserved.
//  获得文件的MIMEType

#import <Foundation/Foundation.h>

@interface NSString (MIMEType)

+ (NSString *)mimeTypeForFileAtPath:(NSString *)path;
+ (NSString *)getMIMETypeWithPath:(NSString *)path;

@end
