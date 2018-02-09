//
//  NSString+ZQSubstring.h
//  
//
//  Created by FZQ on 16/6/2.
//  Copyright © 2016年 FZQ. All rights reserved.
//  该分类文件是增加获取子字符串的方法


#import <Foundation/Foundation.h>

@interface NSString (ZQSubstring)

/**
 获取子字符串

 @param str 对象字符串
 @param prefix 需删除的前缀
 @param suffix 需删除的后缀
 @return 删除后的字符串
 */
+ (NSMutableString *_Nonnull)zq_getSubstring:(id _Nonnull)str prefix:( NSString * _Nullable  )prefix suffix:( NSString *_Nullable)suffix;
@end
