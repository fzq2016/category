//
//  UIBarButtonItem+ZQItem.h
//  iOSBaseProject
//
//  Created by Felix on 9/20/15.
//  Copyright (c) 2015 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZQItem)

/**
 UIBarButtonItem的创建方法

 @param image image
 @param action 点击后执行的回调
 @return UIBarButtonItem
 */
+ (instancetype)zq_itemWithImage:(UIImage* )image action:(void(^)(void))action;

@end
