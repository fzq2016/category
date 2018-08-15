//
//  UIAlertController+Call.m
//  OYOConsumer
//
//  Created by lifengoyo on 2018/7/26.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import "UIAlertController+Call.h"

@implementation UIAlertController (Call)

+ (instancetype)callWithPhoneNumber:(NSString *)phone message:(NSString *)message action:(UIAlertAction *)action, ... NS_REQUIRES_NIL_TERMINATION {
    va_list arguments;
    va_start(arguments, action);
    UIAlertController *alert = [self alertControllerWithTitle:phone message:message preferredStyle:UIAlertControllerStyleAlert action:action arguments:arguments];
    va_end(arguments);
    return alert;
}

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle  action:(UIAlertAction *)action, ... NS_REQUIRES_NIL_TERMINATION{
    va_list arguments;
    va_start(arguments, action);
    UIAlertController *alert = [self alertControllerWithTitle:title message:message preferredStyle:preferredStyle action:action arguments:arguments];
    va_end(arguments);
    return alert;
}

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle  action:(UIAlertAction *)action arguments:(va_list)arguments {
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    [alter addSomeAction:action arguments:arguments];
    return alter;
}

- (void)addSomeAction:(UIAlertAction *)action, ... NS_REQUIRES_NIL_TERMINATION {
    if (action) {
        [self addAction:action];
    }
    va_list arg_list;
    va_start(arg_list, action);
    [self addSomeAction:action arguments:arg_list];
    va_end(arg_list);
}

- (void)addSomeAction:(UIAlertAction *)action arguments:(va_list)arguments {
    if (action) {
        [self addAction:action];
    }
    while ((action = va_arg(arguments, UIAlertAction *)) != nil) {
        [self addAction:action];
    }
}

+ (instancetype)defaulCallWithPhone:(NSString *)phone {
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *call = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:[@"tel://" stringByAppendingString:phone]]];
    }];
    return [self callWithPhoneNumber:phone message:nil action:cancel, call, nil];
}

@end
