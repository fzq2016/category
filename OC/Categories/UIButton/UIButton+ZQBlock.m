//
//  UIButton+ZQBlock.m
//  IOS-Categories
//
//  Created by FZQ on 18/2/9.
//  Copyright (c) 2018年 FZQ. All rights reserved.
//

#import "UIButton+ZQBlock.h"
#import <objc/runtime.h>

static const void *UIButtonBlockKey = &UIButtonBlockKey;

@implementation UIButton (ZQBlock)

#pragma mark - public method
- (void)zq_addActionHandler:(touchedBlock)touchHandler{
    objc_setAssociatedObject(self, UIButtonBlockKey, touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(actionTouched:) forControlEvents:UIControlEventTouchUpInside];
}

+ (instancetype)zq_buttonWithType:(UIButtonType)buttonType actionHandler:(touchedBlock)touchHandler
{
    UIButton *button = [UIButton buttonWithType:buttonType];
    [button zq_addActionHandler:touchHandler];
    return button;
}

#pragma mark - private method
- (void)actionTouched:(UIButton *)btn{
    touchedBlock block = objc_getAssociatedObject(self, UIButtonBlockKey);
    if (block) {
        block(btn.tag);
    }
}
@end

