//
//  UIView+ZQFrame.h
//  
//
//  Created by FZQ on 15/11/6.
//  Copyright © 2015年 FZQ. All rights reserved.
//  

#import <UIKit/UIKit.h>


@interface UIView (ZQFrame)

/** 生成set、get方法声明 */
@property(nonatomic,assign) CGFloat zq_x;
@property(nonatomic,assign) CGFloat zq_y;
@property(nonatomic,assign) CGFloat zq_width;
@property(nonatomic,assign) CGFloat zq_height;
@property(nonatomic,assign) CGFloat zq_centerX;
@property(nonatomic,assign) CGFloat zq_centerY;
@property(nonatomic,assign) CGFloat zq_top;
@property(nonatomic,assign) CGFloat zq_leading;//左
@property(nonatomic,assign) CGFloat zq_bottom;
@property(nonatomic,assign) CGFloat zq_trailing;//右

@end

/**
- frame分类（UIView的分类），在.h文件通过@property声明（只会声明，不会生成属性并实现）width,height,x,y,centerX,centerY;
- 分类不能定义属性，这里使用@property不是标准的点语法，仅是方法的调用，并不是对属性赋值和取出属性值。
- 重写set方法，封装frame三步式（取出、修改、重新赋值）
- 然后重写get方法（例如：return self.bounds.size.width），方便获取；
*/
