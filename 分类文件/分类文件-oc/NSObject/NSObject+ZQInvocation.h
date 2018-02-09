//
//  NSObject+ZQInvocation.h
//  
//
//  Created by FZQ on 16/6/2.
//  Copyright © 2016年 FZQ. All rights reserved.
//  调用多值参数方法



#import <Foundation/Foundation.h>

@interface NSObject (ZQInvocation)


/**
 调用方法（多个参数）

 @param aSelector 调用方法
 @param objects 参数数组
 @return 任意对象
 */
- (id)zq_performSelector:(SEL)aSelector withObjects:(NSArray *)objects;

@end
