//
//  LXNetCacheManager.m
//  LX
//
//  Created by change on 2017/10/17.
//  Copyright © 2017年 LX Inc. All rights reserved.
//

#import "LXNetCacheManager.h"

@implementation LXNetCacheManager

#pragma mark - 缓存数据保存 提取
// 获取本地缓存数据 (根据请求参数 dict 包含URL)
+ (id)getResponseDataFromCacheByParamsDict:(NSDictionary *)paramsDict cacheTime:(NSInteger)cacheTime
{
    NSString *path = [NSFileManager getNetWorkCacheDataFilePathAndNameWithPOSTParams:paramsDict];
    //如果指定路径下的数据存在 并且没有超时,则使用缓存
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        if ([NSFileManager isTimeOutWithPath:path time:60*cacheTime] == NO) {
            //根据路径获取缓存数据
            id dataDict = [LXCommon getDictionaryWithDataPath:path];
            //执行block,并传出dataDict
            return dataDict;
        }else{
            //数据无效删除
            [[NSFileManager defaultManager] removeItemAtPath:path
                                                       error:nil];
            return nil;
        }
    }
    return nil;
}

// 数据缓存到本地 (根据请求参数 dict 包含URL)
+ (BOOL)saveRequestDataToCacheWithParamsDict:(NSDictionary *)paramsDict responseData:(id)responseObject
{
    NSString *path = [NSFileManager getNetWorkCacheDataFilePathAndNameWithPOSTParams:paramsDict];
#pragma mark - 只保存NSDictionary 类型数据
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSData *data = [LXCommon getDataWithDictionary:responseObject];
        BOOL success = [data writeToFile:path atomically:YES];
        return success;
    }
    return NO;
}

// 获取本地缓存数据 (根据请求路径 和 缓存有效期)
+ (id)getResponseDataByUrlString:(NSString *)urlString cacheTime:(NSInteger)cacheTime
{
    //拼接文件的路径
    NSString *path = [[NSFileManager getNetWorkCacheDataFilePath] stringByAppendingFormat:@"/%@",[urlString MD5_32_Encode]];
    
    //如果指定路径下的数据存在 并且没有超时,则使用缓存
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] && [NSFileManager isTimeOutWithPath:path time:60*cacheTime] == NO ) {
        
        //使用缓存数据,而不是请求数据
        NSData *data = [NSData dataWithContentsOfFile:path];
        id dataDict = [NSJSONSerialization JSONObjectWithData:data
                                                      options:0
                                                        error:nil];
        //执行block,并传出dataDict
        return dataDict;
    }
    return nil;
}

//保存缓存数据到本地 (根据请求路径)
+ (BOOL)saveRequestDataToLocalByUrlString:(NSString *)urlString responseData:(NSData *)responseData
{
    //拼接文件的路径
    NSString *path = [[NSFileManager getNetWorkCacheDataFilePath] stringByAppendingFormat:@"/%@",[urlString MD5_32_Encode]];
    if (responseData) {
        //将数据写入到本地
        [responseData writeToFile:path atomically:YES];
    }
    return YES;
}

@end
