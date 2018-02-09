//
//  EnvironmentHeader.h
//  
//
//  Created by FZQ on 2018/2/9.
//  Copyright © 2018年 FZQ. All rights reserved.
//  此文件用于存放环境相关的参数

#ifndef EnvironmentHeader_h
#define EnvironmentHeader_h

//-------------------------------- 环境选择相关 -----------------------------------
// 版本检测
#define APP_ID @""
#define APP_VERSION_URL [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",APP_ID];
#define APP_DOWNLOAD_URL  [NSString stringWithFormat:@"http://itunes.apple.com/cn/app/%@",APP_ID];

// --- 友盟APPKEY --
#define UMENG_APPKEY @""

// 微信appID
#define WXApi_Key @""
#define WXApi_Secret @""

// 微博
#define Sina_Key  @""
#define Sina_Secret  @""
#define Sina_RedirectUrl  @""

// QQ
#define QQ_Key @""
#define QQ_Secret @""

// ShareSDK AppKey
#define ShareSDK_Key @""
#define ShareSDK_Secret @""

// 环信AppKey
#define EM_Key @""

// 百度地图AppKey
#define BMKMap_Key @""

// 极光推送AppKey
#define JPush_Key @""


#endif /* EnvironmentHeader_h */
