//
//  OYOPersistenceHelper.h
//  OYOConsumer
//
//  Created by neo on 2018/7/19.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, PersistenceType) {
    PersistenceTypeUserDefaults = 0,
    PersistenceTypeArchive = 1,
    PersistenceTypeJSON = 2,
    PersistenceTypePlist = 3,
    PersistenceTypeNone = 3,
} ;
@interface OYOPersistenceHelper : NSObject

+ (void)saveData:(id)data
        filename:(NSString *)filename
            type:(PersistenceType)type;

+ (id)getData:(NSString *)filename
         type:(PersistenceType)type;

+ (void)updateData:(id)data
              name:(NSString *)filename
              type:(PersistenceType)type;

+ (void)removeData:(NSString *)filename
              type:(PersistenceType)type;

+ (id)getBundleData:(NSString *)filename
               type:(PersistenceType)type;


@end
