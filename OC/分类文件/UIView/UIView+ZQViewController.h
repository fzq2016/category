//
//  UIView+ZQViewController.h
//  
//
//  Created by FZQ on 2018/2/9.
//  Copyright © 2018年 FZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZQViewController)

/**
 根据响应者链获取控件的控制器

 @return UIViewController
 */
- (UIViewController *)zq_viewController;

@end
