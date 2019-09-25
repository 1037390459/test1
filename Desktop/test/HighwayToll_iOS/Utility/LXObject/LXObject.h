//
//  CWParentModel.h
//  CarWins
//
//  Created by Dandre on 16/3/22.
//  Copyright © 2016年 Dandre. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXObject : NSObject

@property (nonatomic, assign) NSInteger code;           /**< 状态码 */
@property (nonatomic, copy) NSString *message;          /**< 提醒内容 */
@property (nonatomic, assign) NSInteger totalCount;     /**< 列表总数 */

/**
 *  用Json字典实例化数据实体
 *
 *  @param dict 字典
 *
 *  @return 数据实体
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;

/**
 *  在未定义的情况下调用该方法
 *

 */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

/**
 日期格式转换 取值的时候用
 
 @param dateString 日期字符串
 @return 日期字符
 */
- (NSString *)dateFormTransfer:(NSString *)dateString;

@end
