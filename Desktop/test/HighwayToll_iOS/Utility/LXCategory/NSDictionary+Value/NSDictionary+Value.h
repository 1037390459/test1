//
//  NSDictionary+Value.h
//  DYStore
//
//  Created by MyMac on 15/8/12.
//  Copyright (c) 2015年 daiyanwang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define isKindOfNSDictionary(obj) (obj && ![obj isEqual:[NSNull null]] && [obj isKindOfClass:[NSDictionary class]])
#define isKindOfNSArray(obj)      (obj && ![obj isEqual:[NSNull null]] && [obj isKindOfClass:[NSArray class]])

@interface NSDictionary (Value)
/**
 *  过滤null 以及空对象的  取字典值的方法
 *
 */
- (NSString *)stringValueForKey:(id)aKey;
/**
 *  获取字典对应key 的int值
 *
 */
- (int)intValueForKey:(id)aKey;
/**
 *  获取字典对应key 的float值
 *
 */
- (float)floatValueForKey:(id)aKey;
/**
 *  获取字典对应key 的double值
 *
 */
- (double)doubleValueForKey:(id)aKey;
/**
 *  获取字典对应key 的bool值
 *
 */
- (BOOL)boolValueForKey:(id)aKey;
/**
 *  获取字典对应key 的NSInteger值
 *
 */
- (NSInteger)integerValueForKey:(id)aKey;
/**
 *  获取字典对应key 的long值
 *
 */
- (long long)longLongValueForKey:(id)aKey;

@end
