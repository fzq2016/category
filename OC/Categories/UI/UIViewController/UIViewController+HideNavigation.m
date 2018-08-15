//
//  UIViewController+HideNavigation.m
//  OYOConsumer
//
//  Created by neo on 2018/7/17.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import "UIViewController+HideNavigation.h"
#import "UIImage+Helper.h"

@implementation UIViewController (HideNavigation)
@dynamic isStatusBarDefault;

- (void)hideStatus:(BOOL)isHidden{
    [UIApplication sharedApplication].statusBarHidden = isHidden;
}

-(void)setIsStatusBarDefault:(BOOL)isStatusBarDefault{
    if (isStatusBarDefault){
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
}

- (void)setStatusBackgroundColor:(UIColor *)color{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (UIStatusBarStyle)contrastingStatusBarStyleForColor:(UIColor *)backgroundColor {
    
    //Calculate Luminance
    CGFloat luminance;
    CGFloat red, green, blue;
    
    //Check for clear or uncalculatable color and assume white
    if (![backgroundColor getRed:&red green:&green blue:&blue alpha:nil]) {
        return UIStatusBarStyleDefault;
    }
    
    //Relative luminance in colorimetric spaces - http://en.wikipedia.org/wiki/Luminance_(relative)
    red *= 0.2126f; green *= 0.7152f; blue *= 0.0722f;
    luminance = red + green + blue;
    
    return (luminance > 0.6f) ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
}


- (void)hideNavigation{
    self.navigationController.navigationBar.hidden = true;
    [self.navigationController setNavigationBarHidden:true animated:true];
}

- (void)showNavigation{
    self.navigationController.navigationBar.hidden = false;
    [self.navigationController setNavigationBarHidden:false animated:true];
}

- (void)resetNavThemeColor
{
    [self setNeedsStatusBarAppearanceUpdate];
}

// 默认背景白色导航栏
- (void)resetWhiteNavigation {
    [self resetStyleNavigation:[UIColor whiteColor]];
}

- (void)resetStyleNavigation:(UIColor *)color {
    // [self setApplicationBackImage:@"bw_left_back"];
    UIColor *themeColor = [UIColor blackColor];
    [UIViewController setNavigationBarTranslucent:self.navigationController translucent:NO];
    [self.navigationController.navigationBar setTintColor:themeColor];
    [self.navigationController.navigationBar setBarTintColor:color];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:themeColor}];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self setNeedsStatusBarAppearanceUpdate];
}

// 背景透明黑字导航栏
- (void)resetClearTintNavigation:(UIColor*)backColor tint:(UIColor*)tintColor status:(UIStatusBarStyle)style {
    //    [self setApplicationBackImage:@"bw_left_back"];
    if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
        self.extendedLayoutIncludesOpaqueBars = YES;
        self.modalPresentationCapturesStatusBarAppearance = YES;
    }
    [self.navigationController.navigationBar setTintColor:backColor];        // 返回
    [UIViewController setNavigationBarTranslucent:self.navigationController translucent:YES];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:tintColor}];
    
    [UIApplication sharedApplication].statusBarStyle = style;
    [self setNeedsStatusBarAppearanceUpdate];
}

// 设置导航条背景状态
+ (void)setNavigationBarTranslucent:(UINavigationController*)navigation translucent:(BOOL)isTranslucent {
    UINavigationBar *navigationBar = navigation.navigationBar;
    if(navigationBar) {
        __block UIView *bgView;
        [navigationBar.subviews enumerateObjectsUsingBlock:^(UIView * view, NSUInteger idx, BOOL *stop) {
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")] || [view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                bgView = view;
                *stop = YES;
            }
        }];
        bgView.hidden = isTranslucent;
    }
}

- (UINavigationController *)top_navigationController {
    UINavigationController *navigation = self.navigationController;
    if ([self isKindOfClass:[UINavigationController class]]) {
        navigation = (id)self;
    } else if ([self isKindOfClass:[UITabBarController class]]) {
        navigation = [((UITabBarController*)self).selectedViewController top_navigationController];
    }
    return navigation;
}

@end
