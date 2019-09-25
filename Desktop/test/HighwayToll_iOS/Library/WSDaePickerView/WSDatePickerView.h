//
//  WSDatePickerView.h
//  WSDatePicker
//
//  Created by iMac on 17/2/23.
//  Copyright © 2017年 zws. All rights reserved.
//
//- (void)selectAction:(UIButton *)btn {
//
//    //_________________________年-月-日-时-分____________________________________________
//
//    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
//
//        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
//        NSLog(@"选择的日期：%@",date);
//        [btn setTitle:date forState:UIControlStateNormal];
//
//    }];
//    datepicker.dateLabelColor = [UIColor orangeColor];//年-月-日-时-分 颜色
//    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
//    datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
//    [datepicker show];
//
//
//
//
//
//
//    //_________________________月-日-时-分____________________________________________
//
//    /*
//
//     //月-日-时-分
//     WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
//
//     NSString *date = [selectDate stringWithFormat:@"MM-dd HH:mm"];
//     NSLog(@"选择的月日时分：%@",date);
//     [btn setTitle:date forState:UIControlStateNormal];
//
//     }];
//     [datepicker show];
//
//     */
//
//
//
//
//
//
//
//    //_________________________年-月-日_______________________________________________
//    /*
//
//
//     WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
//
//     NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
//     NSLog(@"选择的年月日：%@",date);
//     [btn setTitle:date forState:UIControlStateNormal];
//
//     }];
//     [datepicker show];
//
//     */
//
//
//
//
//
//
//
//    //_________________________月-日_______________________________________________
//
//    /*
//     WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowMonthDay CompleteBlock:^(NSDate *selectDate) {
//
//     NSString *date = [selectDate stringWithFormat:@"MM-dd"];
//     NSLog(@"选择的月日：%@",date);
//     [btn setTitle:date forState:UIControlStateNormal];
//
//     }];
//     [datepicker show];
//     */
//
//
//
//
//
//
//
//
//
//
//    //_________________________时-分_______________________________________________
//
//    /*
//     WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowHourMinute CompleteBlock:^(NSDate *selectDate) {
//
//     NSString *date = [selectDate stringWithFormat:@"HH:mm"];
//     NSLog(@"选择的时分：%@",date);
//     [btn setTitle:date forState:UIControlStateNormal];
//
//     }];
//     [datepicker show];
//     */
//
//
//}
//
//- (void)selectAction2:(UIButton *)btn {
//    //_________________________年-月-日-时-分（滚动到指定的日期）_________________________
//    NSDateFormatter *minDateFormater = [[NSDateFormatter alloc] init];
//    [minDateFormater setDateFormat:@"yyyy-MM-dd HH:mm"];
//    NSDate *scrollToDate = [minDateFormater dateFromString:@"2011-11-11 11:11"];
//
//    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute scrollToDate:scrollToDate CompleteBlock:^(NSDate *selectDate) {
//        
//        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
//        NSLog(@"选择的日期：%@",date);
//        [btn setTitle:date forState:UIControlStateNormal];
//
//    }];
//    datepicker.dateLabelColor = RGB(65, 188, 241);//年-月-日-时-分 颜色
//    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
//    datepicker.doneButtonColor = RGB(65, 188, 241);//确定按钮的颜色
//    datepicker.yearLabelColor = [UIColor clearColor];//大号年份字体颜色
//    [datepicker show];
//
//}

#import <UIKit/UIKit.h>
#import "NSDate+Extension.h"

/**
 *  弹出日期类型
 */
typedef enum{
    DateStyleShowYearMonthDayHourMinute  = 0,//年月日时分
    DateStyleShowMonthDayHourMinute,//月日时分
    DateStyleShowYearMonthDay,//年月日
    DateStyleShowMonthDay,//月日
    DateStyleShowHourMinute//时分
    
}WSDateStyle;


@interface WSDatePickerView : UIView

/**
 *  确定按钮颜色
 */
@property (nonatomic,strong)UIColor *doneButtonColor;
/**
 *  年-月-日-时-分 文字颜色(默认橙色)
 */
@property (nonatomic,strong)UIColor *dateLabelColor;
/**
 *  滚轮日期颜色(默认黑色)
 */
@property (nonatomic,strong)UIColor *datePickerColor;

/**
 *  限制最大时间（默认2099）datePicker大于最大日期则滚动回最大限制日期
 */
@property (nonatomic, retain) NSDate *maxLimitDate;
/**
 *  限制最小时间（默认0） datePicker小于最小日期则滚动回最小限制日期
 */
@property (nonatomic, retain) NSDate *minLimitDate;

/**
 *  大号年份字体颜色(默认灰色)想隐藏可以设置为clearColor
 */
@property (nonatomic, retain) UIColor *yearLabelColor;

/**
 默认滚动到当前时间
 */
-(instancetype)initWithDateStyle:(WSDateStyle)datePickerStyle CompleteBlock:(void(^)(NSDate *))completeBlock;

/**
 滚动到指定的的日期
 */
-(instancetype)initWithDateStyle:(WSDateStyle)datePickerStyle scrollToDate:(NSDate *)scrollToDate CompleteBlock:(void(^)(NSDate *))completeBlock;


-(void)show;


@end

