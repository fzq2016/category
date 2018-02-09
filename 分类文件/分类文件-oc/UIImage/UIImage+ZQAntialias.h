//
//  UIImage+ZQAntialias.h
//  
//
//  Created by FZQ on 16/5/12.
//  Copyright © 2016年 FZQ. All rights reserved.
//  此分类文件是用于生成抗锯齿图片

#import <UIKit/UIKit.h>

@interface UIImage (ZQAntialias)

/**
 *  在图片生成一个透明为1的像素边框
 *
 *  @return 返回一张抗锯齿图片
 */
- (UIImage *)zq_imageAntialias;

@end
