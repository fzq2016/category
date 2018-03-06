//
//  NSDictionary+ZQLog.h
//  
//
//  Created by FZQ on 15/11/6.
//  Copyright © 2015年 FZQ. All rights reserved.
//  多值参数和中文输出


#import <Foundation/Foundation.h>

@interface NSDictionary (ZQLog)


/**
 多值参数和中文输出

 @param locale 本地环境
 @return 中文结果
 */
- (NSString *)zq_descriptionWithLocale:(id)locale;

@end

@interface NSArray (ZQLog)


/**
 多值参数和中文输出

 @param locale 本地环境
 @return 中文结果
 */
- (NSString *)zq_descriptionWithLocale:(id)locale;

@end

