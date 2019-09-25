//
//  CWInterface(Expand).h
//  CarWins
//
//  Created by chenge on 16/3/22.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import "LXInterface.h"

@interface LXInterface(Expand)

/**
 *  获取应用信息
 */
+ (NSDictionary *)postAppInfoWithStatus:(NSInteger)status;

/**
 *  下载文件
 */
+ (NSDictionary *)postFileDownloadWithFileID:(NSString *)fileId;

@end
