//
//  UIViewController+Utils.h
//  iOSBaseProject
//
//  Created by Felix on 16/8/5.
//  Copyright © 2016年 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)

+(UIViewController*) currentViewController;

- (void)showModelView:(UIView *)modelView animated:(BOOL)animated;

- (void)hideModelView:(UIView *)modelView animated:(BOOL)animated;

// 打电话
- (void)callWith:(NSString *)phone;

@end
