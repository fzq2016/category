//
//  UIView+ZQFrame.h
//  
//
//  Created by FZQ on 15/11/6.
//  Copyright © 2015年 FZQ. All rights reserved.
//  

#import "UIView+ZQFrame.h"


@implementation UIView (ZQFrame)

#pragma mark - x set、get方法实现
- (void)setZq_x:(CGFloat)zq_x
{
    CGRect frame = self.frame;
    frame.origin.x = zq_x;
    self.frame = frame;
}

- (CGFloat)zq_x
{
    return self.frame.origin.x;
}

#pragma mark - y set、get方法实现
- (void)setZq_y:(CGFloat)zq_y
{
    CGRect frame = self.frame;
    frame.origin.y = zq_y;
    self.frame = frame;
}

- (CGFloat)zq_y
{
    return self.frame.origin.y;
}

#pragma mark - width set、get方法实现
- (void)setZq_width:(CGFloat)zq_width
{
    CGRect bounds = self.bounds;
    bounds.size.width = zq_width;
    self.frame = bounds;
}

- (CGFloat)zq_width
{
    return self.bounds.size.width;
}

#pragma mark - height set、get方法实现
- (void)setZq_height:(CGFloat)zq_height
{
    CGRect bounds = self.bounds;
    bounds.size.height = zq_height;
    self.bounds = bounds;
}

- (CGFloat)zq_height
{
    return self.bounds.size.height;
}

#pragma mark - centerX set、get方法实现
- (void)setZq_centerX:(CGFloat)zq_centerX
{
    CGPoint center = self.center;
    center.x = zq_centerX;
    self.center = center;
}

- (CGFloat)zq_centerX
{
    return self.center.x;
}

#pragma mark - centerY set、get方法实现
- (void)setZq_centerY:(CGFloat)zq_centerY
{
    CGPoint center = self.center;
    center.x = zq_centerY;
    self.center = center;
}

- (CGFloat)zq_centerY
{
    return self.center.y;
}

#pragma mark - top set、get方法实现
- (void)setZq_top:(CGFloat)zq_top
{
    self.zq_y = zq_top;
}

- (CGFloat)zq_top
{
    return self.zq_y; 
}

#pragma mark - leading set、get方法实现
- (void)setZq_leading:(CGFloat)zq_leading
{
    self.zq_x = zq_leading;
}

- (CGFloat)zq_leading
{
    return self.zq_x; 
}

#pragma mark - bottom set、get方法实现
- (void)setZq_bottom:(CGFloat)zq_bottom
{
    self.zq_y = zq_bottom - self.zq_height;
}

- (CGFloat)zq_bottom
{
    return self.zq_y + self.zq_height; 
}

#pragma mark - trailing set、get方法实现
- (void)setZq_trailing:(CGFloat)zq_trailing
{
    self.zq_x = zq_trailing - self.zq_width;
}

- (CGFloat)zq_trailing
{
    return self.zq_x + self.zq_width; 
}

@end
