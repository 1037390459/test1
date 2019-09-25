//
//  NSString+Base64.h
//  CarWins
//
//  Created by Dandre on 16/4/20.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+Base64.h"

@interface NSString (Base64)

/******************************************************************************
 函数名称 : + (NSString *)base64StringWithString:(NSString *)text
 函数描述 : 将文本转换为base64格式字符串
 输入参数 : (NSString *)text    文本
 输出参数 : N/A
 返回参数 : (NSString *)    base64格式字符串
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64StringWithString:(NSString *)text;

/******************************************************************************
 函数名称 : + (NSString *)stringWithBase64String:(NSString *)base64
 函数描述 : 将base64格式字符串转换为文本
 输入参数 : (NSString *)base64  base64格式字符串
 输出参数 : N/A
 返回参数 : (NSString *)    文本
 备注信息 :
 ******************************************************************************/
+ (NSString *)stringWithBase64String:(NSString *)base64;

/******************************************************************************
 函数名称 : + (NSString *)base64StringWithData:(NSData *)data
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64StringWithData:(NSData *)data;

@end
