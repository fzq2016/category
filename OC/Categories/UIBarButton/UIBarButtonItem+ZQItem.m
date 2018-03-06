//
//  UIBarButtonItem+ZQItem.m
//  
//
//  Created by FZQ on 9/20/15.
//  Copyright (c) 2015 FZQ. All rights reserved.
//

#import "UIBarButtonItem+ZQItem.h"

@implementation UIBarButtonItem (ZQItem)

+ (instancetype)zq_itemWithImage:(UIImage* )image action:(void(^)(void))action {
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [button setImage:image forState:UIControlStateNormal];
//    [button bk_addEventHandler:^(id sender) {
//        if (action) action();
//    } forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
