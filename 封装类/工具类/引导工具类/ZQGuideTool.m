//
//  ZQGuideTool.m
//  
//
//  Created by FZQ on 16/4/1.
//  Copyright © 2016年 FZQ. All rights reserved.
//

#import "ZQGuideTool.h"
#import "FZQTabBarController.h"

#pragma mark - 调试标志
#define WESTARS_DEBUG_FLAG true

#define ZQVersion (@"version")

@interface ZQGuideTool ()
{
    /** 版本管理者 */
    id<ZQGuideToolVersion> _versionManager;
}

@end

@implementation ZQGuideTool

#pragma mark - Singleton
static id _guideTool = nil;
+ (instancetype)shareGuideTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _guideTool = [[super alloc] init];
    });
    
    return _guideTool;
}

#pragma mark - public method
+ (UIViewController *)chooseRootController
{ 
    // 广告控制器
    UIViewController *adVC = nil;
    
    // 新特性控制器
    UIViewController *newFeatureVC = nil;
    
    // 主界面控制器
    UIViewController *mainRootVC = nil; 
    
    // 抽屉控制器
//    UIViewController *mvc = [[FZQTabBarController alloc] init];
//    UIViewController *lvc = [[UIViewController alloc] init];
//    UIViewController *rvc = [[UIViewController alloc] init];
//    mainRootVC = [[RESideMenu alloc] initWithContentViewController:mvc leftMenuViewController:lvc rightMenuViewController:rvc];
    
    return [[ZQGuideTool shareGuideTool] chooseRootController:adVC newFeatureVC:newFeatureVC mainRootVC:mainRootVC];
}

/** 选择窗口根控制器逻辑判断 */
- (UIViewController *)chooseRootController:(UIViewController *)adVC 
                              newFeatureVC:(UIViewController *)newFeatureVC
                                mainRootVC:(UIViewController *)mainRootVC
{
    // 广告控制器加载判断
    if ([UIApplication sharedApplication].keyWindow.rootViewController == nil && adVC!=nil)
        return adVC;
    
    // 新特性控制器加载判断
    if ([self isLoadNewFeatureVC] != NO && newFeatureVC != nil) 
        return newFeatureVC;
    
    // 返回主界面控制器,必须返回一个控制器
    if (mainRootVC == nil) mainRootVC = [[UIViewController alloc] init];
    return mainRootVC;
}

/* 添加新特性控制器 */
- (BOOL)isLoadNewFeatureVC
{
    // 获取当前app版本
    NSString *newVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    // 判断当前版本与已有版本是否一致
    NSString *oldVersion = self.diskVersion; // 获取更新前保存的版本号
    BOOL versionSameOrNot = [newVersion isEqualToString:oldVersion];
    if (versionSameOrNot == YES) return NO; // 不存在新版本，不需加载新特性控制器
    
    // 否则保存新版本号并加载新特性控制器
    [self setDiskVersion:newVersion];
    return YES;
}


#pragma mark - private method
#pragma mark version manage
- (void)setVersionManager:(id<ZQGuideToolVersion>)versionManager
{
    _versionManager = versionManager;
}

/**  版本获取  */
- (NSString *)diskVersion
{
    // 版本管理者响应了协议中的方法，按其方式获取版本号
    if ([_versionManager respondsToSelector:@selector(diskVersion)]){
        return _versionManager.diskVersion; 
    }
    
    // 没有设置版本管理者或版本获取方法或者方法不响应，用偏好设置获取版本号
    return [[NSUserDefaults standardUserDefaults] objectForKey:ZQVersion];
}

/**  保存当前版本  */
- (void)setDiskVersion: (NSString *)diskVersion
{
    // 版本管理者响应了协议中的方法，按其方式保存版本号
    if ([_versionManager respondsToSelector:@selector(setDiskVersion:)]){
        [_versionManager setDiskVersion:diskVersion];
        return ;
    }
    
    // 没有设置版本管理者或保存方法或者方法无法响应，用偏好设置保存版本号 
    [[NSUserDefaults standardUserDefaults] setObject:diskVersion forKey:ZQVersion]; 
}

@end
