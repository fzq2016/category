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
- (void)setZq_insetT:(CGFloat)zq_insetT
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = zq_insetT;
    self.contentInset = inset;
}

- (CGFloat)zq_insetT
{
    return self.contentInset.top;
}

- (void)setZq_insetB:(CGFloat)zq_insetB
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = zq_insetB;
    self.contentInset = inset;
}

- (CGFloat)zq_insetB
{
    return self.contentInset.bottom;
}

- (void)setZq_insetL:(CGFloat)zq_insetL
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = zq_insetL;
    self.contentInset = inset;
}

- (CGFloat)zq_insetL
{
    return self.contentInset.left;
}

- (void)setZq_insetR:(CGFloat)zq_insetR
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = zq_insetR;
    self.contentInset = inset;
}

- (CGFloat)zq_insetR
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
- (void)setZq_contentW:(CGFloat)zq_contentW
{
    CGSize size = self.contentSize;
    size.width = zq_contentW;
    self.contentSize = size;
}

- (CGFloat)zq_contentW
{
    return self.contentSize.width;
}

- (void)setZq_contentH:(CGFloat)zq_contentH
{
    CGSize size = self.contentSize;
    size.height = zq_contentH;
    self.contentSize = size;
}

- (CGFloat)zq_contentH
{
    return self.contentSize.height;
}
@end
