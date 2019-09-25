//
//  LXNetManager.m
//  CarWins
//
//  Created by cheng on 17/10/17.
//  Copyright © 2017年 LX Inc. All rights reserved.
//

#import "LXNetManager.h"
#import "AFNetworking.h"
#import "NSString+Hashing.h"            //包含md5加密
#import "NSFileManager+PathMethod.h"
#import "AppDelegate.h"
#import "LXNetCacheManager.h"
#import "LXURLRequestSerialization.h"
#define kTimeOutInterval 15 // 请求超时的时间
@implementation LXNetManager

static LXNetManager *manage = nil;

+ (LXNetManager *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[LXNetManager alloc] init];
    });
    
    return manage;
}

//请求管理器
+ (AFHTTPSessionManager *)sessionManager
{
    
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [AFHTTPSessionManager manager];
        manager.operationQueue.maxConcurrentOperationCount = 5;
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                             @"application/json",
                                                             @"text/xml",
                                                             @"text/html",
                                                             @"multipart/form-data",
                                                             @"application/x-www-form-urlencoded",
                                                             nil];
        NSString *cookie = KUserDefault_Get(@"Set-Cookie");
        if (cookie.length > 0) {
            [manager.requestSerializer  setValue:cookie forHTTPHeaderField:@"Cookie"];
        }
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //[manager.requestSerializer setValue:[LXDeviceManager currentAppVersion] forHTTPHeaderField:@"AppVersion"];
        manager.requestSerializer.timeoutInterval=30.f;
    });    
#pragma mark - 支持https
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    return manager;
}

//配置请求参数字典 添加公共属性
+ (NSDictionary *)configParametersWithParams:(NSDictionary *)params
{
    //copy 字典
    NSMutableDictionary *parameters = [params mutableCopy];
    //移除请求地址
//    [parameters removeObjectForKey:@"url"];
//    if ([LXUserInfoModel shareUser].isLogin) {
//        [parameters setObject:[LXUserInfoModel shareUser].sessionId forKey:@"sessionId"];
//        [parameters setObject:[LXUserInfoModel shareUser].userId forKey:@"loginUserID"];
//        [parameters setObject:@([LXUserInfoModel shareUser].groupID) forKey:@"requestGroupID"];
//    } 
//    [parameters setObject:[LXDeviceManager currentIp] forKey:@"clientIP"];
//    [parameters setObject:[LXDeviceManager currentUUID] forKey:@"endDeviceNumber"];
//    [parameters setObject:[LXLocationManager shareInstance].city forKey:@"cityName"];
//    [parameters setObject:[LXDeviceManager currentBundleID] forKey:@"bundleID"];
    
    return parameters;
}

