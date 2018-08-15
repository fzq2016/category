//
//  OYORequest.m
//  iOSBaseProject
//
//  Created by Felix on 2018/7/9.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import "OYORequest.h"
#import <CommonCrypto/CommonDigest.h>


@implementation OYORequest

- (instancetype)init {
    if (self = [super init]) {
        self.isAlertWorkError = YES;
        self.isNeedAuthHeader = YES;
        self.isAlertNetError = YES;
    }
    return self;
}

// 重写debugDescription, 而不是description
- (NSString *)debugDescription {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [self valueForKey:name]?:@"nil";
        [dictionary setObject:value forKey:name];
    }
    free(properties);
    return [NSString stringWithFormat:@"<%@: %p> -- %@",[self class],self,dictionary];
}

- (NSString *_Nonnull)wholeInterface {
    return @"";
}

- (void)dealloc {
    NSLog(@"-->> dealloc OYORequest:: %s",__func__);
}

@end


@implementation OYOUploadRequest
@end


@implementation OYODownloadRequest
@end


NSString * OYOMethodWithType(OYOReqNetType type) {
    switch (type) {
        case OYOGETReqType: {
            return @"GET";
        }
            break;
        case OYOPOSTReqType: {
            return @"POST";
        }
            break;
        case OYOUploadReqType: {
            return @"Upload";
        }
            break;
        case OYODownloadReqType: {
            return @"Download";
        }
            break;
        default:
            return @"";
            break;
    }
}

inline NSString * const OYOKeyFromParamAndURLString(NSDictionary * paramDic, NSString * url,OYOReqNetType reqType) {
    NSMutableString * keyMutableString = [NSMutableString string];
    [keyMutableString appendString:url];
    [keyMutableString appendString:OYOMethodWithType(reqType)];
    if (!paramDic) {
        return OYO_MD5(keyMutableString);
    }
    if ([paramDic isKindOfClass:[NSString class]]) {
        [keyMutableString appendString:(NSString *)paramDic];
    }
    else if ([paramDic isKindOfClass:[NSDictionary class]]) {
        [keyMutableString appendString:OYOStringFromDictionary(paramDic)];
    }
    else if ([paramDic isKindOfClass:[NSArray class]]) {
        [keyMutableString appendString:OYOStringFromArrary(paramDic)];
    }
    return OYO_MD5(keyMutableString);
}

inline NSString * const OYOStringFromDictionary(id paramDict) {
    NSArray *keys = [paramDict allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSMutableString *keyMutableString = [NSMutableString string];
    for (NSInteger index = 0; index < sortedArray.count; index++) {
        NSString *key = [sortedArray objectAtIndex:index];
        NSString *value = [paramDict objectForKey:key];
        if ([value isKindOfClass:[NSDictionary class]]) {
            value = OYOStringFromDictionary((NSDictionary *)value);
        }
        
        if ([value isKindOfClass:[NSArray class]]) {
            value = OYOStringFromArrary(value);
        }
        
        if (index == 0) {
            [keyMutableString appendFormat:@"%@=%@",key,value];
        }
        else {
            [keyMutableString appendFormat:@"|%@=%@",key,value];
        }
    }
    return keyMutableString;
}

inline NSString * const OYOStringFromArrary(id paramAry) {
    if (((NSArray *)paramAry).count == 0) {
        return @"";
    }
    NSMutableString *keyMutableString = [NSMutableString string];
    for (NSInteger index = 0; index < ((NSArray *)paramAry).count; index++) {
        NSString *value = [paramAry objectAtIndex:index];
        if ([value isKindOfClass:[NSDictionary class]]) {
            value = OYOStringFromDictionary((NSDictionary *)value);
        }
        
        if ([value isKindOfClass:[NSArray class]]) {
            value = OYOStringFromArrary((NSArray *)value);
        }
        
        if (index == 0) {
            [keyMutableString appendFormat:@"%@",value];
        }
        else {
            [keyMutableString appendFormat:@"|%@",value];
        }
    }
    return keyMutableString;
}

inline NSString * const OYO_MD5(NSString *value) {
    const char *str = [value UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *md5Str = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return md5Str;
}

