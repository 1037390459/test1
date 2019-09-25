//
//  CWAppConfig.m
//  CarWins
//
//  Created by Dandre on 16/7/20.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import "LXAppConfig.h"

/**************************  服务器环境配置 Begin *************************/


NSString * const kDEBUGBaseHost               = @"highway.lansum.cn";
NSString * const kDEBUGImageHost              = @"demo.webservice.carwins.com";
NSString * const kDEBUGSaasHost               = @"webservice.carwins.com/saaswebapi";

// 更新服务器
NSString * const kDEBUGUpdateHost             = @"app.webservice.carwins.com";

// Release配置 勿动 Begin =================
NSString * const kReleaseBaseHost             = @"highway.lansum.cn";
NSString * const kReleaseImageHost            = @"demo.webservice.carwins.com";
NSString * const kReleaseSaasHost             = @"webservice.carwins.com/saaswebapi";

// 更新服务器
NSString * const kReleaseUpdateHost           = @"app.webservice.carwins.com";
// Release配置 勿动 End   =================

/**************************  服务器环境配置 End   ****************************/

/**************************  友盟分享配置  Begin ****************************/

NSString * const kUMAppKey                   = @"59df2fc5cae7e71cbf000022";
/**
 *  微信 (至美会)
 */
NSString * const kWeChatAppID                = @"wxec7ccc48a546ece7";
NSString * const kWeChatAppSecret            = @"dbe0b48a13954bfc2989704248831c28";
NSString * const KimageUrl                   = @"http://highway.lansum.cn";
/**
 *  QQ （车赢网）
 */
NSString * const kQQAppID                    = @"1105352168";
NSString * const kQQAppKey                   = @"vjKXIBagsXo9esCQ";
/**
   ATC高速公路友盟推送
 */
NSString * const kPushMAppKey                   = @"5a322d8df43e48060e000041";

NSString * const kPushSecret                    = @"vce6dvqzzi9rfewwjo7eernp27gndoi0";
/**************************  友盟分享配置  End   ****************************/

@implementation LXAppConfig

#pragma mark - 单例
+ (instancetype)shareConfig
{
    static LXAppConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[LXAppConfig alloc] init];
    });
    
    return config;
}
@end
