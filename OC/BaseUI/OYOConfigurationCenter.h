//
//  OYOConfigurationCenter.h
//  OYOConsumer
//
//  Created by willson on 2018/7/12.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OYOTabBarController;
/*
 * 此类用来适配 tabbar 和 navigationController 以及处理 相关协议  tabbarControllerDelegate 等
 */

@interface OYOConfigurationCenter : NSObject<UITabBarControllerDelegate>

@property (nonatomic, strong) OYOTabBarController *tabbarController;

- (UIViewController *)rootViewController;

+ (instancetype)sharedInstance;
@end
