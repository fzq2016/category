//
//  UIImage+ZQAntialias.m
//  
//
//  Created by FZQ on 16/5/12.
//  Copyright © 2016年 FZQ. All rights reserved.


#import "UIImage+ZQAntialias.h"

@implementation UIImage (ZQAntialias)

// 在周边加一个边框为1的透明像素
- (UIImage *)zq_imageAntialias
{
    CGFloat border = 1.0f;
    CGRect rect = CGRectMake(border, border, self.size.width - 2 *border, self.size.height - 2 * border);
    
    UIImage *img = nil;
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(CGSizeMake(rect.size.width,rect.size.height));
    
    // 绘制图片
    [self drawInRect:CGRectMake(-1, -1, self.size.width, self.size.height)];
    
    // 获取图片
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(self.size);
    [img drawInRect:rect];
    UIImage* antiImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return antiImage;
}

@end
