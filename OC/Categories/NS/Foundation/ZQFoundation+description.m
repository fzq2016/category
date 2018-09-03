//
//  ZQFoundation+description.m
//  iOSBaseProject
//
//  Created by Felix on 2018/7/24.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

static inline void zq_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation NSString (ZQUnicode)

- (NSString *)stringByReplaceUnicode {
    NSMutableString *convertedString = [self mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U"
                                     withString:@"\\u"
                                        options:0
                                          range:NSMakeRange(0, convertedString.length)];
    
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    return convertedString;
}

@end

@implementation NSArray (ZQUnicode)

+ (void)load {
    Class class = [self class];
    zq_swizzleSelector(class, @selector(description), @selector(zq_description));
    zq_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(zq_descriptionWithLocale:));
    zq_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(zq_descriptionWithLocale:indent:));
}

/**
 *  可以把以下的方法放到一个NSObject的category中
 *  然后在需要的类中进行swizzle
 *  但是又觉得这样太粗暴了。。。。
 */

- (NSString *)zq_description {
    return [[self zq_description] stringByReplaceUnicode];
}

- (NSString *)zq_descriptionWithLocale:(nullable id)locale {
    return [[self zq_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)zq_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self zq_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSDictionary (ZQUnicode)

+ (void)load {
    Class class = [self class];
    zq_swizzleSelector(class, @selector(description), @selector(zq_description));
    zq_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(zq_descriptionWithLocale:));
    zq_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(zq_descriptionWithLocale:indent:));
}

- (NSString *)zq_description {
    return [[self zq_description] stringByReplaceUnicode];
}

- (NSString *)zq_descriptionWithLocale:(nullable id)locale {
    return [[self zq_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)zq_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self zq_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSSet (ZQUnicode)

+ (void)load {
    Class class = [self class];
    zq_swizzleSelector(class, @selector(description), @selector(zq_description));
    zq_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(zq_descriptionWithLocale:));
    zq_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(zq_descriptionWithLocale:indent:));
}

- (NSString *)zq_description {
    return [[self zq_description] stringByReplaceUnicode];
}

- (NSString *)zq_descriptionWithLocale:(nullable id)locale {
    return [[self zq_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)zq_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self zq_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end
