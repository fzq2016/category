//
//  NSDictionary+Log.h
//  
//
//  Created by FZQ on 15/11/6.
//  Copyright © 2015年 FZQ. All rights reserved.
//  多值参数和中文输出


#import <Foundation/Foundation.h>

@interface NSDictionary (Log)


/**
 多值参数和中文输出

 @param locale 本地环境
 @return 中文结果
 */
- (NSString *)descriptionWithLocale:(id)locale;

@end

@implementation NSArray (Log)


/**
 多值参数和中文输出

 @param locale 本地环境
 @return 中文结果
 */
- (NSString *)descriptionWithLocale:(id)locale;

@end

