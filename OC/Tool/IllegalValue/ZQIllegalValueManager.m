//
//  ZQIllegalValueManager.m
//  iOSBaseProject
//
//  Created by Felix on 17-4-3.
//  Copyright (c) 2017 Felix. All rights reserved.
//

#import "ZQIllegalValueManager.h"

static NSNumberFormatter *__sharedNumberFormatter = nil;

@implementation ZQIllegalValueManager

+ (void)load
{
    @autoreleasepool {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            __sharedNumberFormatter = [[NSNumberFormatter alloc] init];
        });
    }
}

@end

NSString *ZQString(id obj) {
    NSString *str = @"";
    return ZQStringWith(obj, str);
}


NSString *ZQStringWith(id obj,NSString *placeholder) {
    NSString *str = placeholder;
    ftStringVal(&str, obj);
    return str;
}



NSInteger ZQInteger(id obj) {
    NSInteger i = 0;
    return ZQIntegerWith(obj, i);
}

NSInteger ZQIntegerWith(id obj,NSInteger placeholder) {
    NSInteger i = placeholder;
    ftIntegerVal(&i, obj);
    return i;
}

float ZQFloat(id obj) {
    float f = 0.0;
    return ZQFloatWith(obj, f);
}

float ZQFloatWith(id obj,float placeholder) {
    float f = placeholder;
    ftFloatVal(&f, obj);
    return f;
}

double ZQDouble(id obj) {
    double d = 0.00000;
    return ZQDoubleWith(obj, d);
}

double ZQDoubleWith(id obj,double placeholder) {
    double d = placeholder;
    ftDoubleVal(&d, obj);
    return d;
}

BOOL ZQBool(id obj) {
    BOOL flag = FALSE;
    return ZQBoolWith(obj, flag);
}

BOOL ZQBoolWith(id obj,BOOL placeholder) {
    BOOL flag = placeholder;
    ftBoolVal(&flag, obj);
    return flag;
}

NSDictionary *ZQNoneNullDictionary(id object){
    if (isNSDictionary(object)) {
        NSDictionary *dict = (NSDictionary *)object;
        NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (obj && obj != [NSNull null] ) {
                mutableDict[key] = obj;
            }
        }];
        return mutableDict;
    }
    return nil;
}

NSArray *ZQNoneNullArray(id object){
    if (isNSArray(object)) {
        NSArray *array = (NSArray *)object;
        NSMutableArray *tempArray = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj && obj != [NSNull null] ) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *subDict = ZQNoneNullDictionary(obj);
                    if (subDict) {
                        if (![tempArray containsObject:subDict]) {
                            [tempArray addObject:subDict];
                        }
                    }
                }else if([obj isKindOfClass:[NSArray class]]){
                    NSArray *array = ZQNoneNullArray(obj);
                    if (array) {
                        if (![tempArray containsObject:array]) {
                            [tempArray addObject:array];
                        }
                    }
                }else{
                    [tempArray addObject:obj];
                }
            }
        }];
        return tempArray;
    }
    return nil;
}


NSDictionary *ZQDictionaryWith(id obj,NSDictionary *placeholder)
{
    if (!isNSDictionary(obj) || ((NSDictionary *)obj).allKeys.count == 0) {
        return placeholder;
    }
    return obj;
}

BOOL isNSDictionary(id obj)
{
    if(obj && [obj isKindOfClass:[NSDictionary class]])
        return YES;
    else
        return NO;
}

NSArray *ZQArrayWith(id obj,NSArray *placeholder){
    if (!isNSArray(obj) || ((NSArray *)obj).count == 0) {
        return placeholder;
    }
    return obj;
}

BOOL isNSArray(id obj)
{
    if(obj && [obj isKindOfClass:[NSArray class]])
        return YES;
    else
        return NO;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 
BOOL ftIntVal(int *var, id obj)
{
    if (obj && ([obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]])) {
        *var = [obj intValue];
        return YES;
    }
    return NO;
}

BOOL ftUIntVal(unsigned int *var, id obj)
{
    if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            *var = [obj unsignedIntValue];
            return YES;
        } else if ([obj isKindOfClass:[NSString class]]) {
            *var = [[__sharedNumberFormatter numberFromString:obj] unsignedIntValue];
            return YES;
        }
    }
    return NO;
}

BOOL ftIntegerVal(NSInteger *var, id obj)
{
    if (obj && ([obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]])) {
        *var = [obj integerValue];
        return YES;
    }
    return NO;
}

BOOL ftUIntegerVal(NSUInteger *var, id obj)
{
    if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            *var = [obj unsignedIntegerValue];
            return YES;
        } else if ([obj isKindOfClass:[NSString class]]) {
            *var = [[__sharedNumberFormatter numberFromString:obj] unsignedIntegerValue];
            return YES;
        }
    }
    return NO;
}

BOOL ftLongVal(long *var, id obj)
{
    if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            *var = [obj longValue];
            return YES;
        } else if ([obj isKindOfClass:[NSString class]]) {
            *var = [[__sharedNumberFormatter numberFromString:obj] longValue];
            return YES;
        }
    }
    return NO;
}

BOOL ftULongVal(unsigned long *var, id obj)
{
    if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            *var = [obj unsignedLongValue];
            return YES;
        } else if ([obj isKindOfClass:[NSString class]]) {
            *var = [[__sharedNumberFormatter numberFromString:obj] unsignedLongValue];
            return YES;
        }
    }
    return NO;
}

BOOL ftLongLongVal(long long *var, id obj)
{
    if (obj && ([obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]])) {
        *var = [obj longLongValue];
        return YES;
    }
    return NO;
}

BOOL ftULongLongVal(unsigned long long *var, id obj)
{
    if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            *var = [obj unsignedLongLongValue];
            return YES;
        } else if ([obj isKindOfClass:[NSString class]]) {
            *var = [[__sharedNumberFormatter numberFromString:obj] unsignedLongLongValue];
            return YES;
        }
    }
    return NO;
}

BOOL ftFloatVal(float *var, id obj)
{
    if (obj && ([obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]])) {
        *var = [obj floatValue];
        return YES;
    }
    return NO;
}

BOOL ftDoubleVal(double *var, id obj)
{
    if (obj && ([obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]])) {
        *var = [obj doubleValue];
        return YES;
    }
    return NO;
}


BOOL ftBoolVal(BOOL *var, id obj)
{
    if (obj && ([obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]])) {
        *var = [obj boolValue];
        return YES;
    }
    return NO;
}

BOOL ftStringVal(NSString **var, id obj)
{
    if (obj) {
        if ([obj isKindOfClass:[NSString class]]) {
            *var = obj;
            return YES;
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            *var = [obj stringValue];
            return YES;
        }
    }
    return NO;
}

BOOL ftURLVal(NSURL **var, id obj)
{
    if (obj) {
        if ([obj isKindOfClass:[NSURL class]]) {
            *var = obj;
            return YES;
        } else if ([obj isKindOfClass:[NSString class]] && ![(NSString *)obj isEqualToString:@""]) {
            *var = [NSURL URLWithString:(NSString *)obj];
            return YES;
        }
    }
    return NO;
}
