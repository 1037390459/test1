//
//  NSString+Common.h
//  CarWins
//
//  Created by Lone on 2016/12/7.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)


/**
 * 1.字符串反转
 */
- (NSString *)reverseWords;

/**
 * 2.多个符号分割
 */
- (NSArray *)componentsSeparatedWithCharsString:(NSString *)chars;

/**
 * 3.获取汉字拼音
 */
- (NSString *)transformPinYin;

/**
 * 4.计算字符串字符长度，一个汉字算两个字符
 */
- (NSInteger)unicodeLength;

/**
 * url 编码
 */
- (NSString *)urlEncode;

/**
 * url 解码
 */
- (NSString *)urlUnEncode;
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;
- (BOOL)isCarNo;
-(BOOL)isTel;
-(BOOL)isEmail;
-(BOOL)isDeviceCode;
-(BOOL)isDevice;
-(BOOL)isNotNil;
-(BOOL)isPWD;
-(BOOL)isCode;
-(BOOL)isIDCard;
-(BOOL)isNumOrsASC;

/**
 通过时间戳计算时间差（几小时前、几天前
 
 @param compareDate <#compareDate description#>
 @return <#return value description#>
 */
+ (NSString *) compareCurrentTime:(NSTimeInterval) compareDate;

/**
 通过时间戳得出对应的时间
 
 @param timestamp 时间戳
 @return <#return value description#>
 */
+ (NSString *) getDateStringWithTimestamp:(NSTimeInterval)timestamp;

/**
 //通过时间戳和显示时间
 @param timestamp 时间戳
 @param formatter 格式
 @return <#return value description#>
 */
+ (NSString *) getStringWithTimestamp:(NSTimeInterval)timestamp formatter:(NSString*)formatter;
@end
