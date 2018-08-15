//
//  NSString+Validate.m
//  OYOConsumer
//
//  Created by heyahui on 2018/8/6.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import "NSString+Validate.h"

@implementation NSString (Validate)

#pragma mark - public selector
+ (BOOL)validateString:(NSString *)string pattern:(NSStringValidatePattern)pattern {
    BOOL emailValid = false;
    NSString *patternString = [self getPatternStringFrom:pattern];
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:patternString options:NSRegularExpressionCaseInsensitive error:&error];
    NSRange textRange = NSMakeRange(0, string.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    if (matchRange.location != NSNotFound)
        emailValid = true;
    return emailValid;
}

+ (BOOL)isAllNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

#pragma mark - private selector
+ (NSString *)getPatternStringFrom:(NSStringValidatePattern)pattern {
    NSString *patternStirng;
    switch (pattern) {
        case NSStringValidatePatternPhoneNumber:
            patternStirng = @"^(1[0-9])\\d{9}$";
            break;
        case NSStringValidatePatternSMSCode:
            patternStirng = @"^([0-9])\\d{5}$";
            break;
        case NSStringValidatePatternEmail:
            patternStirng = @"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
            break;
        default:
            patternStirng = @"^([0-9])\\d{5}$";
            break;
    }
    return patternStirng;
}

@end
