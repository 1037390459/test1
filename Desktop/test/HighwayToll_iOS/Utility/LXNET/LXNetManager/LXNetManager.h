//
//  LXNetManager.h
//  LX
//
//  Created by cheng on 16/3/22.
//  Copyright © 2017年 LX Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXNetResultModel.h"

typedef void (^downloadFinishedBlock) (id responseObj);
typedef void (^downloadFailedBlock) (NSError *error);
/**
 *  用于封装和网络交互的操作
 */
@interface LXNetManager : NSObject

/**
 *  网络请求单例
 */
+ (LXNetManager *)shareManager;

#pragma mark - POST

/**
 *  post统一请求接口  自动判断params是否包含图片 (常用 不带缓存)
 *
 *  @param paramsDict    包含请求的URL和参数
 *  @param finishedBlock 数据请求成功后的回调方法
 *  @param failedBlock   数据请求失败的回调方法
 */
+ (void)postRequestWithParamDictionary:(NSDictionary *)paramsDict
                              finished:(downloadFinishedBlock)finishedBlock
                                failed:(downloadFailedBlock)failedBlock;
/**
 *  post统一请求接口 (常用 带缓存 默认是7天)
 *
 *  @param paramsDict    包含请求的URL和参数
 *  @param finishedBlock 数据请求成功后的回调方法
 *  @param failedBlock   数据请求失败的回调方法
 */
- (void)postRequestWithParamDictionary:(NSDictionary *)paramsDict
                              finished:(downloadFinishedBlock)finishedBlock
                                failed:(downloadFailedBlock)failedBlock;

/**
 *  post请求缓存接口 默认先读缓存 (常用 带缓存)
 *
 *  @param paramsDict    包含请求的URL和参数
 *  @param shouldCache   是否缓存请求的数据
 *  @param cacheTime     缓存时间（单位：分钟）
 *  @param finishedBlock 数据请求成功后的回调方法
 *  @param failedBlock   数据请求失败的回调方法
 */
- (void)postRequestWithParamDictionary:(NSDictionary *)paramsDict
                           shouldCache:(BOOL)shouldCache
                             CacheTime:(NSInteger)cacheTime
                              finished:(downloadFinishedBlock)finishedBlock
                                failed:(downloadFailedBlock)failedBlock;
/**
 *  普通post请求
 *
 *  @param urlString     请求的URL
 *  @param params        请求的URL参数
 *  @param finishedBlock 请求成功时的回调方法
 *  @param failedBlock   请求失败时的回调方法
 */
+ (void)postRequestWithUrlString:(NSString *)urlString
                          params:(id)params
                        finished:(downloadFinishedBlock)finishedBlock
                          failed:(downloadFailedBlock)failedBlock;
/**
 *  post请求缓存接口 默认先读缓存 (常用 带缓存)
 *
 *  @param paramsDict    包含请求的URL和参数
 *  @param shouldCache   是否缓存请求的数据
 *  @param cacheTime     缓存时间（单位：分钟）
 *  @param finishedBlock 数据请求成功后的回调方法
 *  @param failedBlock   数据请求失败的回调方法
 */
- (void)getRequestWithParamDictionary:(NSDictionary *)paramsDict
                           shouldCache:(BOOL)shouldCache
                             CacheTime:(NSInteger)cacheTime
                              finished:(downloadFinishedBlock)finishedBlock
                                failed:(downloadFailedBlock)failedBlock;
/**
 *  普通get请求
 *
 *  @param urlString     请求的URL
 *  @param params        请求的URL参数
 *  @param finishedBlock 请求成功时的回调方法
 *  @param failedBlock   请求失败时的回调方法
 */
+ (void)getRequestWithUrlString:(NSString *)urlString
                          params:(id)params
                        finished:(downloadFinishedBlock)finishedBlock
                          failed:(downloadFailedBlock)failedBlock;
/**
 *  上传文件或图片方法
 *
 *  @param urlString 请求的URL
 *  @param params    请求的URL参数,存放除图片以外的其他参数
 *  @param imageData 图片二进制文件(图片转换的NSData *)
 *  @param key       图片对应的key
 *  @param finished  请求成功时的回调方法
 *  @param failed    请求失败时的回调方法
 */
+ (void)postUploadImageWithUrlString:(NSString *)urlString
                              params:(id)params
                               image:(NSData *)imageData
                              imgKey:(NSString *)key
                       finishedBlock:(downloadFinishedBlock)finished
                         failedBlock:(downloadFailedBlock)failed;


#pragma mark - GET

/**
 *  http 协议 get请求 (常用, 缓存数据)
 *
 *  @param urlString     请求的URLString
 *  @param finishedBlock 数据请求成功后的回调方法
 *  @param failedBlock   数据请求失败的回调方法
 */
+ (void)getRequestWithUrlString:(NSString *)urlString
                       finished:(downloadFinishedBlock)finishedBlock
                         failed:(downloadFailedBlock)failedBlock;
/**
 *  http 协议 get请求 (常用, 不缓存数据)
 *
 *  @param urlString     请求的URLString
 *  @param finishedBlock 数据请求成功后的回调方法
 *  @param failedBlock   数据请求失败的回调方法
 */
- (void)getRequestWithUrlString:(NSString *)urlString
                       finished:(downloadFinishedBlock)finishedBlock
                         failed:(downloadFailedBlock)failedBlock;



/**
 *  发送一个POST请求
 *
 *  @param paramsDict  请求参数
 *  @param finishedBlock 请求成功后的回调
 *  @param failedBlock 请求失败后的回调
 */
+ (void)postWithParamDictionary:(NSDictionary *)paramsDict
                       finished:(downloadFinishedBlock)finishedBlock
                         failed:(downloadFailedBlock)failedBlock;

/**
 *  发送一个GET请求
 *
 *  @param paramsDict  请求参数
 *  @param finishedBlock 请求成功后的回调
 *  @param failedBlock 请求失败后的回调
 */
+ (void)getWithParamDictionary:(NSDictionary *)paramsDict
                      finished:(downloadFinishedBlock)finishedBlock
                        failed:(downloadFailedBlock)failedBlock;
@end
