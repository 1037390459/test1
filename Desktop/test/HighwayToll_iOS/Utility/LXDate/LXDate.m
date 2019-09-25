//
//  LXDate.m
//  LX
//
//  Created by cheng on 17/10/16.
//  Copyright © 2017年 CarWins Inc. All rights reserved.
//

#import "LXDate.h"

@implementation LXDate


//将网上获取的时间戳(秒) 转化为对应时间格式
+ (NSString *)getTimeWithTimeSeconds:(NSString *)secondsString andFormatWithString:(NSString *)formatString
{
    NSTimeInterval seconds = secondsString.integerValue;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    return [self getDateTime:date withFormatString:formatString];
}

//将指定日期时间转化为对应时间格式
+ (NSString *)getDateTime:(NSDate *)date withFormatString:(NSString *)formatString
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = formatString;
    NSString *timeStr = [df stringFromDate:date];
    return timeStr;
}

+ (NSString *)getTimeFormatByTimestamp:(NSTimeInterval)timestamp
{
    NSString * now =  LXCulture(@"当前");
    NSString * min =  LXCulture(@"分钟前");
    NSString * hour = LXCulture(@"小时前");
    NSString * day = LXCulture(@"天前");
    NSString * month = LXCulture(@"月前");
    if (timestamp>0) {
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970]- timestamp;
        
        if (time<60) {
            return  now;
        }
        else if (time<3600)
        {
            return [NSString stringWithFormat:@"%.0f%@", time/60,min];
        }
        else if (time<3600*24)
        {
            return [NSString stringWithFormat:@"%.0f%@", time/3600,hour];
        }
        else if (time<3600*24*30)
        {
            return  [NSString stringWithFormat:@"%.0f%@", time/(3600*24),day];
        }
        else
        {
            return  [NSString stringWithFormat:@"%.0f%@", time/(3600*24*30),month];
        }
        
    }
    return @"";
    
}

+ (NSString*)getYearMonthDayBystartTimestamp:(NSString *)startTimestamp endTimestamp:(NSString *)endTimestamp
{
    NSString *startTime =[LXDate getTimeWithTimeSeconds:startTimestamp andFormatWithString:@"yyyy.MM.dd"];
    NSString *endTime =[LXDate getTimeWithTimeSeconds:endTimestamp andFormatWithString:@"yyyy.MM.dd"];
    NSString *newTime =[NSString stringWithFormat:@"%@-%@",startTime,endTime];
    
    return newTime;
}

+ (NSString *)getFullTimeFromTimestamp:(NSTimeInterval)timestamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setAMSymbol:LXCulture(@"上午")];
    [formatter setPMSymbol:LXCulture(@"下午")];
    [formatter setDateFormat:@"MM-dd hh:mm"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *dateString = [formatter stringFromDate:date];

    return dateString;
}

+ (NSString *)getFullTimeFromTimestamp1:(NSTimeInterval)timestamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setAMSymbol:LXCulture(@"上午")];
    [formatter setPMSymbol:LXCulture(@"下午")];
    [formatter setDateFormat:@"MM/dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *dateString = [formatter stringFromDate:date];

    return dateString;
}

+ (NSDate *)getDateFromTimeString:(NSString *)timeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter dateFromString:timeString];
}

+ (NSDate *)getDateFromTimeString:(NSString *)timeString withFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:timeString];
}

+ (NSString *)getCurrentDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)getShrotDateWithDate:(NSString *)dateStr{
    if (kIsNull(dateStr)) {
        return @"";
    }
    else{
        NSString* timeStr = [dateStr timeTransformWhenReduction];
#pragma mark - modefied by lone 2016 - 10- 11
        return [[timeStr componentsSeparatedByString:@" "]firstObject];
    }
}

+ (NSString *)getDateTimeWithDateString:(NSString *)dateStr withFormatString:(NSString *)format
{
    if (kIsNull(dateStr)) {
        return @"";
    }
    else{
        NSString* timeStr = [dateStr timeTransformWhenReduction];
        NSDate *date  = [LXDate getDateFromTimeString:timeStr];
        timeStr =  [LXDate getDateTime:date withFormatString:format];
        
        return timeStr;
    }
}

