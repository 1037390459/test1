//
//  NSString+FormDictionary.h
//  CarWins
//
//  Created by Dandre on 16/5/4.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FormDictionary)

/**
 *  将字典转为字符串
 *
 *  @param dic 字典
 *
 *  @return return value description
 */
+ (NSString *)stringWithDictionary:(NSDictionary *)dic;

/**
 *  将数组转为字符串
 *
 *  @param array 数组
 *
 *  @return return value description
 */
+ (NSString *)stringWithArray:(NSArray *)array;

+ (NSString *)stringWithJsonString:(NSString *)json;

@end
