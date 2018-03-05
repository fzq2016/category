//
//  ZQLocalization.h
//  
//
//  Created by FZQ on 10/13/15.
//  Copyright © 2015 FZQ. All rights reserved.
//  该类是用于国际化的

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZQLocalizationSimplifiedChinese,    // 简体中文
    ZQLocalizationEnglish,  // 英文
//    ZQLocalizationTraditionalChinese, // 繁体英文
} ZQLocalizationLanguage;

UIKIT_EXTERN NSString * const ZQLanguageSimplifiedChinese;
UIKIT_EXTERN NSString * const ZQLanguageEnglish;
UIKIT_EXTERN NSString * const LocalizationChinese;
UIKIT_EXTERN NSString * const LocalizationEnglish;

#define LOC_KEY_VALUE(__key,__value) [[ZQLocalization defaultLocalization] localizedStringForKey:__key value:__value]


@interface ZQLocalization : NSObject


/**
    单例

 @return ZQLocalization
 */
+ (instancetype)defaultLocalization;


/**
    获取当前国际化语言
 */
+ (NSString *)getCurrentLanguage;


/**
    设置新的国际化语言
 */
+ (void)setNewLanguage:(ZQLocalizationLanguage)language;

/**
    返回国际化结果值

 @param key key
 @return 根据当前语言返回的value
 */
- (NSString *)localizedStringForKey:(NSString *)key;


/**
    返回国际化结果值

 @param key key
 @param value value
 @return 根据当前语言返回的value
 */
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value;


/**
    判断语言是否为指定语言

 @return 判断语言是否为指定语言
 */
+ (BOOL)languageIsEnglish;
+ (BOOL)languageIsSimplifiedChinese;

@end


