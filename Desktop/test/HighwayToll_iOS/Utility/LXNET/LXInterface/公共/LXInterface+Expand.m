//
//  CWInterface(Expand).m
//  CarWins
//
//  Created by Dandre on 16/3/22.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import "LXInterface+Expand.h"

@implementation LXInterface(Expand)

#pragma mark - 获取App信息
+ (NSDictionary *)postAppInfoWithStatus:(NSInteger)status
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *systemName = [UIDevice currentDevice].systemName;
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
//    NSString *model = [CWDeviceManager deviceModel];
//    NSString *bundleIdentifier =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
//    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    [dict setObject:kUpdateHost(@"api/UpAPPInfo/AddAppDeviceInfo") forKey:@"url"];
//    [dict setObject:bundleIdentifier forKey:@"bundleid"];
//    [dict setObject:version forKey:@"appversion"];
//    [dict setObject:build forKey:@"appbuild"];
//    [dict setObject:systemName forKey:@"systemname"];
//    [dict setObject:systemVersion forKey:@"systemversion"];
//    [dict setObject:model forKey:@"model"];
//    [dict setObject:kStringByInt(status) forKey:@"status"];
//    [dict setObject:[YFCulture getPreferredLanguage] forKey:@"culture"];
//    [dict setObject:[CWDeviceManager currentUUID] forKey:@"uuid"];
//    
//    [dict setObject:kStringConvertNull([CWUserInfoModel shareUser].userId) forKey:@"loginuserid"];
//    [dict setObject:kStringConvertNull([CWUserInfoModel shareUser].userName) forKey:@"loginusername"];
//    [dict setObject:kStringConvertNull([CWDeviceManager currentNetwork]) forKey:@"network"];
//    [dict setObject:kStringConvertNull([CWLocationManager shareInstance].city) forKey:@"location"];
//    [dict setObject:kStringByFloat([CWLocationManager shareInstance].longitude) forKey:@"longitude"];
//    [dict setObject:kStringByFloat([CWLocationManager shareInstance].latitude) forKey:@"latitude"];
//    [dict setObject:kStringConvertNull([CWUserInfoModel shareUser].regionId) forKey:@"regionid"];
//    [dict setObject:kStringConvertNull([CWUserInfoModel shareUser].regionName) forKey:@"regionname"];
//    [dict setObject:kStringConvertNull([CWUserInfoModel shareUser].subId) forKey:@"subid"];
//    [dict setObject:kStringConvertNull([CWUserInfoModel shareUser].subName) forKey:@"subname"];
//    [dict setObject:@"1" forKey:@"platform"];
    
    return dict;
}

//#pragma mark - 下载文件
//+ (NSDictionary *)postFileDownloadWithFileID:(NSString *)fileId
//{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    [dict setObject:kCWHttpPostUrl(@"api/File/Download") forKey:@"url"];
//    [dict setObject:fileId forKey:@"fileid"];
//    
//    return dict;
//}

@end
