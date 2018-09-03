//
//  ZQDefaults.h
//  iOSBaseProject
//
//  Created by Felix on 2018/7/7.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZQDefaults: NSObject

+ (void)setObject:(NSObject *)value forKey:(NSString *)key;
+ (id)getForKey:(NSString *)key;
+ (void)removeForKey:(NSString *)key;

@end