// 普通post请求
+ (void)postRequestWithUrlString:(NSString *)urlString
                          params:(id)params
                        finished:(downloadFinishedBlock)finishedBlock
                          failed:(downloadFailedBlock)failedBlock
{
    AFHTTPSessionManager *manager = [LXNetManager sessionManager];
    
    NSString *cookie = KUserDefault_Get(@"Set-Cookie");
    if (cookie.length > 0) {
        [manager.requestSerializer  setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    //AF请求
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //block返回的是NSData
    [manager POST:urlString
       parameters:[LXNetManager configParametersWithParams:params]
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject) {
              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
              if([responseObject isKindOfClass:[NSData class]]){
                  NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                  NSData *responseData = [str dataUsingEncoding:NSUTF8StringEncoding];
                  id dataDict = [NSJSONSerialization JSONObjectWithData:responseData
                                                                options:0
                                                                  error:nil];
                  if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
                      NSDictionary *dic = ((NSHTTPURLResponse *)task.response).allHeaderFields;
                      NSString *set_cookie = [dic objectForKey:@"Set-Cookie"];
                      if (set_cookie.length != 0) {
                         KUserDefault_Set(set_cookie, @"Set-Cookie");
                      }
                  }

                  finishedBlock(dataDict);
              }else if ([responseObject isKindOfClass:[NSDictionary class]]){
                  LXNetResultModel *result = [[LXNetResultModel alloc] initWithDictionary:responseObject];
                  if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
                      NSDictionary *dic = ((NSHTTPURLResponse *)task.response).allHeaderFields;
                      NSString *set_cookie = [dic objectForKey:@"Set-Cookie"];
                      if (set_cookie.length != 0) {
                          KUserDefault_Set(set_cookie, @"Set-Cookie");
                      }
                  }
//                  if (result.code < LXNetErrorCodeNormal) {
//                      [LXMessage hideActiveView];
//                      if (result.code == LXNetErrorCodeSessionExpired ||
//                          result.code == LXNetErrorCodeSignatureFailure) {
//                          [LXMessage show:@""
//                                 tipTitle:@"您的登录信息已失效，请重新登录"
//                                  okTitle:nil
//                                  Clicked:^(NSInteger buttonIndex) {
//
//                                      [[NSNotificationCenter defaultCenter] postNotificationName:LXUserInfoHasExpiredNotification object:nil];
//                                  }];
//                      }else if (result.code == LXNetErrorCodeServerException) {
//                          [LXMessage show:@"服务器内部异常" onView:kWindow autoHidden:YES];
//                          return ;
//                      }else if (result.code == LXNetErrorCodeDataCheckException) {
//                          [LXMessage show:result.message onView:kWindow autoHidden:YES];
//                          return;
//                      }else if (result.code == LXNetErrorCodeForceHTTPS) {
//                          [LXMessage show:@"请求失败,请稍后操作" onView:kWindow autoHidden:YES];
//                          return;
//                      }else{
//                          DLog(@"网络层错误：code:%ld %@\n",result.code,result.message);
//                      }
//                  }
                  finishedBlock(responseObject);
              }else{
                  DLog(@"%@",responseObject);
              }
          } failure:^(NSURLSessionDataTask * _Nonnull task, NSError *_Nonnull error) {
              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
              failedBlock(error);
          }];
    
}
// 普通post请求
+ (void)getRequestWithUrlString:(NSString *)urlString
                          params:(id)params
                        finished:(downloadFinishedBlock)finishedBlock
                          failed:(downloadFailedBlock)failedBlock
{
    AFHTTPSessionManager *manager = [LXNetManager sessionManager];
    
    
    NSString *cookie = KUserDefault_Get(@"Set-Cookie");
    if (cookie.length > 0) {
        [manager.requestSerializer  setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    //AF请求
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //block返回的是NSData
    [manager GET:urlString
       parameters:[LXNetManager configParametersWithParams:params]
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject) {
              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
              if([responseObject isKindOfClass:[NSData class]]){
                  NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                  NSData *responseData = [str dataUsingEncoding:NSUTF8StringEncoding];
                  id dataDict = [NSJSONSerialization JSONObjectWithData:responseData
                                                                options:0
                                                                  error:nil];
                  
                  finishedBlock(dataDict);
              }else if ([responseObject isKindOfClass:[NSDictionary class]]){
                  LXNetResultModel *result = [[LXNetResultModel alloc] initWithDictionary:responseObject];
                  //                  if (result.code < LXNetErrorCodeNormal) {
                  //                      [LXMessage hideActiveView];
                  //                      if (result.code == LXNetErrorCodeSessionExpired ||
                  //                          result.code == LXNetErrorCodeSignatureFailure) {
                  //                          [LXMessage show:@""
                  //                                 tipTitle:@"您的登录信息已失效，请重新登录"
                  //                                  okTitle:nil
                  //                                  Clicked:^(NSInteger buttonIndex) {
                  //
                  //                                      [[NSNotificationCenter defaultCenter] postNotificationName:LXUserInfoHasExpiredNotification object:nil];
                  //                                  }];
                  //                      }else if (result.code == LXNetErrorCodeServerException) {
                  //                          [LXMessage show:@"服务器内部异常" onView:kWindow autoHidden:YES];
                  //                          return ;
                  //                      }else if (result.code == LXNetErrorCodeDataCheckException) {
                  //                          [LXMessage show:result.message onView:kWindow autoHidden:YES];
                  //                          return;
                  //                      }else if (result.code == LXNetErrorCodeForceHTTPS) {
                  //                          [LXMessage show:@"请求失败,请稍后操作" onView:kWindow autoHidden:YES];
                  //                          return;
                  //                      }else{
                  //                          DLog(@"网络层错误：code:%ld %@\n",result.code,result.message);
                  //                      }
                  //                  }
                  finishedBlock(responseObject);
              }else{
                  DLog(@"%@",responseObject);
              }
          } failure:^(NSURLSessionDataTask * _Nonnull task, NSError *_Nonnull error) {
              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
              failedBlock(error);
          }];
    
}
// http 协议 post请求
+ (void)postRequestWithParamDictionary:(NSDictionary *)paramsDict
                              finished:(downloadFinishedBlock)finishedBlock
                                failed:(downloadFailedBlock)failedBlock
{
     
    if (paramsDict[@"url"]) {
        NSString *url = paramsDict[@"url"];
        NSMutableDictionary *params = [paramsDict mutableCopy];
        [params removeObjectForKey:@"url"];
        
        //判断是否含有图片 bytes
        if (params[@"apifiles"] && [params[@"apifiles"] count] >0) {
            NSArray *files = params[@"apifiles"];
            NSMutableArray *keys = [NSMutableArray array];
            for (int i=0; i<files.count;i++) {
                [keys addObject:@"apifiles"];
            }
            
            [params removeObjectForKey:@"apifiles"];
            [self postUploadFilesWithUrlString:url
                                        params:params
                                         files:files
                                      fileKeys:keys
                                 finishedBlock:^(id responseObj) {
                                     finishedBlock(responseObj);
                                 }
                                   failedBlock:^(NSError *error) {
                                       failedBlock(error);
                                   }];
            
        }else if (params[@"bytes"] && [params[@"bytes"] count] >0) {
            
            NSArray *files = params[@"bytes"];
            NSMutableArray *keys = [NSMutableArray array];
            for (int i=0; i<files.count;i++) {
                [keys addObject:@"bytes"];
            }
            [params removeObjectForKey:@"bytes"];
            [self postUploadFilesWithUrlString:url
                                        params:params
                                         files:files
                                      fileKeys:keys
                                 finishedBlock:^(id responseObj) {
                                     finishedBlock(responseObj);
                                 }
                                   failedBlock:^(NSError *error) {
                                       failedBlock(error);
                                   }];
        }else{
            [self postRequestWithUrlString:url
                                    params:params
                                  finished:^(id responseObj) {
                                      finishedBlock(responseObj);
                                  } failed:^(NSError *error) {
                                      failedBlock(error);
                                  }];
        }
    }else{
        DLog(@"url 参数不正确！");
    }
}

// http 协议 post请求(带7天缓存)
- (void)postRequestWithParamDictionary:(NSDictionary *)paramsDict
                              finished:(downloadFinishedBlock)finishedBlock
                                failed:(downloadFailedBlock)failedBlock
{
    if (paramsDict[@"url"]) {
#pragma mark - 缓存不支持文件上传类型
        [LXNetManager postRequestWithUrlString:paramsDict[@"url"]
                                        params:paramsDict
                                      finished:^(id responseObj) {
                                          finishedBlock(responseObj);
                                          if ([responseObj[@"code"] integerValue] >= 0) {
                                              //写入缓存
                                              [LXNetCacheManager saveRequestDataToCacheWithParamsDict:paramsDict responseData:responseObj];
                                          }
                                      } failed:^(NSError *error) {
                                          //查看缓存(默认3天)
                                          id responseObj = [LXNetCacheManager getResponseDataFromCacheByParamsDict:paramsDict cacheTime:30 * 24 * 7];
                                          if (responseObj) {
                                              finishedBlock(responseObj);
                                          }else{
                                              failedBlock(error);
                                          }
                                      }];
    }else{
        DLog(@"url 参数不正确！");
    }
}

//设置缓存类型请求方法 （缓存时间单位：分)
- (void)postRequestWithParamDictionary:(NSDictionary *)paramsDict
                           shouldCache:(BOOL)shouldCache
                             CacheTime:(NSInteger)cacheTime
                              finished:(downloadFinishedBlock)finishedBlock
                                failed:(downloadFailedBlock)failedBlock
{
    if (paramsDict[@"url"]) {
        id responseObj = [LXNetCacheManager getResponseDataFromCacheByParamsDict:paramsDict cacheTime:cacheTime];
        if (shouldCache && responseObj && [responseObj[@"code"] integerValue] >= 0) {
            finishedBlock(responseObj);
        }else{
#pragma mark - 缓存不支持文件上传类型
            [LXNetManager postRequestWithUrlString:paramsDict[@"url"]
                                            params:paramsDict
                                          finished:^(id responseObj) {
                                              finishedBlock(responseObj);
                                              if ([responseObj[@"code"] integerValue] >= 0) {
                                                  //写入缓存
                                                  [LXNetCacheManager saveRequestDataToCacheWithParamsDict:paramsDict responseData:responseObj];
                                              }
                                          } failed:^(NSError *error) {
                                              if (shouldCache) {
                                                  id responseObj = [LXNetCacheManager getResponseDataFromCacheByParamsDict:paramsDict cacheTime:cacheTime];
                                                  if (responseObj) {
                                                      finishedBlock(responseObj);
                                                  }else{
                                                      failedBlock(error);
                                                  }
                                              }else{
                                                  failedBlock(error);
                                              }
                                          }];
        }
    }else{
        DLog(@"url 参数不正确！");
    }
}
//设置缓存类型请求方法 （缓存时间单位：分)
- (void)getRequestWithParamDictionary:(NSDictionary *)paramsDict
                           shouldCache:(BOOL)shouldCache
                             CacheTime:(NSInteger)cacheTime
                              finished:(downloadFinishedBlock)finishedBlock
                                failed:(downloadFailedBlock)failedBlock
{
    if (paramsDict[@"url"]) {
        id responseObj = [LXNetCacheManager getResponseDataFromCacheByParamsDict:paramsDict cacheTime:cacheTime];
        if (shouldCache && responseObj && [responseObj[@"code"] integerValue] >= 0) {
            finishedBlock(responseObj);
        }else{
#pragma mark - 缓存不支持文件上传类型
            [LXNetManager getRequestWithUrlString:paramsDict[@"url"]
                                            params:paramsDict
                                          finished:^(id responseObj) {
                                              finishedBlock(responseObj);
                                              if ([responseObj[@"code"] integerValue] >= 0) {
                                                  //写入缓存
                                                  [LXNetCacheManager saveRequestDataToCacheWithParamsDict:paramsDict responseData:responseObj];
                                              }
                                          } failed:^(NSError *error) {
                                              if (shouldCache) {
                                                  id responseObj = [LXNetCacheManager getResponseDataFromCacheByParamsDict:paramsDict cacheTime:cacheTime];
                                                  if (responseObj) {
                                                      finishedBlock(responseObj);
                                                  }else{
                                                      failedBlock(error);
                                                  }
                                              }else{
                                                  failedBlock(error);
                                              }
                                          }];
        }
    }else{
        DLog(@"url 参数不正确！");
    }
}
//上传文件或图片方法
//dict 中放除图片以外的其他参数,data图片转换的NSData key为图片对应的key:pis
+ (void)postUploadFilesWithUrlString:(NSString *)urlString
                              params:(id)params
                               files:(NSArray *)files
                            fileKeys:(NSArray *)keys
                       finishedBlock:(downloadFinishedBlock)finished
                         failedBlock:(downloadFailedBlock)failed
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [LXNetManager sessionManager];
    manager.requestSerializer.timeoutInterval = 0;
    
    //上传图片的post方法
    [manager POST:urlString
       parameters:[LXNetManager configParametersWithParams:params]
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         for (NSInteger i=0; i<files.count; i++) {
             NSData *file = files[i];
             NSString *key = keys[i];
             NSString *mimeType = [LXCommon getImageMineTypeForImageData:file];
             NSString *type = [LXCommon getImageTypeForImageData:file];
             NSString *fileName = [NSString stringWithFormat:@"%lld%@",(long long)[[NSDate date] timeIntervalSince1970],type];
             //利用formData 实现图片上传
             [formData appendPartWithFileData:file
                                         name:key
                                     fileName:fileName
                                     mimeType:mimeType];
         }
     }
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
              if ([responseObject isKindOfClass:[NSData class]]) {
                  NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                  DLog(@"%@",str);
                  finished([NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil]);
              }else {
                  finished(responseObject);
              }
          }
          failure:^(NSURLSessionDataTask * _Nonnull task, NSError *_Nonnull error) {
              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
              failed(error);
          }];
}

