//
//  UIViewController+Utils.h
//  Hugo
//
//  Created by Neo on 16/8/5.
//  Copyright © 2016年 CBN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)

+(UIViewController*) currentViewController;

- (void)showModelView:(UIView *)modelView animated:(BOOL)animated;

- (void)hideModelView:(UIView *)modelView animated:(BOOL)animated;

// 打电话
- (void)callWith:(NSString *)phone;

@end
