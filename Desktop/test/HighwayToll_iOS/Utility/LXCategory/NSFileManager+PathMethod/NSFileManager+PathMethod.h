//
//  NSFileManager+PathMethod.h
//  CarWins
//
//  Created by Dandre on 16/3/22.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KCF_DB_FILE_NAME @"CW_data_v1"
#define KCF_DB_FILE_TYPE @"CW"
#define KCF_DB_FILENAME @"CW_data_v1.db"

@interface NSFileManager (PathMethod)

//判定指定路径下的文件是否超出了规定的时间
//NSTimeInterval double类型 指多少秒
+ (BOOL)isTimeOutWithPath:(NSString *)path time:(NSTimeInterval)time;

/**
 *  拍照后选取的图片保存位置
 */
+ (NSString *)getImagesDocumentsPath;
+ (NSString *)imageFilePath:(NSString *)name;
+ (BOOL)writeImage:(UIImage *)image toFileAtPath:(NSString *)aPath;
+ (NSString *)getTagsDocumentsPath;
/**
 *  获取数据库目录
 */
+ (BOOL)initKCFDBFile;
+ (NSString *)getKCFDBFilePath;

//缓存文件
+ (NSString *)getCacheDataFilePath;

//log
+ (NSString *)getLogDocumentsPath;

/**
 *  获取网络数据缓存目录
 */
+ (NSString *)getNetWorkCacheDataFilePath;

//删除
+ (BOOL)removeUbDocuments;

+ (BOOL)removeDirectory:(NSString *)path;

+ (BOOL)createDirectory:(NSString *)path;

/**
 *  获取指定文件大小
 *
 *  @param path 文件路径
 *
 *  @return 单位 M
 */

+ (float)fileSizeAtPath:(NSString *)path;
/**
 *  获取指定文件夹大小
 *
 *  @param path 文件夹路径
 *
 *  @return 单位 M
 */
+ (float)folderSizeAtPath:(NSString *)path;
/**
 *  获取App缓存大小
 *
 *  @return 单位 M
 */
+ (float)getAllCacheDataSize;
/**
 *  清除App缓存
 */
+ (void)clearAllCache;
/**
 *  清除指定文件夹
 *
 *  @param path 文件夹路径
 */
+ (void)clearCacheDataAtFolderPath:(NSString *)path;

#pragma mark - Add By Dandre @2016.04.09 根据POST请求体获取缓存目录和文件名
/**
 *  根据POST请求体获取缓存目录和文件名
 *
 *  @return return value description
 */
+ (NSString *)getNetWorkCacheDataFilePathAndNameWithPOSTParams:(NSDictionary *)paramsDict;

@end
