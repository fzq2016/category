//
//  NSDictionary+ZQPropertyList.h
//  
//
//  Created by FZQ on 15/11/8.
//  Copyright © 2015年 FZQ. All rights reserved.
//  快速生成Model属性列表


#import <Foundation/Foundation.h>

@interface NSDictionary (ZQPropertyList)

/**
    解析API数据，整理成指定格式的@property关键字属性
 */
- (void)zq_createPropertyList;

/**
    将字典写入到桌面plist中，用于调试API数据

 @param plistName 写入的plist名
 */
- (void)zq_writeToMacDeskPlistWithPlistName:(NSString *)plistName;

@end
