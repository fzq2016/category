//
//  OYOUtils.h
//  iOSBaseProject
//
//  Created by Felix on 2018/7/17.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OYOUtils : NSObject

/**
 *   CFBundleVersion
 */
NSString * oyo_bundleVersion(void);

/**
 *   CFBundleShortVersionString
 */
NSString * oyo_bundleShortVersion(void);
/**
 *   CFBundleIdentifier
 */
NSString * oyo_bundleIdentifier(void);

/**
 *   CFBundleName
 */
NSString * oyo_bundleName(void);

/**
 *   IDFA
 */
NSString * oyo_advertisingIDFA(void);

/**
 *  Return the time stamp
 *
 *  @return  time stamp
 */
NSString * oyo_timeInterval(void);


/**
 Dissmiss keyboard
 */
void dismissKeyboard();

/**
 *  Return the path of file in cache directory
 *
 *  @param fileName file name
 *
 *  @return path
 */
NSString * oyo_pathInCaches(NSString * fileName);
/**
 *  Return bags resource path
 *
 *  @param fileName resource name
 *  @param fileType resource type
 *
 *  @return resource path
 */
NSString * oyo_pathResource(NSString *fileName, NSString * fileType);

#pragma mark - tost -
void oyo_showTost(NSString *msg);

void oyo_showTostAction(NSString *msg,  void(^finishBlock)(void));

void oyo_showTostSuccess(NSString *msg);

void oyo_showTostSuccessAction(NSString *msg,  void(^finishBlock)(void));

#pragma mark - HUD -
void oyo_showHUD(void);

void oyo_showHUDToView(UIView *supView);

void oyo_showHUDWithStatus(NSString *status);

void oyo_dismissHUD(void);

void oyo_dismissHUDInView(UIView *supView);

void oyo_showAlertAction(NSString *msg, void(^sureBlock)());

#pragma mark - notification -
/**
 *  发通知
 *
 */
void oyo_postNotification(NSNotificationName notification);

/**
 *  发通知带UserInfo
 *
 */
void oyo_postInfoNotification(NSNotificationName notification, NSDictionary *userInfo);

/**
 *  添加观察者
 */
void oyo_addObserver(id observer, NSNotificationName notification, SEL selector);

/**
 *  移除观察者
 */
void oyo_removeObserver(id observer, NSNotificationName notification);

/**
 *  打开外部链接
 */
void oyo_openURL(NSURL* _Nonnull url);

@end
