//
//  UIView+ZQViewController.m
//  iOSBaseProject
//
//  Created by Felix on2018/2/9.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import "UIView+ZQViewController.h"

@implementation UIView (ZQViewController)

- (UIViewController *)zq_viewController
{
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder]; // 根据响应者链获取该view的控制器
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
