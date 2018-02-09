//
//  NSString+ZQSubstring.m
//  
//
//  Created by FZQ on 16/6/2.
//  Copyright © 2016年 FZQ. All rights reserved.
//

#import "NSString+ZQSubstring.h"

@implementation NSString (ZQSubstring)

#pragma mark - substring
/* 截取字符串 */
+ (NSMutableString *_Nonnull)zq_getSubstring:(id _Nonnull)str prefix:( NSString * _Nullable  )prefix suffix:( NSString *_Nullable)suffix
{
    if (str == nil) return nil;
    
    /** 截取字符串 */
    NSMutableString *tempStr = [NSMutableString stringWithFormat:@"%@",str];

    NSRange range ;
    // 删除前缀
    if (prefix != nil) {
        range = [tempStr rangeOfString:prefix];
        if (range.length >0) [tempStr deleteCharactersInRange:range];
    }
    // 删除后缀
    if (suffix != nil) {
        range = [tempStr rangeOfString:suffix];
        if (range.length >0) [tempStr deleteCharactersInRange:range];
    }
    
    return tempStr;
}

@end
