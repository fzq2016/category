//
//  OYOConfigurationCenter.h
//  iOSBaseProject
//
//  Created by Felix on 2018/7/12.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OYOTabBarController;
/*
 * 此类用来适配 tabbar 和 navigationController 以及处理 相关协议  tabbarControllerDelegate 等
 */

@interface OYOConfigurationCenter : NSObject<UITabBarControllerDelegate>

@property (nonatomic, strong) OYOTabBarController *tabbarController;

/**
    根控制器

 @return UIViewController
 */
- (UIViewController *)rootViewController;

/**
    单例

 @return OYOConfigurationCenter
 */
+ (instancetype)sharedInstance;

@end
