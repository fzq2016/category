//
//  NSObject+ZQInvocation.m
//  
//
//  Created by FZQ on 16/6/2.
//  Copyright © 2016年 FZQ. All rights reserved.


#import "NSObject+ZQInvocation.h"

@implementation NSObject (ZQInvocation)


- (id)zq_performSelector:(SEL)aSelector withObjects:(NSArray *)objects
{
    SEL selector = aSelector;
    
    //1.创建一个方法签名
    //不能直接使用methodSignatureForSelector方法来创建
    //1.需要告诉这个方法属于谁 ViewController
    //2.方法 SEL
    //方法的名称|参数个数|返回值的类型|返回值的长度
    NSMethodSignature *methodSignature = [[self class] instanceMethodSignatureForSelector:selector];
    
    NSLog(@"%@",methodSignature);
    if (methodSignature == nil) {
        
//       @throw [NSException exceptionWithName:@"小码哥错误" reason:@"方法不存在" userInfo:nil];
        
        [NSException raise:@"出错了" format:@"%@方法不存在",NSStringFromSelector(selector)];
        
//        return nil;
    }
    
    //2.创建NSInvocation
    //要传递方法签名
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    invocation.target = self;
    invocation.selector = selector;

    NSInteger count1 = methodSignature.numberOfArguments - 2;
    NSInteger count2 = objects.count;
    NSInteger count = MIN(count1, count2);
    //获取参数格式
    for (NSInteger i =0; i<count; i++) {
        id obj = objects[i];
        
        [[obj class]isKindOfClass:[NSNumber class]];
        
//         [methodSignature getArgumentTypeAtIndex:2];
        
        //设置参数
        [invocation setArgument:&obj atIndex:i+2];
    }
    
    //3.调用该方法
    [invocation invoke];
    
    id result = nil;
//    NSLog(@"%s---%zd",methodSignature.methodReturnType,methodSignature.methodReturnLength);
    
    if (methodSignature.methodReturnLength >0) {
         [invocation getReturnValue:&result];
    }

    return result;
}


@end
