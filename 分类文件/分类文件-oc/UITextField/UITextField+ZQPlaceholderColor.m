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

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    // 提前设置占位文字, 目的 : 让它提前创建placeholderLabel
    NSString *oldPlaceholder = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = oldPlaceholder;
    
    // 恢复到默认的占位文字颜色
    if (placeholderColor == nil) {
        placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    // 设置占位文字颜色
    [self setValue:placeholderColor forKeyPath:ZQPlaceholderColorKey];
}

//- (void)setPlaceholderColor:(UIColor *)placeholderColor
//{
//    // 提前设置占位文字, 目的 : 让它提前创建placeholderLabel
//    if (self.placeholder.length == 0) {
//        self.placeholder = @" ";
//    }
//    
//    [self setValue:placeholderColor forKeyPath:ZQPlaceholderColorKey];
//}

- (UIColor *)placeholderColor
{
    return [self valueForKeyPath:ZQPlaceholderColorKey];
}

@end
