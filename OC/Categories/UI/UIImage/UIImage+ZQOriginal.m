//
//  UIImage+ZQOriginal.m
//  iOSBaseProject
//
//  Created by Felix on 16/3/28.
//  Copyright © 2016年 Felix. All rights reserved.
//

#import "UIImage+ZQOriginal.h"

@implementation UIImage (ZQOriginal)

/** 返回不加渲染的图片 */
+(instancetype)zq_originalImageNamed:(NSString *)imageName{
    //加载图片
    UIImage *image = [UIImage imageNamed:imageName];
    
    //返回不加渲染的图片
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end