//上传文件或图片方法
//dict 中放除图片以外的其他参数,data图片转换的NSData key为图片对应的key:pis
+ (void)postUploadImageWithUrlString:(NSString *)urlString
                              params:(id)params
                               image:(NSData *)imageData
                              imgKey:(NSString *)key
                       finishedBlock:(downloadFinishedBlock)finished
                         failedBlock:(downloadFailedBlock)failed
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [LXNetManager sessionManager];
    manager.requestSerializer.timeoutInterval = 0;
    NSString *cookie = KUserDefault_Get(@"Set-Cookie");
    if (cookie.length > 0) {
        [manager.requestSerializer  setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    //上传图片的post方法
    [manager POST:urlString
       parameters:params
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         NSString *mimeType = [LXCommon getImageMineTypeForImageData:imageData];
         NSString *type = [LXCommon getImageTypeForImageData:imageData];
         //利用formData 实现图片上传
         [formData appendPartWithFileData:imageData
                                     name:key
                                 fileName:[NSString stringWithFormat:@"uploadTmp%@",type]
                                 mimeType:mimeType];
     }
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
              if ([responseObject isKindOfClass:[NSData class]]) {
                  finished([NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil]);
              }else{
                  finished(responseObject);
              }
          }
          failure:^(NSURLSessionDataTask * _Nonnull task, NSError *_Nonnull error) {
              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
              failed(error);
          }];
}

