//
//  NSDate+Time.m
//  Daiyanxiu
//
//  Created by Mac01 on 16/3/26.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import "NSDate+Time.h"

@implementation NSDate (Time)

- (NSString *) compareCurrentTime:(NSString *)str
{
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;

    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <2){
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSInteger unitFlags = NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *dd = [cal components:unitFlags fromDate:timeDate];
        NSInteger hour = [dd hour];
        NSInteger minute = [dd minute];
        if (minute<10) {
            result = [NSString stringWithFormat:@"昨天%ld:0%ld",(long)hour,(long)minute];
        }else
        {
            result = [NSString stringWithFormat:@"昨天%ld:%ld",(long)hour,(long)minute];

        }
    }
    
    else {
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth| NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *dd = [cal components:unitFlags fromDate:timeDate];
        NSInteger year = [dd year];
        NSInteger month = [dd month];
        NSInteger day = [dd day];
        NSInteger hour = [dd hour];
        NSInteger minute = [dd minute];
        if (minute<10) {
        result = [NSString stringWithFormat:@"%ld-%ld-%ld %ld:0%ld",(long)year,(long)month,(long)day,(long)hour,(long)minute];
        }else
        {
            result = [NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld",(long)year,(long)month,(long)day,(long)hour,(long)minute];
        }
    }
    
    return  result;
}




- (BOOL)isSameDay:(NSString *)date1 date2:(NSString *)date2 {
    NSString *time1 = [NSString stringWithDateAndTimeAndMinnueNumber:[date1 longLongValue]];
    NSString *time2 = [NSString stringWithDateAndTimeAndMinnueNumber:[date2 longLongValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate1 = [dateFormatter dateFromString:time1];
    NSDate *timeDate2 = [dateFormatter dateFromString:time2];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay ;
    
    
    NSDateComponents *comp1 = [calendar components:unit fromDate:timeDate1];
    NSDateComponents *comp2 = [calendar components:unit fromDate:timeDate2];
    
    
    return [comp1 year] == [comp2 year] && [comp1 month] == [comp2 month] && [comp1 day] == [comp2 day];
    
    
}

- (NSInteger)getMonth:(NSString *)date {
    NSString *time = [NSString stringWithDateAndTimeAndMinnueNumber:[date longLongValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:time];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay ;
    
    
    NSDateComponents *comp = [calendar components:unit fromDate:timeDate];
    
    
    return comp.month;
}

- (NSInteger)getDay:(NSString *)date {
    NSString *time = [NSString stringWithDateAndTimeAndMinnueNumber:[date longLongValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:time];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay ;
    
    
    NSDateComponents *comp = [calendar components:unit fromDate:timeDate];
    
    
    return comp.day;
}

@end
