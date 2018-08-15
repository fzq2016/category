//
//  NSDate+Helper.h
//  OYOConsumer
//
//  Created by neo on 2018/7/21.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helper)

+ (NSInteger)currentYear;
+ (int)currentHour;
+ (int)currentMinute;


+(NSDate *)stringToDate:(NSString *)dateString;

+(NSDate *)stringToDate:(NSString *)dateString format:(NSString *)format;


+ (int)minusDayWith:(NSDate *)firstDate last:(NSDate *)lastDate;
/**
 *
 *  通用输入输出时间格式
 *
 */

+(NSString *)dateTime:(NSString *)date toFormat:(NSString *)format;

+(NSString *)dateTime:(NSString *)date inputFormat:(NSString *)originFormat outFormat:(NSString *)format;


+(NSString *)getFormateLocalDate:(NSString *)localDate;

+ (NSString *)dateToString:(nullable NSDate *)date format:(NSString *)format;

/**
 *  当年时间->某月某日  非当年时间->某年某月某日
 */
+ (NSString *)getFormateDate:(NSDate *)localDate;



/**
 *  时间戳->时间
 */
+ (NSString *)timestampToDateStr:(NSString *)timeStamp;

/**
 *  时间->时间戳
 */
+ (NSString *)dateToTimestamp:(NSDate *)date;

/**
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+ (NSString *)compareCurrentTime:(NSDate*)compareDate;

+ (BOOL)compareCurrentEarly:(NSDate *)compareDate;



/**
 * 计算指定时间与当前的时间差
 * 栏目中的时间规则
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，10天前、3小时前、10分钟前)
 */
+(NSString *)compareCurrentDate:(NSDate*)compareDate;



- (NSString *)getWeekDayFordate;

@end
