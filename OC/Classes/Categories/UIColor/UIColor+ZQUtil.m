//
//  UIColor+ZQUtil.m
//  
//
//  Created by FZQ on 15/11/23.
//  Copyright © 2015年 FZQ. All rights reserved.
//

#import "UIColor+ZQUtil.h"

@implementation UIColor (ZQUtil)

+ (UIColor *)zq_colorWithHex:(int)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)zq_colorWithHex:(int)hexValue
{
    return [UIColor zq_colorWithHex:hexValue alpha:1.0];
}


#pragma mark - theme colors

+ (UIColor *)zq_navigationbarColor
{
    return [UIColor zq_colorWithHex:0x0a5090];
}

+ (UIColor *)zq_uniformColor
{
    return [UIColor colorWithRed:235.0/255 green:235.0/255 blue:243.0/255 alpha:1.0];
}

+ (instancetype)zq_colorWithHexString: (NSString *)hex
{
    //去掉前后空格换行符
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) return [UIColor whiteColor];
    
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    } else if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    
    if ([cString length] != 6) return [UIColor whiteColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

//+ (NSArray *)zq_colors {
//    return @[
//             RGBHex(@"#A0F4B2"),
//             RGBHex(@"#9FF2F4"),
//             RGBHex(@"#A5CAF7"),
//             RGBHex(@"#A3B2F6"),
//             RGBHex(@"#EEE2AA"),
//             RGBHex(@"#DECC85"),
//             RGBHex(@"#BEC3C7"),
//             RGBHex(@"#F4C600"),
//             RGBHex(@"#EA7E00"),
//             RGBHex(@"#B8BC00"),
//             RGBHex(@"#75C5D6"),
//             RGBHex(@"#306056"),
//             ];
//}


@end
