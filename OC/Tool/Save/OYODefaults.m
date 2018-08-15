//
//  OYODefaults.m
//  iOSBaseProject
//
//  Created by Felix on 2018/7/7.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import "OYODefaults.h"

@implementation OYODefaults

+ (void)setObject:(NSObject *)value forKey:(NSString *)key{
    if(!key || !value){
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)getForKey:(NSString *)key{
    if(!key){
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)removeForKey:(NSString *)key{
    if(!key || key.length < 1){
        return;
    }
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
