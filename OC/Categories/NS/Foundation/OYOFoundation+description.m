//
//  OYOFoundation+description.m
//  iOSBaseProject
//
//  Created by Felix on 2018/7/24.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

static inline void oyo_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation NSString (OYOUnicode)

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

@implementation NSArray (OYOUnicode)

+ (void)load {
    Class class = [self class];
    oyo_swizzleSelector(class, @selector(description), @selector(oyo_description));
    oyo_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(oyo_descriptionWithLocale:));
    oyo_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(oyo_descriptionWithLocale:indent:));
}

/**
 *  可以把以下的方法放到一个NSObject的category中
 *  然后在需要的类中进行swizzle
 *  但是又觉得这样太粗暴了。。。。
 */

- (NSString *)oyo_description {
    return [[self oyo_description] stringByReplaceUnicode];
}

- (NSString *)oyo_descriptionWithLocale:(nullable id)locale {
    return [[self oyo_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)oyo_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self oyo_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSDictionary (OYOUnicode)

+ (void)load {
    Class class = [self class];
    oyo_swizzleSelector(class, @selector(description), @selector(oyo_description));
    oyo_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(oyo_descriptionWithLocale:));
    oyo_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(oyo_descriptionWithLocale:indent:));
}

- (NSString *)oyo_description {
    return [[self oyo_description] stringByReplaceUnicode];
}

- (NSString *)oyo_descriptionWithLocale:(nullable id)locale {
    return [[self oyo_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)oyo_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self oyo_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSSet (OYOUnicode)

+ (void)load {
    Class class = [self class];
    oyo_swizzleSelector(class, @selector(description), @selector(oyo_description));
    oyo_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(oyo_descriptionWithLocale:));
    oyo_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(oyo_descriptionWithLocale:indent:));
}

- (NSString *)oyo_description {
    return [[self oyo_description] stringByReplaceUnicode];
}

- (NSString *)oyo_descriptionWithLocale:(nullable id)locale {
    return [[self oyo_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)oyo_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self oyo_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end
