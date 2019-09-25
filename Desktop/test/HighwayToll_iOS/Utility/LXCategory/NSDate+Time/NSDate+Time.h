//
//  NSDate+Time.h
//  Daiyanxiu
//
//  Created by Mac01 on 16/3/26.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Extension.h"

@interface NSDate (Time)
/**
 *  与当前时间做比较
 *
 *  @param str 需要对比的时间字符串
 *
 *  @return 和当前时间相差时间差文字
 */
- (NSString *) compareCurrentTime:(NSString *)str;


/**
 *  比较两个时间字符串是否是同一天
 *
 *  @param date1 时间字符串
 *  @param date2 时间字符串
 *
 *  @return 是否相等的结果
 */
- (BOOL)isSameDay:(NSString *)date1 date2:(NSString *)date2;

/**
 *  获取一个时间字符串的月份
 *
 *  @param date 时间字符串
 *
 *  @return 月份值
 */
- (NSInteger)getMonth:(NSString *)date;

/**
 *  获取一个时间字符串的日期值
 *
 *  @param date 时间字符串
 *
 *  @return 日期值
 */
- (NSInteger)getDay:(NSString *)date;

@end
