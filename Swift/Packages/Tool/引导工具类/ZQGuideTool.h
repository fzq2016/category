//
//  ZQGuideTool.h
//  
//
//  Created by ZQGuideTool on 16/4/1.
//  Copyright © 2016年 FZQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ZQGuideToolVersion <NSObject>

@required
/**  版本获取  */
- (NSString *)diskVersion;
/**  保存当前版本  */
- (void)setDiskVersion: (NSString *)diskVersion;

@end


@interface ZQGuideTool : NSObject



/**
 *  单例
 *
 *  @return ZQGuideTool单例
 */
+ (instancetype)shareGuideTool;

/**
 *  选择窗口根控制器
 *
 *  @return 窗口根控制器
 */
+ (UIViewController *)chooseRootController;

/**
 *  设置版本管理者，以用于获取当前系统版本和保存版本
 *
 *  @param versionManager 遵守ZQGuideToolVersion协议的对象，建议是保存工具类的对象
 */
- (void)setVersionManager:(id<ZQGuideToolVersion>)versionManager;


@end
