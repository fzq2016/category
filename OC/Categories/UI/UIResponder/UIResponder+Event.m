//
//  UIResponder+EEvent.m
//  OYOConsumer
//
//  Created by neo on 2018/7/17.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import "UIResponder+Event.h"

@implementation UIResponder (Event)

- (void)routerEvent:(NSString *)name params:(NSDictionary *)params{
    [self.nextResponder routerEvent:name params:params];
}

@end