#pragma mark - 获取本周第一天
+ (NSDate *)getCurrentWeekFirstDate
{
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    // 获取几天是几号
    NSInteger day = [comp day];
    
    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff;
//    long firstDiff,lastDiff;n modified by lone lastDiff 没有用到
    //    weekDay = 1;
    if (weekDay == 1)
    {
        firstDiff = -6;
//        lastDiff = 0;
    }
    else
    {
        firstDiff = [calendar firstWeekday] - weekDay + 1;
//        lastDiff = 8 - weekDay;
    }
    
    // 在当前日期(去掉时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    

    return firstDayOfWeek;
}

#pragma mark - 获取本周最后一天日期
+ (NSDate *)getCurrentWeekLastDate
{
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday
                                         fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    // 获取几天是几号
    NSInteger day = [comp day];
    
    // 计算当前日期和本周的星期一和星期天相差天数
    long lastDiff;
//    long firstDiff,lastDiff; modified by lone firstDiff 无用
    //    weekDay = 1;
    if (weekDay == 1)
    {
//        firstDiff = -6;
        lastDiff = 0;
    }
    else
    {
//        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 8 - weekDay;
    }
    
    // 在当前日期(去掉时分秒)基础上加上差的天数
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                                fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];
    
    return lastDayOfWeek;
}

#pragma mark - 获取本月第一天日期
+ (NSDate *)getCurrentMonthFirstDate
{
    NSDate *nowDate = [NSDate date];
    double interval = 0;
    NSDate *beginDate = nil;
//    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //    [calendar setFirstWeekday:1];//设定周日为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth
                          startDate:&beginDate
                           interval:&interval
                            forDate:nowDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
//        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return nil;
    }
    
    return beginDate;
}

#pragma mark - 日期比较 日期格式必须为yyyy-MM-dd 或者 yyyy/MM/dd
+ (NSComparisonResult)compareDate:(NSString*)date1 withDate:(NSString*)date2{
    
    date1 = [[[date1 stringByReplacingOccurrencesOfString:@"/" withString:@"-"] componentsSeparatedByString:@" "] firstObject];
    date2 = [[[date2 stringByReplacingOccurrencesOfString:@"/" withString:@"-"] componentsSeparatedByString:@" "] firstObject];
    
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *dta = [dateformater dateFromString:date1];
    NSDate *dtb = [dateformater dateFromString:date2];
    NSComparisonResult result = [dta compare:dtb];
    return result;
}

#pragma mark - 日期比较 日期格式必须为yyyy-MM-dd HH:mm 或者 yyyy/MM/dd HH:mm
+ (NSComparisonResult)compareDateAndTime:(NSString *)date1 withDate:(NSString *)date2
{
    date1 = [date1 stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    date2 = [date2 stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *dta = [dateformater dateFromString:date1];
    NSDate *dtb = [dateformater dateFromString:date2];
    NSComparisonResult result = [dta compare:dtb];
    return result;
}

#pragma mark - 判断两个日期是否在同一周
+ (BOOL)isInSameWorkDateOne:(NSDate *)dateOne dateTwo:(NSDate *)dateTwo
{
    //日期间隔大于七天之间返回NO
    if (fabs([dateOne timeIntervalSinceDate:dateTwo]) >= 7 * 24 *3600)
    {
        return NO;
    }
    NSCalendar *calender = [NSCalendar currentCalendar];
    calender.firstWeekday = 2;//设置每周第一天从周一开始
    //计算两个日期分别为这年第几周
    NSUInteger countSelf = [calender ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:dateOne];
    NSUInteger countDate = [calender ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:dateTwo];    //相等就在同一周，不相等就不在同一周
    return countSelf == countDate;
}

#pragma mark - 判断日期格式是否有效
+ (BOOL)isValidDateStr:(NSString *)dateStr
{
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateformater dateFromString:dateStr];
    if (date) {
        return YES;
    }
    return NO;
}

+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
}



+(NSString *)getNowTimeTimestamp2{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    ;
    
    return timeString;
    
}
@end
