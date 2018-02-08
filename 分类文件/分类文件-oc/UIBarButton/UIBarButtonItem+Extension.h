//
//  UIBarButtonItem+Extension.h
//  
//
//  Created by FZQ on 9/20/15.
//  Copyright (c) 2015 FZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)


/**
 UIBarButtonItem的创建方法

 @param image image
 @param action 点击后执行的回调
 @return UIBarButtonItem
 */
+ (instancetype)itemWithImage:(UIImage* )image action:(void(^)())action;

@end
