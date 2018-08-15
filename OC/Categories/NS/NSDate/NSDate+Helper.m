//
//  NSDate+Helper.m
//  OYOConsumer
//
//  Created by neo on 2018/7/21.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import "NSDate+Helper.h"

/**
常用时间格式
输入：
yyyy-MM-dd'T'HH:mm:ssZ
yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ   2015-04-28T10:55:11.988+08:00


输出：
yyyy-MM-dd HH:mm:ss
MM/dd/yy hh:mm tt
YYYYMMddHHmm

**/

@implementation NSDate (Helper)

+ (NSInteger)currentYear
{
    NSDate * senddate = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    NSDateComponents *conponent = [cal components:unitFlags fromDate:senddate];
    NSInteger year=[conponent year];
    return year;
}

+ (int)currentHour
{
    NSDate *senddate = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitHour|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    NSDateComponents * conponent = [cal components:unitFlags fromDate:senddate];
    int result = (int)[conponent hour];
    return result;
}

+ (int)currentMinute{
    NSDate * senddate = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitMinute|NSCalendarUnitHour|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    NSDateComponents * conponent = [cal components:unitFlags fromDate:senddate];
    int result = (int)[conponent minute];
    return result;
}

+ (int)minusDayWith:(NSDate *)firstDate last:(NSDate *)lastDate{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:lastDate  toDate:firstDate  options:0];
    int days = [comps day];
    NSLog(@"天数===%d",days);
    return days;
}

+(NSDate *)stringToDate:(NSString *)dateString
{
    return [self stringToDate:dateString format:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
}

+(NSDate *)stringToDate:(NSString *)dateString format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:format];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:dateString];
    return dateFormatted;
}

- (NSString *)getWeekDayFordate
{
    NSInteger week = [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
    NSArray *weekdays = @[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六",@"周日"];
    return weekdays[week - 1];
}

/**
 *
 *  通用输入时间格式处理
 *
 */

+(NSString *)dateTime:(NSString *)date inputFormat:(NSString *)originFormat outFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:originFormat];
    // 本地时区
    //NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    //[dateFormatter setTimeZone:localTimeZone];
    // 东京零度时区
    // NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    // [dateFormatter setTimeZone:timeZone];
    //输出格式
    NSDate *dateFormatted = [dateFormatter dateFromString:date];
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

+(NSString *)dateTime:(NSString *)date toFormat:(NSString *)format
{
    return [self dateTime:date inputFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ" outFormat:format];
}

+(NSString *)getFormateLocalDate:(NSString *)localDate
{
    return  [self dateTime:localDate toFormat:@"MM月dd日"];
}

+ (NSString *)dateToString:(nullable NSDate *)date format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    dateFormatter.locale = locale;
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}
/**
 *  当年时间->某月某日  非当年时间->某年某月某日
 */
+ (NSString *)getFormateDate:(NSDate *)localDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString * yearDate = [formatter stringFromDate:localDate];
    NSString *result;
    if ( [yearDate integerValue] == [self currentYear]) {
        [formatter setDateFormat:@"MM月dd日"];
    }else{
        [formatter setDateFormat:@"yyyy年MM月dd日"];
    }
    result = [formatter stringFromDate:localDate];
    return result;
}


/**
 *  时间戳->时间
 */
+ (NSString *)timestampToDateStr:(NSString *)timeStamp
{
    //NSString *timeStamp = @"1400682049";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *showtimeNew = [formatter stringFromDate:date]; //输出转换后的时间
    return showtimeNew;
}

/**
 *  时间->时间戳
 */
+ (NSString *)dateToTimestamp:(NSDate *)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    NSString *timestamp = [NSString stringWithFormat:@"%ld",(long)[localeDate timeIntervalSince1970]];
    NSLog(@"date: %@ timeSp: %@",localeDate,timestamp);
    return timestamp;
}

/**
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+(NSString *)compareCurrentTime:(NSDate*)compareDate
{
    NSTimeInterval timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) < 60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    else if((temp = temp/60) < 24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if((temp = temp/24) < 30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else if((temp = temp/30) < 12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return result;
}

+ (BOOL)compareCurrentEarly:(NSDate *)compareDate
{
    NSTimeInterval timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
        return false;
    }
    else if((temp = timeInterval/60) < 60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
        return false;
    }
    
    else if((temp = temp/60) < 24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
        return false;
    }
    
    else if((temp = temp/24) < 30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
        return true;
    }
    else if((temp = temp/30) < 12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
        return true;
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
        return true;
    }
    return true;
}

/**
 * 计算指定时间与当前的时间差
 * 栏目中的时间规则
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，10天前、3小时前、10分钟前)
 */
+(NSString *)compareCurrentDate:(NSDate*)compareDate
{
    NSTimeInterval timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"1分钟前"];
    }
    else if((temp = timeInterval/60) < 60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = temp/60) < 24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else {
        temp = temp/24;
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    return result;
}

@end
