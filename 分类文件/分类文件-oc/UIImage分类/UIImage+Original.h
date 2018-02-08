//
//  UIImage+Original.h
//  
//
//  Created by FZQ on 16/3/28.
//  Copyright © 2016年 FZQ. All rights reserved.
//  不加渲染的图片
    
#import <UIKit/UIKit.h>

@interface UIImage (Original)

/** 返回不加渲染的图片 */
+ (instancetype)originalImageNamed:(NSString *)imageName;

@end
