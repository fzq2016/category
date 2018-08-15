//
//  UIScrollView+ScrollViewInsets.m
//  iOSBaseProject
//
//  Created by Felix on 2018/8/4.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import "UIScrollView+ScrollViewInsets.h"
#import "UIView+ZQViewController.h"

@implementation UIScrollView (ScrollViewInsets)

- (void)resetScrollViewInsets{
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        if ([self zq_viewController] && [[self zq_viewController] respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
        {
            [self zq_viewController].automaticallyAdjustsScrollViewInsets = false;
        }
    }
}

@end
