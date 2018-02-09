//
//  UIView+ZQViewController.m
//  
//
//  Created by FZQ on 2018/2/9.
//  Copyright © 2018年 FZQ. All rights reserved.
//

#import "UIView+ZQViewController.h"

@implementation UIView (ZQViewController)

- (UIViewController *)zq_viewController
{
    UIViewController *viewController = nil;  
    UIResponder *next = self.nextResponder;  // 根据响应者链获取该view的控制器
    while (next)
    {
        if ([next isKindOfClass:[UIViewController class]])
        {
            viewController = (UIViewController *)next;      
            break;    
        }    
        next = next.nextResponder;  
    } 
    return viewController;
}

@end
