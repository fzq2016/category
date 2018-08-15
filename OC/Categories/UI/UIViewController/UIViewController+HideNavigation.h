//
//  UIViewController+HideNavigation.h
//  OYOConsumer
//
//  Created by neo on 2018/7/17.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (HideNavigation)

//基础设置
@property (nonatomic, assign) BOOL isStatusBarDefault;

- (void)hideNavigation;
- (void)showNavigation;
- (void)hideStatus:(BOOL)isHidden;
- (void)setStatusBackgroundColor:(UIColor *)color;
- (UIStatusBarStyle)contrastingStatusBarStyleForColor:(UIColor *)backgroundColor;

@end
