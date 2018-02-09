//
//  UIImage+ZQOriginal.h
//  
//
//  Created by FZQ on 16/3/28.
//  Copyright © 2016年 FZQ. All rights reserved.
//  不加渲染的图片
    
#import <UIKit/UIKit.h>

@interface UIImage (ZQOriginal)

/** 返回不加渲染的图片 */
+ (instancetype)zq_originalImageNamed:(NSString *)imageName;

@end
