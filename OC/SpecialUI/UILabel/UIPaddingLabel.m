//
//  LPaddingLabel.m
//  iOSBaseProject
//
//  Created by Felix on 25/07/2018.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import "UIPaddingLabel.h"

@implementation UIPaddingLabel

- (void)drawRect:(CGRect)rect{
    [super drawRect:UIEdgeInsetsInsetRect(rect, _padding)];
}

- (CGSize)intrinsicContentSize{
    CGSize superContentSize = super.intrinsicContentSize;
    if (superContentSize.width == 0 || superContentSize.height == 0) {
        return superContentSize;
    }
    float width = superContentSize.width + _padding.left + _padding.right;
    float height = superContentSize.height + _padding.top + _padding.bottom;
    return CGSizeMake(width, height);
}

@end
