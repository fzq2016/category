//
//  UIResponder+Event.h
//  iOSBaseProject
//
//  Created by Felix on 2018/7/17.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (Event)

/**
    响应链事件传递。由最后实现该方法的类执行响应，如果没有响应者，则这个行为抛空
 
 @param name Event Name
 @param params params
 */
- (void)routerEvent:(NSString *)name
             params:(NSDictionary *)params;

@end
