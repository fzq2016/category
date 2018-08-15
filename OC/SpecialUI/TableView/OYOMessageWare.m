//
//  OYOMessageWare.m
//  iOSBaseProject
//
//  Created by Felix on 2018/7/5.
//  Copyright © 2018年 Felix. All rights reserved.
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
