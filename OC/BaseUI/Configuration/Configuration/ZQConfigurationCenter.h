//
//  ZQConfigurationCenter.h
//  iOSBaseProject
//
//  Created by Felix on 2018/7/12.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZQTabBarController;
/*
 * 此类用来适配 tabbar 和 navigationController 以及处理 相关协议  tabbarControllerDelegate 等
 */

@interface ZQConfigurationCenter : NSObject<UITabBarControllerDelegate>

@property (nonatomic, strong) ZQTabBarController *tabbarController;

/**
    根控制器

 @return UIViewController
 */
- (UIViewController *)rootViewController;

/**
    单例

 @return ZQConfigurationCenter
 */
+ (instancetype)sharedInstance;

@end
