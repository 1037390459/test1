//
//  NSString+URLRequestQuery.h
//  CarWins
//
//  Created by Dandre on 16/4/23.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLRequestQuery)

/**
 *  在Url字符串中获取指定参数的值
 *
 *  @param query 指定参数
 *
 *  @return 参数对应的值
 */
- (NSString *)requestQuery:(NSString *)query;

/**
 *  在Url字符串中获取指定参数的值
 *
 *  @param query 指定参数
 *
 *  @return 参数对应的值
 */
- (NSString *)request:(NSString *)query;

@end
