//
//  CWInterface+Enum.h
//  CarWins
//
//  Created by Dandre on 16/3/22.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//
#import "LXAppConfig.h"
#ifndef CWInterface_Enum_h
#define CWInterface_Enum_h

/************************** 字符串转换 Begin *****************************/

#define kStringByInt(i)              [NSString stringWithFormat:@"%ld",i]
#define kStringByFloat(f)            [NSString stringWithFormat:@"%lf",f]
#define kStringByObject(o)           [NSString stringWithFormat:@"%@",o]
#define kStringByCharString(s)       [NSString stringWithFormat:@"%s",c]
#define kStringByChar(c)             [NSString stringWithFormat:@"%c",c]
#define kStringConvertNull(str)      [NSString convertNull:str]

/**************************  字符串转换 End  *****************************/
/**************************  服务器主机设置 Begin *************************/

#ifdef DEBUG

#define kBaseHost                    kDEBUGBaseHost
#define kImageHost                   kDEBUGImageHost
#define kSaasHost                    kDEBUGSaasHost
// 更新服务器
#define kUpdateHost(url)             [NSString stringWithFormat:@"http://%@/%@",kDEBUGUpdateHost,url]

#else
/******************** Release配置 勿动 Begin *********************/
#define kBaseHost                    kReleaseBaseHost
#define kSaasHost                    kReleaseSaasHost
// 更新服务器
#define kUpdateHost(url)             [NSString stringWithFormat:@"http://%@/%@",kReleaseUpdateHost,url]     
#define kImageHost                   kReleaseImageHost
/******************** Release配置 勿动 End ********************/
#endif

#define kLXSaasHttpPostUrl(url)         [NSString stringWithFormat:@"http://%@/%@",kSaasHost,url]
#define kLXHttpImageUrl(url)            [NSString stringWithFormat:@"http://%@/images/%@",kImageHost,url]
#define kLXHttpPostUrl(url)             [NSString stringWithFormat:@"http://%@/%@",kBaseHost,url]
#define kLXHttpsPostUrl(url)            [NSString stringWithFormat:@"https://%@/%@",kBaseHost,url]
/************************** 服务器主机设置 End ****************************/
/************************** 枚举  Begin  ********************************/


#endif /* QWInterface_Enum_h */
