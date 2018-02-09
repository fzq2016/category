//
//  UIView+ZQView.m
//  
//
//  Created by FZQ on 2018/2/9.
//  Copyright © 2018年 FZQ. All rights reserved.
//

#import "UIView+ZQView.h"

@implementation UIView (ZQView)

#pragma mark - 构造方法
+ (instancetype)zq_view
{
    return [[self alloc] init];
}

+ (instancetype)zq_viewFromNib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].firstObject;
}

@end
