//
//  UIViewController+Utils.m
//  Hugo
//
//  Created by Neo on 16/8/5.
//  Copyright © 2016年 CBN. All rights reserved.
//

#import "UIViewController+Utils.h"

CGFloat const kAnimationPopBackgroundViewTag = 201821;
CGFloat const kAnimationPopModelViewTag = 2018221;

@implementation UIViewController (Utils)

+ (UIViewController*)findBestViewController:(UIViewController*)vc {
    
    if (vc.presentedViewController) {
        
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
        
    } else {
        
        // Unknown view controller type, return last child view controller
        return vc;
        
    }
    
}

- (void)callWith:(NSString *)phone
{
#if TARGET_IPHONE_SIMULATOR
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"模拟器不支持" preferredStyle:UIAlertControllerStyleAlert];
    OYOWeakSelf
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        OYOStrongSelf
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
#else
    [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:[@"tel://" stringByAppendingString:phone]]];
#endif
}

+(UIViewController*) currentViewController {
    
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
    
}

- (void)showModelView:(UIView *)modelView animated:(BOOL)animated
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [UIApplication sharedApplication].delegate.window;
    }
    
    UIView *backgroundView = [self backgroundCoverView];
    backgroundView.alpha = 0;
    [window addSubview:backgroundView];
    
    modelView.zq_y = kScreenHeight;
    modelView.tag = kAnimationPopModelViewTag;
    [window addSubview:modelView];
    [window bringSubviewToFront:modelView];
    
    if (animated) {
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             [backgroundView setAlpha:0.7];
                             modelView.zq_y = kScreenHeight - modelView.zq_height;
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    } else {
        [backgroundView setAlpha:0.7];
    }
}

- (void)hideModelView:(UIView *)modelView animated:(BOOL)animated
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [UIApplication sharedApplication].delegate.window;
    }
    
    UIView *backgroundView = [self backgroundCoverView];
    
    if (animated) {
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             [backgroundView setAlpha:0];
                             modelView.zq_y = kScreenHeight;
                         }
                         completion:^(BOOL finished) {
                             [backgroundView removeFromSuperview];
                             [modelView removeFromSuperview];
                         }];
    } else {
        [backgroundView removeFromSuperview];
        [modelView removeFromSuperview];
    }
 
}

- (UIView *)backgroundCoverView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [UIApplication sharedApplication].delegate.window;
    }
    
    UIView *backgroundView = [window viewWithTag:kAnimationPopBackgroundViewTag];
    
    if (backgroundView == nil) {
        backgroundView = [[UIView alloc]initWithFrame:window.bounds];
        backgroundView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
        backgroundView.tag = kAnimationPopBackgroundViewTag;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideModelViewGesture)];
        [backgroundView addGestureRecognizer:gesture];
    }
    return backgroundView;
}

- (void)hideModelViewGesture
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [UIApplication sharedApplication].delegate.window;
    }
    
    [self hideModelView:[window viewWithTag:kAnimationPopModelViewTag] animated:YES];
}

@end
