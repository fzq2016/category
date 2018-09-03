//
//  ZQIllegalValueManager.h
//  iOSBaseProject
//
//  Created by Felix on 17-4-3.
//  Copyright (c) 2017 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Get value from NSNumber or NSString safely.
 *
 */
@interface ZQIllegalValueManager : NSObject

BOOL ftIntVal(int *var, id obj);
BOOL ftUIntVal(unsigned int *var, id obj);
BOOL ftIntegerVal(NSInteger *var, id obj);
BOOL ftUIntegerVal(NSUInteger *var, id obj);
BOOL ftLongVal(long *var, id obj);
BOOL ftULongVal(unsigned long *var, id obj);
BOOL ftLongLongVal(long long *var, id obj);
BOOL ftULongLongVal(unsigned long long *var, id obj);
BOOL ftFloatVal(float *var, id obj);
BOOL ftDoubleVal(double *var, id obj);
/**
 * If #obj is a NSString instance, returns YES on encountering one of "Y",
 * "y", "T", "t", or a digit 1-9. It ignores any trailing characters.
 */
BOOL ftBoolVal(BOOL *var, id obj);
BOOL ftStringVal(NSString **var, id obj);
BOOL ftURLVal(NSURL **var, id obj);

@end

#pragma mark -- FUNCTIONS --
// verify empty string
#define kIsEmptyString(str) (([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1) ? YES : NO )

// verify empty array
#define kIsEmptyArray(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

// verify empty dictionary
#define kIsEmptyDictionary(dict) (dict == nil || [dict isKindOfClass:[NSNull class]] || dict.allKeys == 0)

// verify empty object
#define kIsEmptyObject(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))


NSString *ZQString(id obj);
NSString *ZQStringWith(id obj,NSString *placeholder);
NSInteger ZQInteger(id obj);
NSInteger ZQIntegerWith(id obj,NSInteger placeholder);
float ZQFloat(id obj);
float ZQFloatWith(id obj,float placeholder);
double ZQDouble(id obj);
double ZQDoubleWith(id obj,double placeholder);
BOOL ZQBool(id obj);
BOOL ZQBoolWith(id obj,BOOL placeholder);
BOOL isNSDictionary(id obj);
NSDictionary *ZQDictionaryWith(id obj,NSDictionary *placeholder);
BOOL isNSArray(id obj);
NSArray *ZQArrayWith(id obj,NSArray *placeholder);

NSDictionary *ZQNoneNullDictionary(id obj);
NSArray *ZQNoneNullArray(id obj);

