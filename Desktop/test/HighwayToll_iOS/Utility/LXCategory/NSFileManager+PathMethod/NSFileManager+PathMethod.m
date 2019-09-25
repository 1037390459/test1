//
//  NSFileManager+PathMethod.m
//  CarWins
//
//  Created by Dandre on 16/3/22.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import "NSFileManager+PathMethod.h"

@implementation NSFileManager (PathMethod)

//判定指定路径下的文件是否超出了规定的时间
//NSTimeInterval double类型 指多少秒
+ (BOOL)isTimeOutWithPath:(NSString *)path time:(NSTimeInterval)time
{
    //可以获取指定路径下文件的属性列表
    NSDictionary *infoDict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    DLog(@"info :%@",infoDict);
    
    //拿到文件的修改时间
    NSDate *fileDate = [infoDict objectForKey:NSFileModificationDate];
    //与系统当前时间做差
    NSDate *date = [NSDate date];
    //date与fileDate的时间差
    NSTimeInterval currentTime = [date timeIntervalSinceDate:fileDate];
    if (currentTime >time) {
        DLog(@"已经超出指定时间");
        return YES;
    }else{
        //没有超出指定时间
        return NO;
    }
}

#pragma mark - 处理目录基本函数
+ (BOOL)createDirectory:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:path];
    if (!fileExists)
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return YES;
}

+ (BOOL)removeDirectory:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:path];
    if (fileExists)
    {
        return [fileManager removeItemAtPath:path error:NULL];
    }
    
    return YES;
}

#pragma mark - 文档目录 Documens-self
+ (NSString *)getCWDocumentsPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *path = [NSString stringWithFormat:@"%@/CarWins",documentsDirectory];
    
    [self createDirectory:path];
    
    return path;
}

+ (NSString *)getImagesDocumentsPath
{
    NSString *documentsDirectory = [self getCWDocumentsPath];
    
    NSString *path = [NSString stringWithFormat:@"%@/Images",documentsDirectory];
    
    [self createDirectory:path];
    
    return path;
}


+ (NSString *)getTagsDocumentsPath
{
    NSString *documentsDirectory = [self getCWDocumentsPath];
    
    NSString *path = [NSString stringWithFormat:@"%@/Tags",documentsDirectory];
    
    [self createDirectory:path];
    
    return path;
    
}


