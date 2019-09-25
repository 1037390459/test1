//
//  LXDate.h
//  LX
//
//  Created by cheng on 17/10/17.
//  Copyright © 2017年 LX Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kIsNull(a) ([a isEqualToString:@""] || a  == nil) ?YES:NO
@interface LXDate : NSObject

/**
 *  将网上获取的时间戳(秒) 转化为对应时间格式
 */
+ (NSString *)getTimeWithTimeSeconds:(NSString *)secondsString
                 andFormatWithString:(NSString *)formatString;

/**
 *  将指定日期时间转化为对应时间格式
 */
+ (NSString *)getDateTime:(NSDate *)date
         withFormatString:(NSString *)formatString;

#pragma mark -

/**
 *  根据时间戳 获取时间  （当前，**分钟前，**小时前）
 */
+ (NSString*)getTimeFormatByTimestamp:(NSTimeInterval)timestamp;

/**
 *  根据起始时间戳获取年月日时间段 (格式：yyyy.MM.dd-yyyy.MM.dd)
 */
+ (NSString*)getYearMonthDayBystartTimestamp:(NSString*)startTimestamp
                                endTimestamp:(NSString*)endTimestamp;
/**
 *  根据时间戳获取时间 （格式：月-日 上午 8：00）
 */
+ (NSString *)getFullTimeFromTimestamp:(NSTimeInterval)timestamp;
/**
 *  根据时间戳获取时间 （格式：月/日 上午）
 */
+ (NSString *)getFullTimeFromTimestamp1:(NSTimeInterval)timestamp;

/**
 *  根据时间字符串获取对应日期时间
 */
+ (NSDate *)getDateFromTimeString:(NSString *)timeString;

/**
 *  根据时间字符串格式化后转换为对应日期时间
 */
+ (NSDate *)getDateFromTimeString:(NSString *)timeString
                       withFormat:(NSString *)format;

#pragma mark - 李健凡  获取当前时间
+ (NSString *)getCurrentDate;

#pragma mark - 郑仁根  更改日期格式 YYYY/MM/dd
+ (NSString *)getShrotDateWithDate:(NSString *)dateStr;


/**
 Add By Dandre @2016.10.11

 @param dateStr 需要格式化的时间字符串 如 "2016-08-09 12:30:33"
 @param format  格式 如 "yyyy/MM/dd HH:mm:ss"

 @return 格式化后的时间字符串
 */
+ (NSString *)getDateTimeWithDateString:(NSString *)dateStr withFormatString:(NSString *)format;

/**
 *  获取本周第一天
 */
+ (NSDate *)getCurrentWeekFirstDate;

/**
 *  获取本周最后一天日期
 */
+ (NSDate *)getCurrentWeekLastDate;

/**
 *  获取本月第一天日期
 */
+ (NSDate *)getCurrentMonthFirstDate;

/*
*   日期比较 日期格式必须为yyyy-MM-dd 或者 yyyy/MM/dd
*/
+ (NSComparisonResult)compareDate:(NSString*)date1 withDate:(NSString*)date2;

/*
 *  日期 时间比较 日期格式必须为yyyy-MM-dd HH:mm 或者 yyyy/MM/dd HH:mm
 */
+ (NSComparisonResult)compareDateAndTime:(NSString*)date1 withDate:(NSString*)date2;

/**
 * 判断两个日期是否在同一周
 */
+ (BOOL)isInSameWorkDateOne:(NSDate *)dateOne dateTwo:(NSDate *)dateTwo;

/**
 * 是否是正确的日期格式  2017-02-02  YES 2017-02-30 false
 */
+ (BOOL)isValidDateStr:(NSString *)dateStr;

/**
   获取当期时间戳
 */
+(NSString *)getNowTimeTimestamp;
@end
