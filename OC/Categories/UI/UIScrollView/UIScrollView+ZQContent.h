//  
//  UIScrollView+Content.h
//  
//
//  Created by FZQ on 16/5/12.
//  Copyright © 2016年 FZQ. All rights reserved.
//  此分类是为UIScrollView增加快速修改或获取边距、滚动距离、偏移量成员属性的分类


#import <UIKit/UIKit.h>

@interface UIScrollView (Content)
@property (assign, nonatomic) CGFloat zq_insetTop;  // 上边距
@property (assign, nonatomic) CGFloat zq_insetButtom;   // 下边距
@property (assign, nonatomic) CGFloat zq_insetLeft; // 左边距
@property (assign, nonatomic) CGFloat zq_insetRight;    // 右边距

@property (assign, nonatomic) CGFloat zq_offsetX;
@property (assign, nonatomic) CGFloat zq_offsetY;

@property (assign, nonatomic) CGFloat zq_contentWidth;
@property (assign, nonatomic) CGFloat zq_contentHeight;
@end
