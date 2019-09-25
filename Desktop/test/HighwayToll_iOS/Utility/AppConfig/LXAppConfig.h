//
//  CWAppConfig.h
//  CarWins
//
//  Created by Dandre on 16/7/20.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import "LXObject.h"

@class LXAppConfig;

/**
 *  服务器环境配置 Debug配置
 */

extern NSString * const kDEBUGBaseHost;
extern NSString * const kDEBUGImageHost;
extern NSString * const kDEBUGSaasHost;
extern NSString * const kDEBUGUpdateHost;

/**
 *  服务器环境配置 Release配置 勿动
 */
extern NSString * const kReleaseBaseHost;
extern NSString * const kReleaseImageHost;
extern NSString * const kReleaseSaasHost;
extern NSString * const kReleaseUpdateHost;
/**
 *  友盟分享配置
 */
extern NSString * const kUMAppKey;

/**
 *  微信 (孔雀荟)
 */
extern NSString * const kWeChatAppID;
extern NSString * const kWeChatAppSecret;
extern NSString * const KimageUrl;
/**
 *  QQ （孔雀荟）
 */
extern NSString * const kQQAppID;
extern NSString * const kQQAppKey;
/**<激光推送*/
extern NSString * const kPushMAppKey;

@interface LXAppConfig : LXObject

/**
 *  单例
 */
+ (instancetype)shareConfig;

@end