+ (NSString*)convertToJSONData:(id)infoDict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSString *jsonString = @"";
    
    if (! jsonData)
    {
        NSLog(@"Got an error: %@", error);
    }else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
}

//http 协议 get请求
+ (void)getRequestWithUrlString:(NSString *)urlString
                       finished:(downloadFinishedBlock)finishedBlock
                         failed:(downloadFailedBlock)failedBlock
{
    DLog(@"urlString:%@",urlString);
    //拼接文件的路径
    NSString *path = [[NSFileManager getNetWorkCacheDataFilePath] stringByAppendingFormat:@"/%@",[urlString MD5_32_Encode]];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //如果指定路径下的数据存在 并且没有超时,则使用缓存
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] && [NSFileManager isTimeOutWithPath:path time:60*30] == NO) {
        
        //使用缓存数据,而不是请求数据
        NSData *data = [NSData dataWithContentsOfFile:path];
        id dataDict = [NSJSONSerialization JSONObjectWithData:data
                                                      options:0
                                                        error:nil];
        //执行block,并传出dataDict
        finishedBlock(dataDict);
    }
    else {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString *cookie = KUserDefault_Get(@"Set-Cookie");
        if (cookie.length > 0) {
            [manager.requestSerializer  setValue:cookie forHTTPHeaderField:@"Cookie"];
        }
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                             @"text/html",
                                                             @"application/json",
                                                             nil];
        [manager.requestSerializer setValue:[LXDeviceManager currentAppVersion] forHTTPHeaderField:@"AppVersion"];
        [manager GET:urlString
          parameters:nil
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                 [LXMessage hideActiveView];
                 //将请求下来的数据写到本地
                 if([responseObject isKindOfClass:[NSData class]]){
                     NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                     NSData *responseData = [str dataUsingEncoding:NSUTF8StringEncoding];
                     id dataDict = [NSJSONSerialization JSONObjectWithData:responseData
                                                                   options:0
                                                                     error:nil];
                     if (dataDict[@"Result"]) {
                         DLog(@"%@",dataDict);
                         if ([dataDict[@"Result"] isKindOfClass:[NSDictionary class]]) {
                             LXNetResultModel *model = [[LXNetResultModel alloc] initWithDictionary:dataDict[@"Result"]];
                             if (model.code >=0) {
                                 finishedBlock(dataDict);
                                 return ;
                             }else{
                                 
                                 return ;
                             }
                         }
                         //将数据写入到本地
                         [responseData writeToFile:path atomically:YES];
                         finishedBlock(dataDict);
                     }
                     //将数据写入到本地
                     [responseData writeToFile:path atomically:YES];
                     finishedBlock(dataDict);
                 }else{
                     DLog(@"数据格式错误!");
                 }
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                 [LXMessage hideActiveView];
                 failedBlock(error);
             }];
    }
}

