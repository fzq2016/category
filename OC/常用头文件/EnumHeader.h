//
//  EnumHeader.h
//  
//
//  Created by FZQ on 2018/2/9.
//  Copyright © 2018年 FZQ. All rights reserved.
//  此文件用于存放全局的枚举宏

#ifndef EnumHeader_h
#define EnumHeader_h

#import <UIKit/UIKit.h>

//---------------------------- 生日  ----------------------------------
typedef NS_ENUM(NSInteger, BirthdayType) {
    BirthdayTypeGregorianCalendar = 100,          // 阳（公）历
    BirthdayTypeLunarCalendar,         // 阴（农）历
};

#endif /* EnumHeader_h */
