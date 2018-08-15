//
//  OYOShadowView.m
//  iOSBaseProject
//
//  Created by Felix on 2018/8/1.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import "OYOShadowView.h"

@implementation OYOShadowView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //计算要在其中绘制的矩形
    CGRect  pathRect = CGRectMake(_shadowRadius, 0, rect.size.width-_shadowRadius*2, rect.size.height-_shadowRadius*3);
//
//    //创建一个圆角矩形路径
    UIBezierPath * rectanglePath = [UIBezierPath bezierPathWithRoundedRect:pathRect cornerRadius:_shadowRadius];
//
//    //等价于保存上下文;
    CGContextSaveGState(currentContext);

    //此函数创建和应用阴影
    CGContextSetShadowWithColor(currentContext, _shadowOffset, _shadowRadius, [_shadowColor CGColor]);

    //绘制路径；它将带有一个阴影
    [[UIColor whiteColor] setFill];
    [rectanglePath fill];

//    //等价于重载上下文
    CGContextRestoreGState(currentContext);
    

}


@end
