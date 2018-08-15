//
//  OYOUtils.m
//  OYOConsumer
//
//  Created by chengshaohua on 2018/7/17.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import "OYOUtils.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <AdSupport/ASIdentifierManager.h>

@implementation OYOUtils

NSString * oyo_bundleVersion() {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

NSString * oyo_bundleShortVersion() {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

NSString * oyo_bundleIdentifier() {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

NSString * oyo_bundleName() {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

NSString * oyo_bundleDispalyName() {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

NSString * oyo_advertisingIDFA() {
    if([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    return nil;
}

void dismissKeyboard() {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

inline NSString * oyo_timeInterval() {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSString *interval = [NSString stringWithFormat:@"%lf", timeInterval];
    return [interval substringToIndex:10];
}

NSString * oyo_pathInCaches(NSString *fileName) {
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return [paths stringByAppendingPathComponent:fileName];
}

NSString * oyo_pathResource(NSString *fileName, NSString *fileType) {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    return filePath;
}

void oyo_showTost(NSString *msg) {
    oyo_showTostAction(msg, nil);
}

void oyo_showTostAction(NSString *msg,  void(^finishBlock)(void)) {
    if ([msg isKindOfClass:[NSNull class]] || msg.length == 0) {
        return;
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = kAPPDELEGATE.window;
    }
    [MBProgressHUD hideAllHUDsForView:window animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.detailsLabelText = msg;
    hud.margin = 15;
    hud.yOffset = -30;
    hud.minShowTime = 1.2;
    hud.minSize = CGSizeMake(90, 80);
    hud.detailsLabelColor = [UIColor whiteColor];
    hud.detailsLabelFont = [UIFont systemFontOfSize:14];
    hud.color = kHexRGBAlpha(0x3A3A3A, 0.85);
    hud.mode = MBProgressHUDModeText;
    hud.completionBlock = finishBlock;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.2];
}


void oyo_showTostSuccess(NSString *msg) {
    oyo_showTostSuccessAction(msg, nil);
}

void oyo_showTostSuccessAction(NSString *msg,  void(^finishBlock)(void)) {
    if ([msg isKindOfClass:[NSNull class]] || msg.length == 0) {
        return;
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD hideAllHUDsForView:window animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.detailsLabelText = msg;
    hud.margin = 15;
    hud.yOffset = -30;
    hud.minShowTime = 1.2;
    hud.minSize = CGSizeMake(90, 80);
    hud.detailsLabelFont = [UIFont systemFontOfSize:14];
    hud.detailsLabelColor = [UIColor whiteColor];
    hud.color = kHexRGBAlpha(0x3A3A3A, 0.85);
    hud.mode = MBProgressHUDModeText;
    hud.completionBlock = finishBlock;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.2];
}


void oyo_showHUD() {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow * window = [UIApplication sharedApplication].delegate.window;
        oyo_dismissHUDInView(window);
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:window];
        [window addSubview:hud];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.color = kHexRGBAlpha(0x3A3A3A, 0.85);
        hud.margin = 15;
        hud.graceTime = 0.3;
        hud.minShowTime = 0.5;
        hud.taskInProgress = YES;
        hud.removeFromSuperViewOnHide = YES;
        hud.minSize = CGSizeMake(80, 80);
        [hud show:YES];
    });
}

void oyo_dismissHUD() {
    oyo_dismissHUDInView(nil);
}


void oyo_showHUDToView(UIView *supView) {
    if (!supView) {
        supView = [UIApplication sharedApplication].delegate.window;
    }
    
    oyo_dismissHUDInView(supView);
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:supView];
    [supView addSubview:hud];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.color = kHexRGBAlpha(0x3A3A3A, 0.85);
    hud.margin = 15;
    hud.graceTime = 0.3;
    hud.minShowTime = 0.5;
    hud.taskInProgress = YES;
    hud.yOffset = -30;
    hud.minSize = CGSizeMake(80, 80);
    [hud show:YES];
}

void oyo_dismissHUDInView(UIView *supView) {
    if (!supView) {
        UIWindow * window = [UIApplication sharedApplication].delegate.window;
        supView = window;
    }
    NSArray *huds = [MBProgressHUD allHUDsForView:supView];
    for (MBProgressHUD *hud in huds) {
        hud.taskInProgress = NO;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:NO];
    }
}

void oyo_showHUDWithStatus(NSString *status) {
    if (status.length != 0) {
        UIWindow * window = [UIApplication sharedApplication].delegate.window;
        oyo_dismissHUDInView(window);
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:window];
        hud.mode = MBProgressHUDModeIndeterminate;
//        hud.alpha = 1;
        hud.color = kHexRGBAlpha(0x3A3A3A, 0.85);
        hud.margin = 15;
        hud.yOffset = -30;
        hud.graceTime = 0.5;
        hud.taskInProgress = YES;
        hud.minShowTime = 0.8;
        hud.labelText = status;
        hud.minSize = CGSizeMake(80, 80);
        [window addSubview:hud];
        [hud show:YES];
    } else {
        oyo_showHUD();
    }
}

void oyo_showAlertAction(NSString *msg, void(^sureBlock)()) {
    UIViewController *topController = oyo_topViewController();
    if (!topController) {
        topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:sureBlock]];
    [topController presentViewController:alert animated:YES completion:nil];
}


void oyo_postNotification(NSNotificationName notification) {
    if (notification.length != 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:notification object:nil];
    }
}

void oyo_postInfoNotification(NSNotificationName notification, NSDictionary *userInfo) {
    if (notification.length != 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:notification object:nil userInfo:userInfo];
    }
}

void oyo_addObserver(id observer, NSNotificationName notification, SEL selector) {
    if (notification.length != 0 && observer) {
        [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:notification object:nil];
    }
}

void oyo_removeObserver(id observer, NSNotificationName notification) {
    if (notification && notification.length != 0) {
        [[NSNotificationCenter defaultCenter] removeObserver:observer name:notification object:nil];
    }else {
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }
}

void oyo_openURL(NSURL* _Nonnull url){
    [[UIApplication  sharedApplication] openURL:url];
}

UIViewController * oyo_topViewController() {
    UIViewController *resultVC;
    NSArray * windowAry = [UIApplication sharedApplication].windows;
    __block UIWindow * keyWindow;
    if (windowAry && windowAry.count > 1) {
        [windowAry enumerateObjectsUsingBlock:^(UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIViewController * vc =  obj.rootViewController;
            if ((obj.windowLevel == UIWindowLevelNormal && vc &&
                 [vc isKindOfClass:[UITabBarController class]]) ||
                [obj isEqual:kAPPDELEGATE.window])
            {
                keyWindow = obj;
            }
        }];
    } else {
        keyWindow = [windowAry firstObject];
    }
    
    resultVC =  oyo_topRootViewController([keyWindow rootViewController]);
    while (resultVC.presentedViewController) {
        resultVC = oyo_topRootViewController(resultVC.presentedViewController);
    }
    return resultVC;
}

UIViewController * oyo_topRootViewController(UIViewController *vc) {
    if ([vc isKindOfClass:[UINavigationController class]])  {
        return oyo_topRootViewController([(UINavigationController *)vc topViewController]);
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return oyo_topRootViewController([(UITabBarController *)vc selectedViewController]);
    } else {
        return vc;
    }
    return nil;
}

@end