- (void)getRequestWithUrlString:(NSString *)urlString
                       finished:(downloadFinishedBlock)finishedBlock
                         failed:(downloadFailedBlock)failedBlock
{ 
    //拼接文件的路径
    NSString *path = [[NSFileManager getNetWorkCacheDataFilePath] stringByAppendingFormat:@"/%@",[urlString MD5_32_Encode]];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                         @"text/html",
                                                         @"application/json",
                                                         nil];
    [manager.requestSerializer setValue:[LXDeviceManager currentAppVersion] forHTTPHeaderField:@"AppVersion"];
    NSString *cookie = KUserDefault_Get(@"Set-Cookie");
    if (cookie.length > 0) {
        [manager.requestSerializer  setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    //block返回的是NSData
    
    [manager GET:urlString
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             [LXMessage hideActiveView];
             //将请求下来的数据写到本地
             if([responseObject isKindOfClass:[NSData class]]){
                 NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                 NSData *responseData = [str dataUsingEncoding:NSUTF8StringEncoding];
                 id dataDict = [NSJSONSerialization JSONObjectWithData:responseData
                                                               options:0
                                                                 error:nil];
                 if (dataDict[@"Result"]) {
                     DLog(@"%@",dataDict);
                     if ([dataDict[@"Result"] isKindOfClass:[NSDictionary class]]) {
                         LXNetResultModel *model = [[LXNetResultModel alloc] initWithDictionary:dataDict[@"Result"]];
                         if (model.code >=0) {
                             finishedBlock(dataDict);
                             return ;
                         }else{ 
                             return ;
                         }
                     }
                     //将数据写入到本地
                     [responseData writeToFile:path atomically:YES];
                     finishedBlock(dataDict);
                 }
                 //将数据写入到本地
                 [responseData writeToFile:path atomically:YES];
                 finishedBlock(dataDict);
             }else{
                 DLog(@"数据格式错误!");
             }
         }
         failure:^(NSURLSessionDataTask * _Nonnull task, NSError *_Nonnull error) {
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             [LXMessage hideActiveView];
             failedBlock(error);
         }];
}


