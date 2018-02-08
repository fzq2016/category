//  
//  UIScrollView+Content.h
//  
//
//  Created by FZQ on 16/5/12.
//  Copyright © 2016年 FZQ. All rights reserved.
//  此分类是为UIScrollView增加快速修改或获取边距、滚动距离、偏移量成员属性的分类


#import <UIKit/UIKit.h>

@interface UIScrollView (Content)
@property (assign, nonatomic) CGFloat zq_insetT;
@property (assign, nonatomic) CGFloat zq_insetB;
@property (assign, nonatomic) CGFloat zq_insetL;
@property (assign, nonatomic) CGFloat zq_insetR;

@property (assign, nonatomic) CGFloat zq_offsetX;
@property (assign, nonatomic) CGFloat zq_offsetY;

@property (assign, nonatomic) CGFloat zq_contentW;
@property (assign, nonatomic) CGFloat zq_contentH;
@end
