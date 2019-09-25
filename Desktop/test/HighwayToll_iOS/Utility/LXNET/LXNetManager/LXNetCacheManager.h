//
//  LXNetCacheManager.h
//  LX
//
//  Created by change on 2017/10/17.
//  Copyright © 2017年 LX Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXNetCacheManager : NSObject

/**
 1.获取本地缓存数据 (根据请求参数 dict 包含URL)

 @param paramsDict 请求参数字典
 @param cacheTime 缓存时间
 @return return value description
 */
+ (id)getResponseDataFromCacheByParamsDict:(NSDictionary *)paramsDict
                            cacheTime:(NSInteger)cacheTime;

/**
 2.数据缓存到本地 (根据请求参数 dict 包含URL)

 @param paramsDict 请求参数字典（字典包含请求URL）
 @param responseData 服务端请求成功返回数据
 @return return value description
 */
+ (BOOL)saveRequestDataToCacheWithParamsDict:(NSDictionary *)paramsDict
                               responseData:(id)responseData;

/**
 3.获取本地缓存数据

 @param urlString 请求地址
 @param cacheTime 缓存时间
 @return return value description
 */
+ (id)getResponseDataByUrlString:(NSString *)urlString
                       cacheTime:(NSInteger)cacheTime;

/**
 4.保存缓存数据到本地

 @param urlString 请求地址
 @param responseData 数据
 @return return value description
 */
+ (BOOL)saveRequestDataToLocalByUrlString:(NSString *)urlString
                             responseData:(NSData *)responseData;

@end
