//
//  NSString+ZQContainString.m
//  iOSBaseProject
//
//  Created by Felix on 2018/8/15.
//  Copyright © 2018年 FelixFan. All rights reserved.
//

#import "NSString+ZQContainString.h"

@implementation NSString (ZQContainString)

#pragma mark - Public selector
- (BOOL)hasSubstring:(NSString *)subString{
    if ([self rangeOfString:subString].location != NSNotFound){
        return YES;
    }
    return NO;
}


@end
