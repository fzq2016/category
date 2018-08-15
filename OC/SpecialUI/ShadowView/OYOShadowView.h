//
//  OYOShadowView.h
//  OYOConsumer
//
//  Created by zhanglei on 2018/8/1.
//  Copyright © 2018 www.oyohotels.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OYOShadowView : UIView

@property (nonatomic, strong) UIColor * shadowColor;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, assign) CGFloat shadowRadius;

@end
