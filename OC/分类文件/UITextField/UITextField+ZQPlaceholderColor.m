//
//  UITextField+ZQPlaceholderColor.m
//  
//
//  Created by FZQ on 15/11/9.
//  Copyright © 2015年 FZQ. All rights reserved.
//

#import "UITextField+ZQPlaceholderColor.h"

static NSString * const ZQPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (ZQPlaceholderColor)

- (void)setZq_placeholderColor:(UIColor *)zq_placeholderColor
{
    NSString *oldPlaceholder = self.placeholder; // 记录用户设置的占位颜色
    self.placeholder = @" "; // 提前设置占位文字, 目的 : 让它提前创建placeholderLabel
    self.placeholder = oldPlaceholder;
    
    // 恢复到默认的占位文字颜色
    if (zq_placeholderColor == nil) {
        zq_placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    // 设置占位文字颜色
    [self setValue:zq_placeholderColor forKeyPath:ZQPlaceholderColorKey];
}

- (UIColor *)zq_placeholderColor
{
    return [self valueForKeyPath:ZQPlaceholderColorKey];
}

@end
