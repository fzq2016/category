//
//  NSString+ZQValidate.h
//  iOSBaseProject
//
//  Created by Felix on 2018/8/6.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NSStringValidatePattern) {
    NSStringValidatePatternPhoneNumber, //校验是否是手机号
    NSStringValidatePatternSMSCode,     //校验是否是验证码
    NSStringValidatePatternEmail,       //校验是否是邮箱
};

@interface NSString (ZQValidate)


/**
 获取输入的字符串是否合法

 @param string 输入的字符串
 @param pattern 需要校验的格式
 @return 返回是否合法
 */
+ (BOOL)validateString:(NSString *)string pattern:(NSStringValidatePattern)pattern;

+ (BOOL)isAllNum:(NSString *)checkedNumString;

@end
