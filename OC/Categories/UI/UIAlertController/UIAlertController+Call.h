//
//  UIAlertController+Call.h
//  iOSBaseProject
//
//  Created by Felix on 2018/7/26.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallHandler)(NSString *phone);
@interface UIAlertController (Call)

+ (instancetype)callWithPhoneNumber:(NSString *)phone message:(NSString *)message action:(UIAlertAction *)action, ... NS_REQUIRES_NIL_TERMINATION;

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle  action:(UIAlertAction *)action, ... NS_REQUIRES_NIL_TERMINATION;

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle  action:(UIAlertAction *)action arguments:(va_list)arguments;

- (void)addSomeAction:(UIAlertAction *)action, ... NS_REQUIRES_NIL_TERMINATION;

- (void)addSomeAction:(UIAlertAction *)action arguments:(va_list)arguments;

+ (instancetype)defaulCallWithPhone:(NSString *)phone;

@end
