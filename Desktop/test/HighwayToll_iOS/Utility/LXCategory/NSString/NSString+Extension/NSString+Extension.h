//
//  NSString+Extension.h
//  DYStore
//
//  Created by MyMac on 15/9/25.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

//根据最大宽度  文字的大小  计算尺寸大小
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
//根据最大高度  文字的大小  计算尺寸大小
- (CGSize)sizeWithFont:(UIFont *)font maxH:(CGFloat)maxH;
//根据指定的size  计算文字的大小
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;


- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize;
//计算文字大小  默认为最宽
- (CGSize)sizeWithFont:(UIFont *)font;

//判断密码是否符合要求(6-20位密码,不带特殊符号)
- (BOOL)validatePassword;

//设备型号
+ (NSString *)deviceType;

//转为documents下的子文件夹(做数据库存储用)
@property (nonatomic,copy,readonly) NSString *documentsSubFolder;


@end

@interface NSString (URL)
/**
 *  URLencodeding 编码
 *
 */
- (NSString *)URLEncodedString;

@end

@interface NSString (AttributeStr)

//修改字符串中的某一段字符串属性(只含文字颜色样式)
+ (NSMutableAttributedString *)getAttributeFromText:(NSString *)text pendingCharacter:(NSString *)pendingCharacter pendingColor:(UIColor *)color;

//修改字符串中的某一段字符串属性(含文字和字体样式)
+ (NSMutableAttributedString *)getAttributeFromText:(NSString *)text pendingCharacter:(NSString *)pendingCharacter pendingColor:(UIColor *)color font:(UIFont *)font;

//批量修改字符串中的某几段字符串属性(只含文字颜色样式)
+ (NSMutableAttributedString *)getAttributeFromText:(NSString *)text pendingCharacters:(NSArray *)pendingCharacters pendingColors:(NSArray *)colors;
//批量修改字符串中的某几段字符串属性(只含文字颜色样式)
+ (NSMutableAttributedString *)getAttributeFromTexts:(NSArray *)texts pendingCharacters:(NSArray *)pendingCharacters pendingColors:(NSArray *)colors;

//批量修改字符串中的某几段字符串属性(含文字和字体样式)
+ (NSMutableAttributedString *)getAttributeFromText:(NSString *)text pendingCharacters:(NSArray *)pendingCharacters pendingColors:(NSArray *)colors fonts:(NSArray *)fonts;

//给字符串加上中划线
+ (NSMutableAttributedString *)getAttributeFromTextIntoUnderline:(NSString *)text;
//给字符串加上下划线
+ (NSMutableAttributedString *)getAttributeFromTextBottomUnderline:(NSString *)text WithColor:(UIColor*)color;
//给字符串加行间距
+ (NSMutableAttributedString *)getAttributeToSetlineSpaceWithText:(NSString *)text WithLineSpace:(CGFloat)lineSpace;

@end


@interface NSString (DateFormatter)

/**
 *  返回 一个带日期时分的时间字符串
 *
 */
+ (NSString *)stringWithDateAndTimeNumber:(long long)integer;

/**
 *  返回 一个带日期时分秒的时间字符串
 *
 */
+ (NSString *)stringWithDateAndTimeAndMinnueNumber:(long long)integer;

/**
 *  根据formatter格式返回 时间字符串
 *
 */
+ (NSString *)stringWithDateNumber:(long long)integer formatter:(NSString*)format;

@end


@interface NSString (NSDictionary)

/**
 *  根据string格式返回 字典
 *
 */
+ (NSDictionary *)stringWithJSONToNSDictionary:(NSString *)jsonString;

@end