/**
 *  发送一个POST请求formdata提交
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithParamDictionary:(NSDictionary *)paramsDict
                       finished:(downloadFinishedBlock)finishedBlock
                         failed:(downloadFailedBlock)failedBlock
{
    
    if (paramsDict[@"url"]) {
        NSString *url = paramsDict[@"url"];
        NSMutableDictionary *params = [paramsDict mutableCopy];
        [params removeObjectForKey:@"url"];
        
    NSURL *requestUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        NSString *cookie = KUserDefault_Get(@"Set-Cookie");
        if (cookie.length > 0) {
            [request  setValue:cookie forHTTPHeaderField:@"Cookie"];
        }
    // 设置Accept-Language
    NSMutableArray *acceptLanguagesComponents = [NSMutableArray array];
    [[NSLocale preferredLanguages] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        float q = 1.0f - (idx * 0.1f);
        [acceptLanguagesComponents addObject:[NSString stringWithFormat:@"%@;q=%0.1g", obj, q]];
        *stop = q <= 0.5f;
    }];
    [request setValue:[acceptLanguagesComponents componentsJoinedByString:@", "] forHTTPHeaderField:@"Accept-Language"];
    
    // 设置User-Agent
    NSString *userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)",
                           [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey],
                           [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey],
                           [[UIDevice currentDevice] model],
                           [[UIDevice currentDevice] systemVersion],
                           [[UIScreen mainScreen] scale]];
    
    if (userAgent) {
        if (![userAgent canBeConvertedToEncoding:NSASCIIStringEncoding]) {
            NSMutableString *mutableUserAgent = [userAgent mutableCopy];
            if (CFStringTransform((__bridge CFMutableStringRef)(mutableUserAgent), NULL, (__bridge CFStringRef)@"Any-Latin; Latin-ASCII; [:^ASCII:] Remove", false)) {
                userAgent = mutableUserAgent;
            }
        }
        [request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    }
    
    if ([NSJSONSerialization isValidJSONObject:params]) {
        NSString *jsonStr = LXQueryStringFromParameters(params);
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        [request  setHTTPBody:jsonData];
        [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)jsonData.length] forHTTPHeaderField:@"Content-Length"];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error != nil) {
                failedBlock(error);
            }else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    id jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:Nil];
                    finishedBlock(jsonData);
                });
            }
        }];
        //开始请求
        [task resume];
     }
    }
}

/**
 *  发送一个GET请求formdata提交
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithParamDictionary:(NSDictionary *)paramsDict
                      finished:(downloadFinishedBlock)finishedBlock
                        failed:(downloadFailedBlock)failedBlock {
    if (paramsDict[@"url"]) {
        NSString *url = paramsDict[@"url"];
        NSMutableDictionary *params = [paramsDict mutableCopy];
        [params removeObjectForKey:@"url"];
       
    NSURL *requestUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"GET"];
        NSString *cookie = KUserDefault_Get(@"Set-Cookie");
        if (cookie.length > 0) {
            [request  setValue:cookie forHTTPHeaderField:@"Cookie"];
        }
    // 设置Accept-Language
    NSMutableArray *acceptLanguagesComponents = [NSMutableArray array];
    [[NSLocale preferredLanguages] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        float q = 1.0f - (idx * 0.1f);
        [acceptLanguagesComponents addObject:[NSString stringWithFormat:@"%@;q=%0.1g", obj, q]];
        *stop = q <= 0.5f;
    }];
    [request setValue:[acceptLanguagesComponents componentsJoinedByString:@", "] forHTTPHeaderField:@"Accept-Language"];
    
    // 设置User-Agent
    NSString *userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)",
                           [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey],
                           [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey],
                           [[UIDevice currentDevice] model],
                           [[UIDevice currentDevice] systemVersion],
                           [[UIScreen mainScreen] scale]];
    
    if (userAgent) {
        if (![userAgent canBeConvertedToEncoding:NSASCIIStringEncoding]) {
            NSMutableString *mutableUserAgent = [userAgent mutableCopy];
            if (CFStringTransform((__bridge CFMutableStringRef)(mutableUserAgent), NULL, (__bridge CFStringRef)@"Any-Latin; Latin-ASCII; [:^ASCII:] Remove", false)) {
                userAgent = mutableUserAgent;
            }
        }
        [request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    }
    
    if ([NSJSONSerialization isValidJSONObject:params]) {
        NSString *jsonStr = LXQueryStringFromParameters(params);
        request.URL = [NSURL URLWithString:[[request.URL absoluteString] stringByAppendingFormat:request.URL.query ? @"&%@" : @"?%@", jsonStr]];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error != nil) {
                failedBlock(error);
            }else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    id jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:Nil];
                     finishedBlock(jsonData);
                });
            }
        }];
        //开始请求
        [task resume];
    }
    }
    
}
@end