+ (NSString *)imageFilePath:(NSString *)name
{
    return [[self getImagesDocumentsPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",name]];
}

+ (BOOL)writeImage:(UIImage*)image toFileAtPath:(NSString*)aPath
{
    if ((image == nil) || (aPath == nil) || ([aPath isEqualToString:@""]))
        return NO;
    @try
    {
        NSData *imageData = nil;
        NSString *ext = [aPath pathExtension];
        if ([ext isEqualToString:@"png"])
        {
            imageData = UIImagePNGRepresentation(image);
        }
        else
        {
            // the rest, we write to jpeg
            
            // 0. best, 1. lost. about compress.
            
            imageData = UIImageJPEGRepresentation(image, 0.5);
            
        }
        
        if ((imageData == nil) || ([imageData length] <= 0))
            return NO;
        
        [imageData writeToFile:aPath atomically:YES];
        return YES;
    }
    @catch (NSException *e)
    {
        DLog(@"create thumbnail exception.");
    }
    return NO;
}


+ (BOOL)removeUbDocuments
{
    return [self removeDirectory:[self getCacheDataFilePath]];
}


#pragma mark - 日志目录
+ (NSString *)getLogDocumentsPath
{
    NSString *documentsDirectory = [self getCWDocumentsPath];
    
    NSString *path = [NSString stringWithFormat:@"%@/Log",documentsDirectory];
    
    [self createDirectory:path];
    
    return path;
}

#pragma marl - CacheData 文件
+ (NSString *)getCacheDataFilePath
{
    NSString *documentsDirectory = [self getCWDocumentsPath];
    
    NSString *path = [NSString stringWithFormat:@"%@/CacheData",documentsDirectory];
    [self createDirectory:path];
    return path;
}

#pragma mark - networkCache
+ (NSString *)getNetWorkCacheDataFilePath
{
    NSString *documentsDirectory = [self getCWDocumentsPath];
    
    NSString *path = [NSString stringWithFormat:@"%@/NetWorkCacheData",documentsDirectory];
    [self createDirectory:path];
    return path;
}


#pragma mark - 数据文件 Documents-KCF
+ (NSString *)getKCFDBFilePath
{
    NSString *documentsDirectory = [self getCWDocumentsPath];
    NSString *dbFile = [documentsDirectory stringByAppendingPathComponent:KCF_DB_FILENAME];
    
    return dbFile;
}

+ (BOOL)initKCFDBFile
{
    NSString *dbFilePath = [self getKCFDBFilePath];
    
    return [self copyDBFile:dbFilePath pathForResource:KCF_DB_FILE_NAME ofType:KCF_DB_FILE_TYPE];
}

#pragma mark - 处理数据文件基本函数
+ (BOOL)copyDBFile:(NSString *)path pathForResource:(NSString *)resource ofType:(NSString *)type
{
    if (! [[NSFileManager defaultManager] fileExistsAtPath: path]) {
        NSString *backupDbPath = [[NSBundle mainBundle]
                                  pathForResource:resource
                                  ofType:type];
        if (backupDbPath == nil) {
            return NO;
        } else {
            BOOL copiedBackupDb = [[NSFileManager defaultManager]
                                   copyItemAtPath:backupDbPath
                                   toPath:path
                                   error:nil];
            if (! copiedBackupDb) {
                return NO;
            }
        }
    }
    
    return YES;
}

#pragma mark - 获取指定文件大小
+ (float)fileSizeAtPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]) {
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/(1024.0 * 1024.0);
    }
    return 0;
}

#pragma mark - 获取指定文件夹大小
+ (float)folderSizeAtPath:(NSString *)folderPath {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize;
}

#pragma mark - 获取App缓存大小
+ (float)getAllCacheDataSize
{
    float cacheSize = [NSFileManager folderSizeAtPath:[NSFileManager getCacheDataFilePath]];
    float imageCacheSize = [NSFileManager folderSizeAtPath:[NSFileManager getImagesDocumentsPath]];
    float netCacheSize = [NSFileManager folderSizeAtPath:[NSFileManager getNetWorkCacheDataFilePath]];
    
    float allSize = cacheSize + imageCacheSize + netCacheSize;
    allSize += [[SDImageCache sharedImageCache] getSize]/(1024 * 1024);
    
    return allSize>0?allSize:0;
}

#pragma mark - 清除App缓存
+ (void)clearAllCache
{
    [NSFileManager clearCacheDataAtFolderPath:[NSFileManager getCacheDataFilePath]];
    [NSFileManager clearCacheDataAtFolderPath:[NSFileManager getImagesDocumentsPath]];
    [NSFileManager clearCacheDataAtFolderPath:[NSFileManager getNetWorkCacheDataFilePath]];
    [[SDImageCache sharedImageCache] clearDisk];
}

#pragma mark - 清除指定文件夹
+ (void)clearCacheDataAtFolderPath:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}

#pragma mark - Add By cheng @2016.04.09 根据POST请求体获取缓存目录和文件名
+ (NSString *)getNetWorkCacheDataFilePathAndNameWithPOSTParams:(NSDictionary *)paramsDict
{
    NSMutableArray *urls = [NSMutableArray arrayWithArray:[paramsDict allKeys]];
    [urls addObjectsFromArray:[paramsDict allValues]];
    
    
    NSString *path = [[NSFileManager getNetWorkCacheDataFilePath] stringByAppendingFormat:@"/%@",[[urls componentsJoinedByString:@"|"] MD5_32_Encode]];
    
    return path;
}

@end
