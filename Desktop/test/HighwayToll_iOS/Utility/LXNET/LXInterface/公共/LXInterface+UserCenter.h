//
//  LXInterface+UserCenter.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/6.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXInterface.h"

@interface LXInterface (UserCenter)

/**
   登录验证

 @param mobile 手机号码
 @return return value description
 */
+ (NSMutableDictionary *)postUserCenterVCode_Login:(NSString *)mobile;

/**
 找回密码验证码

 @param mobile 手机号码
 @return return value description
 */
+ (NSMutableDictionary *)postUserCenterFindPwd:(NSString *)mobile;

/**
 使用验证码登录

 @param loginName 手机号码
 @param vcode 验证码
 @return return value description
 */
+ (NSMutableDictionary *)postUserCenterLoginWithVCode:(NSString *)loginName
                                      vcode:(NSString *)vcode;
/**
 重置密码使用验证码
 
 @param loginName 手机号码
 @param vcode 验证码
  @param newPwd 新密码
 @return return value description
 */
+ (NSMutableDictionary *)postUserCenterResetPasswordWithVCode:(NSString *)loginName
                                                        vcode:(NSString *)vcode
                                                       newPwd:(NSString *)newPwd;

/**
 图片上传
 
 @return <#return value description#>
 */
+ (NSMutableDictionary *)postUserCenterUploadPic;


/**
 Description 退出登录

 @return <#return value description#>
 */
+ (NSMutableDictionary *)postUserCenterLogout;

/**
   账号密码登录

 @param loginName 用户名
 @param timeStamp 时间戳
 @param sign SHA1加密方式  先把密码加密
 然后用户名+加密后的密码+时间戳 签名原字符串
 SHa1加密签名字符串 得到最后的签名
 @return return value description
 */
+ (NSMutableDictionary *)postUserCenterLogin:(NSString *)loginName
                                   timeStamp:(NSString *)timeStamp
                                        sign:(NSString *)sign;

/**
   手机号码注册

 @param vcode 验证码
 @param LoginName 用户名
 @param LoginPassword 密码
 @return return value description
 */
+ (NSMutableDictionary *)postUserCenterRegisterWithVCode:(NSString *)vcode
                                               LoginName:(NSString *)LoginName
                                           LoginPassword:(NSString *)LoginPassword;

/**
  注册验证码

 @param mobile  手机号码
 @return return value description
 */
+ (NSMutableDictionary *)postUserCenterRegisterMobile:(NSString *)mobile;
@end
