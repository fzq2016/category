//
//  UIView+OYOIBInspectable.h
//  OYOConsumer
//
//  Created by stephen on 2018/7/21.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UIView (OYOIBInspectable)

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

- (void)shaperLayerbyRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
@end