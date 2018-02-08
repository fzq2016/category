//
//  UIColor+Util.h
//  
//
//  Created by FZQ on 15/11/23.
//  Copyright © 2015年 FZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Util)

+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(int)hexValue;

+ (UIColor *)navigationbarColor;
+ (UIColor *)uniformColor;

+ (instancetype)colorWithHexString: (NSString *)hex;

//+ (NSArray* )colors;

@end
