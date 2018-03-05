//
//  UIImage+ZQStretchable.m
//  
//
//  Created by FZQ on 15/6/23.
//  Copyright (c) 2015年 FZQ. All rights reserved.
//

#import "UIImage+ZQStretchable.h"

@implementation UIImage (ZQStretchable)

+ (instancetype)zq_stretchableImageNamed:(NSString *)name
{
    //加载图片
    UIImage *bg = [self imageNamed:name];
    
    //返回伸缩保护后的图片
    return [bg stretchableImageWithLeftCapWidth:bg.size.width * 0.5 topCapHeight:bg.size.height * 0.5];
}

@end
