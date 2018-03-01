//
//  ZQLocalization.m
//
//
//  Created by FZQ on 10/13/15.
//  Copyright © 2015 FZQ. All rights reserved.
//

#import "ZQLocalization.h"

#define AppLanguage @"appLanguage"

NSString * const ZQLanguageSimplifiedChinese = @"简体中文";
NSString * const ZQLanguageEnglish = @"English";
NSString * const LocalizationBase = @"Base";
NSString * const LocalizationChinese = @"zh-Hans";
NSString * const LocalizationEnglish = @"en";

@interface ZQLocalization ()

// 语言文件包路径
@property (nonatomic, strong) NSBundle *bundle;

// 国际化语言简码
@property (nonatomic, strong) NSString *localization;

@end



@implementation ZQLocalization

#pragma mark - 单例
+ (instancetype)defaultLocalization {
    static ZQLocalization *localization;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        localization = [[ZQLocalization alloc] init];
        
    });
    return localization;
}

#pragma mark - 构造函数
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    // 读取本地语言偏好设置
    NSString *appLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:AppLanguage];
    if (!appLanguage.length) {  // 偏好设置为空时，跟随系统语言设置，如果支持则采用该系统语言，否则统一采用简体中文

        // （iOS获取的语言字符串比较不稳定）目前框架只处理en、zh-Hans、zh-Hant三种情况，其他按照系统默认处理
        appLanguage = [NSLocale preferredLanguages].firstObject;
        if ([appLanguage hasPrefix:LocalizationEnglish]) {
                appLanguage = LocalizationEnglish;
        } else if ([appLanguage hasPrefix:@"zh"]) {
//            if ([appLanguage rangeOfString:@"Hans"].location != NSNotFound) {
                appLanguage = LocalizationChinese; // 简体中文
//            }
//            else { // zh-Hant\zh-HK\zh-TW
//                appLanguage = @"zh-Hant"; // 暂时不提供繁體中文版本
//            }
        } else {
            appLanguage = LocalizationChinese;
        }
    }
    
    // 设置语言，保存编好设置，并获取语言文本路径（必须要采用点语法）
    self.localization = appLanguage;
}

#pragma mark - 国际化语言简码设置
- (void)setLocalization:(NSString *)localization {
    
    if ([_localization isEqualToString:localization]) { return; }
    
    // 更改语言
    _localization = localization;
    [[NSUserDefaults standardUserDefaults] setObject:localization forKey:AppLanguage];
    [[NSUserDefaults standardUserDefaults] synchronize];

    // 更改语言文件路径
    _bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:localization ofType:@"lproj"]];
    
}

#pragma mark - 语言
+ (void)setNewLanguage:(ZQLocalizationLanguage)language
{
    ZQLocalization *localization = [ZQLocalization defaultLocalization];
    // 根据语言设置国际化语言简码
    switch (language) {
        case ZQLocalizationSimplifiedChinese:
            localization.localization = LocalizationChinese;
            break;
        case ZQLocalizationEnglish:
            localization.localization = LocalizationEnglish;
            break;
        default:
            localization.localization = LocalizationChinese;
            break;
    }
    
    // 重新设置根控制器
    [[ZQLocalization defaultLocalization] resetRootViewController];
}

+ (NSString *)getCurrentLanguage
{
    ZQLocalization *localization = [ZQLocalization defaultLocalization];
    if ([localization.localization isEqualToString:LocalizationEnglish])
        return ZQLanguageEnglish;
    
    return ZQLanguageSimplifiedChinese;
}

+ (BOOL)languageIsEnglish
{
    return [self judgeWhetherLanguage:ZQLocalizationEnglish];
}

+ (BOOL)languageIsSimplifiedChinese
{
    return [self judgeWhetherLanguage:ZQLocalizationSimplifiedChinese];
}

+ (BOOL)judgeWhetherLanguage:(ZQLocalizationLanguage)language
{
    ZQLocalization *localization = [ZQLocalization defaultLocalization];
    // 根据语言简码判断是否是指定语言 
    switch (language) {
        case ZQLocalizationSimplifiedChinese:
            return [localization.localization isEqualToString: LocalizationChinese];
        case ZQLocalizationEnglish:
            return [localization.localization isEqualToString: LocalizationEnglish];
        default:
            return [localization.localization isEqualToString: LocalizationChinese];
    }
}

#pragma mark - 获取国际化字符串
- (NSString *)localizedStringForKey:(NSString *)key {
    return [self localizedStringForKey:key value:nil];
}
    
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value
{
    return [_bundle localizedStringForKey:key value:value table:nil];
}

// 重新设置
- (void)resetRootViewController
{
    // 这里添加需要初始化的控制器。包括登录控制器，窗口的根控制器。如果主界面是一个抽屉控制器，也需要重新设置
}

// 方案一：若想让MJRefresh跟随项目语言改变，需要手工导入该框架，并用下述代码覆盖NSBundle+MJRefresh.h对应的方法代码
//+ (NSString *)mj_localizedStringForKey:(NSString *)key value:(NSString *)value
//{
//    // 唯圈项目中国际化：跟随项目语言国际化,所以在"NSBundle+WCRefresh.h"覆盖了该方法，默认是简体中文
//    // 读取本地语言偏好设置
//    static NSBundle *bundle = nil;
//    static NSString *appLanguage = nil;
//    NSString *newLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"];    // 偏好存储的语言
//    
//    if (![appLanguage isEqualToString:newLanguage]) {   // 若修改了语言
//        appLanguage = newLanguage;
//        
//        if (appLanguage.length == 0) {  // 没有存储语言，则去获取系统语言
//            // （iOS获取的语言字符串比较不稳定）目前框架只处理en、zh-Hans、zh-Hant三种情况，其他按照系统默认处理
//            appLanguage = [NSLocale preferredLanguages].firstObject;
//            if ([appLanguage hasPrefix:@"en"]) {
//                appLanguage = @"en";
//            } else if ([appLanguage hasPrefix:@"zh"]) {
//                if ([appLanguage rangeOfString:@"Hans"].location != NSNotFound) {
//                    appLanguage = @"zh-Hans"; // 简体中文
//                }
//                else { // zh-Hant\zh-HK\zh-TW
//                    appLanguage = @"zh-Hant"; // 暂时不提供繁體中文版本
//                }
//            } else {
//                appLanguage = @"zh-Hans";
//            }
//        }
//        // 从MJRefresh.bundle中查找资源
//        bundle = [NSBundle bundleWithPath:[[NSBundle mj_refreshBundle] pathForResource:appLanguage ofType:@"lproj"]];
//    }
//    value = [bundle localizedStringForKey:key value:value table:nil];
//    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
//}
// 方案二：在MJRefresh中下拉一个分支，用上述代码替换原代码。pod的时候不再直接pod MJRefresh,而是pod新的分支。该方案需要动态的追踪合并MJRefresh的修改

@end
