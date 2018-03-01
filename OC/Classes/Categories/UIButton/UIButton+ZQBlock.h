//
//  UIButton+ZQBlock.h
//  
//
//  Created by FZQ on 18/2/9.
//  Copyright (c) 2018年 FZQ. All rights reserved.
//  该分类文件是用blcok设置UIButton事件触发后执行的代码

#import <UIKit/UIKit.h>

typedef void (^touchedBlock)(NSInteger tag);

@interface UIButton (ZQBlock)

/**
 通过block设置点击事件回调

 @param touchHandler 回调block
 */
- (void)zq_addActionHandler:(touchedBlock)touchHandler;


/**
 创建按钮

 @param buttonType UIButtonType
 @param touchHandler 点击事件回调
 @return UIButton
 */
+ (instancetype)zq_buttonWithType:(UIButtonType)buttonType actionHandler:(touchedBlock)touchHandler;

@end
