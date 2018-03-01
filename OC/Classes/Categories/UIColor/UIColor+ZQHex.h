//
//  UIColor+Hex.h
//  
//
//  Created by FZQ on 15/12/15.
//  Copyright © 2015年 FZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

// 默认alpha位1
+ (UIColor *)zq_colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)zq_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
