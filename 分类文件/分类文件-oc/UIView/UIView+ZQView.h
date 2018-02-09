//
//  UIView+ZQView.h
//  
//
//  Created by FZQ on 2018/2/9.
//  Copyright © 2018年 FZQ. All rights reserved.
//  该分类是UIView的创建方法

#import <UIKit/UIKit.h>

@interface UIView (ZQView)

/**
 类方法,通过alloc init创建
 
 @return 类对象
 */
+ (instancetype)zq_view;

/**
 类方法,通过xib加载view
 
 @return 类对象
 */
+ (instancetype)zq_viewFromNib;

@end
