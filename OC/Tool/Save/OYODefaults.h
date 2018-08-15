//
//  OYODefaults.h
//  OYOConsumer
//
//  Created by neo on 2018/7/7.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OYODefaults: NSObject

+ (void)setObject:(NSObject *)value forKey:(NSString *)key;
+ (id)getForKey:(NSString *)key;
+ (void)removeForKey:(NSString *)key;

@end
