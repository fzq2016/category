
//
//  OYOPersistenceHelper.m
//  OYOConsumer
//
//  Created by neo on 2018/7/19.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import "OYOPersistenceHelper.h"
#import "OYODefaults.h"

@implementation OYOPersistenceHelper

+ (void)saveData:(id)data filename:(NSString *)filename type:(PersistenceType)type{
    if (!data || OYOString(filename).length < 1) {
        return;
    }
    if (type == PersistenceTypeUserDefaults) {
        [OYODefaults setObject:data forKey:filename];
    }else{
        NSString *filePath = [self pathSuffix:filename type:type];
        if (type == PersistenceTypeArchive) {
            if([NSKeyedArchiver archiveRootObject:data toFile:filePath]){
                debugLog(@"Archive success -> %@",filePath);
            }else{
                debugLog(@"Archive fail -> %@",filePath);
            }
        }else if(type == PersistenceTypePlist){
            if (![[NSFileManager defaultManager] fileExistsAtPath: filePath]) {
                if ([data writeToFile:filePath atomically:true]){
                    debugLog(@"Write success -> %@",filePath);
                }
            }else{
                debugLog(@"Already exist file at -> %@",filePath);
            }
        }else if (type == PersistenceTypeJSON){
            NSData *json = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
            NSURL *url = [NSURL fileURLWithPath:filePath];
            if( [json writeToURL:url options:NSDataWritingAtomic error:nil]){
                debugLog(@"Write success -> %@",url.absoluteString);
            }else{
                debugLog(@"Write fail -> %@",url.absoluteString);
            }
        }
    }
}

+ (void)updateData:(id)data name:(NSString *)filename type:(PersistenceType)type{
    if (!data || OYOString(filename).length < 1) {
        return;
    }
    if (type == PersistenceTypeUserDefaults) {
        [OYODefaults setObject:data forKey:filename];
    }else{
        NSString *filePath = [self pathSuffix:filename type:type];
        if ([[NSFileManager defaultManager] fileExistsAtPath: filePath] && [[NSFileManager defaultManager] isDeletableFileAtPath:filename]) {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
        if (type == PersistenceTypeArchive) {
            if([NSKeyedArchiver archiveRootObject:data toFile:filePath]){
                debugLog(@"Archive success -> %@",filePath);
            }else{
                debugLog(@"Archive fail -> %@",filePath);
            }
        }else if(type == PersistenceTypePlist){
            if ([data writeToFile:filePath atomically:true]){
                debugLog(@"Write success -> %@",filePath);
            }
        }else if (type == PersistenceTypeJSON){
            NSData *json = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
            NSURL *url = [NSURL fileURLWithPath:filePath];
            if( [json writeToURL:url options:NSDataWritingAtomic error:nil]){
                debugLog(@"Write success -> %@",url.absoluteString);
            }else{
                debugLog(@"Write fail -> %@",url.absoluteString);
            }
        }
    }
}

+ (id)getData:(NSString *)filename type:(PersistenceType)type{
    if (OYOString(filename).length < 1) {
        return nil;
    }
    if (type == PersistenceTypeUserDefaults) {
        return [OYODefaults getForKey:filename];
    }else{
        NSString *filePath = [self pathSuffix:filename type:type];
        if (type == PersistenceTypeArchive) {
            return [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
        }else if(type == PersistenceTypePlist){
            if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
                if (dict) {
                    return dict;
                }
                NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
                if (array) {
                    return array;
                }
            }
        }else if (type == PersistenceTypeJSON){
            
            NSURL *url = [NSURL fileURLWithPath:filePath];
            NSData *data = [[NSData alloc] initWithContentsOfURL:url];
            id anyObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            return anyObject;
        }
    }
    return nil;
}

+ (void)removeData:(NSString *)filename type:(PersistenceType)type{
    if (type == PersistenceTypeUserDefaults) {
        [OYODefaults removeForKey:filename];
    }else{
        
        NSString *filePath = [self pathSuffix:filename type:type];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            @try
            {
                [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
            }
            @catch (NSException *exception)
            {
                debugLog( @"NSException caught %@",exception);
                return;
            }@finally {
                debugLog(@"@finally");
            }
        }
    }
}

+ (NSString *)pathSuffix:(NSString *)name type:(PersistenceType)type{
    NSString *suffix = @"";
    if (type == PersistenceTypeJSON) {
        suffix = @".json";
    }else if(type == PersistenceTypePlist){
        suffix = @".plist";
    }else if(type == PersistenceTypeArchive){
        suffix = @".archive";
    }
    NSString *folder = [NSString stringWithFormat:@"%@%@",name,suffix];
    NSString *filePath = [kDOCUMENT_FOLDER stringByAppendingPathComponent:folder];
    return filePath;
}

+ (id)getBundleData:(NSString *)filename type:(PersistenceType)type{
    NSString *suffix = @"";
    if (type == PersistenceTypeJSON) {
        suffix = @"json";
    }else if(type == PersistenceTypePlist){
        suffix = @"plist";
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:suffix];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    if (dict) {
        return dict;
    }
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
    if (array) {
        return array;
    }
    return nil;
}

@end
