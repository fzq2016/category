//  
//  UIScrollView+Content.m
//  
//
//  Created by FZQ on 16/5/12.
//  Copyright © 2016年 FZQ. All rights reserved.


#import "UIScrollView+ZQContent.h"
#import <objc/runtime.h>

@implementation UIScrollView (Content)

#pragma mark - contentInset
- (void)setZq_insetTop:(CGFloat)zq_insetTop
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = zq_insetTop;
    self.contentInset = inset;
}

- (CGFloat)zq_insetTop
{
    return self.contentInset.top;
}

- (void)setZq_insetButtom:(CGFloat)zq_insetButtom
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = zq_insetButtom;
    self.contentInset = inset;
}

- (CGFloat)zq_insetButtom
{
    return self.contentInset.bottom;
}

- (void)setZq_insetLeft:(CGFloat)zq_insetLeft
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = zq_insetLeft;
    self.contentInset = inset;
}

- (CGFloat)zq_insetLeft
{
    return self.contentInset.left;
}

- (void)setZq_insetRight:(CGFloat)zq_insetRight
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = zq_insetRight;
    self.contentInset = inset;
}

- (CGFloat)zq_insetRight
{
    return self.contentInset.right;
}

#pragma mark - contentOffset
- (void)setZq_offsetX:(CGFloat)zq_offsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = zq_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)zq_offsetX
{
    return self.contentOffset.x;
}

- (void)setZq_offsetY:(CGFloat)zq_offsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = zq_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)zq_offsetY
{
    return self.contentOffset.y;
}

#pragma mark - contentSize
- (void)setZq_contentWidth:(CGFloat)zq_contentWidth
{
    CGSize size = self.contentSize;
    size.width = zq_contentWidth;
    self.contentSize = size;
}

- (CGFloat)zq_contentWidth
{
    return self.contentSize.width;
}

- (void)setZq_contentHeight:(CGFloat)zq_contentHeight
{
    CGSize size = self.contentSize;
    size.height = zq_contentHeight;
    self.contentSize = size;
}

- (CGFloat)zq_contentHeight
{
    return self.contentSize.height;
}
@end
