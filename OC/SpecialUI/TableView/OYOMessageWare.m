//
//  OYOMessageWare.m
//  OYOConsumer
//
//  Created by chengshaohua on 2018/7/5.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import "OYOMessageWare.h"

@implementation OYOMessageWare

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.middleman respondsToSelector:aSelector]) return self.middleman;
    if ([self.receiver respondsToSelector:aSelector]) return self.receiver;
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.middleman respondsToSelector:aSelector]) return YES;
    if ([self.receiver respondsToSelector:aSelector]) return YES;
    return [super respondsToSelector:aSelector];
}

@end
