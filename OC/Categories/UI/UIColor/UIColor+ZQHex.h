//
//  UIColor+Hex.h
//  iOSBaseProject
//
//  Created by Felix on 15/12/15.
//  Copyright © 2015年 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/**
    从十六进制数字获取颜色

 @param hexValue 十六进制数字
 @param alpha alpha，默认为1
 @return UIColor
 */
+ (UIColor *)zq_colorWithHex:(int)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)zq_colorWithHex:(int)hexValue;

/**
    从十六进制字符串获取颜色

 @param hexString 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 @param alpha alpha，默认为1
 @return UIColor
 */
+ (UIColor *)zq_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
+ (UIColor *)zq_colorWithHexString:(NSString *)hexString;

@end
