//
//  NSDictionary+ZQLog.m
//  
//
//  Created by FZQ on 15/11/6.
//  Copyright © 2015年 FZQ. All rights reserved.
//  多值参数和中文输出


#import <Foundation/Foundation.h>

@implementation NSDictionary (ZQLog)

- (NSString *)zq_descriptionWithLocale:(id)locale
{
//    return @"小明和小红是好朋友";
    NSMutableString *string = [NSMutableString string];
  
    [string appendString:@"\n{"];
//    [string appendString:@"他们确实是好朋友"];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        [string appendFormat:@"%@:",key];
        [string appendFormat:@"%@,",obj];
    }];
    
    //尝试删除最后一个逗号
    //NSBackwardsSearch 从后往前搜索
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location !=NSNotFound) {
        [string deleteCharactersInRange:range];
    }
    
    [string appendString:@"}"];
    return string;
}
@end

@implementation NSArray (ZQLog)

- (NSString *)zq_descriptionWithLocale:(id)locale
{
    NSMutableString *string = [NSMutableString string];
    
    [string appendString:@"["];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [string appendFormat:@"%@,",obj];
    }];
    
    //尝试删除最后一个逗号
    //NSBackwardsSearch 从后往前搜索
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location !=NSNotFound) {
        [string deleteCharactersInRange:range];
    }
    
    [string appendString:@"\n]"];
    return string;
}
@end

