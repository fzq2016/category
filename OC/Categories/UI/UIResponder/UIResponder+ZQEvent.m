//
//  UIResponder+ZQEvent.m
//  iOSBaseProject
//
//  Created by Felix on 2018/7/17.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import "UIResponder+ZQEvent.h"

@implementation UIResponder (ZQEvent)

- (void)routerEvent:(NSString *)name params:(NSDictionary *)params{
    [self.nextResponder routerEvent:name params:params];
}

@end
