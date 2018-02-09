//
//  UIColor+ZQUtil.h
//  
//
//  Created by FZQ on 15/11/23.
//  Copyright © 2015年 FZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZQUtil)

+ (UIColor *)zq_colorWithHex:(int)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)zq_colorWithHex:(int)hexValue;

+ (UIColor *)zq_navigationbarColor;
+ (UIColor *)zq_uniformColor;

+ (instancetype)zq_colorWithHexString: (NSString *)hex;

//+ (NSArray* )zq_colors;

@end
