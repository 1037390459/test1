//
//  LXInterface+UserCenter.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/6.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXInterface+UserCenter.h"

@implementation LXInterface (UserCenter)
+ (NSMutableDictionary *)postUserCenterVCode_Login:(NSString *)mobile{
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSString stringWithFormat:@"%@?mobile=%@",kLXHttpPostUrl(@"api/VCode/Login"),mobile]
                 forKey:@"url"];
        //[dict setObject:kStringConvertNull(mobile) forKey:@"mobile"];
        return dict;
}
+ (NSMutableDictionary *)postUserCenterFindPwd:(NSString *)mobile{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:@"%@?mobile=%@",kLXHttpPostUrl(@"api/VCode/FindPwd"),mobile]
             forKey:@"url"]; 
    return dict;
}
+ (NSMutableDictionary *)postUserCenterLoginWithVCode:(NSString *)loginName
                                                vcode:(NSString *)vcode{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:@"%@?loginName=%@&vcode=%@",kLXHttpPostUrl(@"api/Driver/LoginWithVCode"),loginName,vcode]
             forKey:@"url"];
//    [dict setObject:kStringConvertNull(loginName) forKey:@"loginName"];
//    [dict setObject:kStringConvertNull(vcode) forKey:@"vcode"];
    return dict;
}
+ (NSMutableDictionary *)postUserCenterResetPasswordWithVCode:(NSString *)loginName
                                                        vcode:(NSString *)vcode
                                                       newPwd:(NSString *)newPwd{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:@"%@?loginName=%@&vcode=%@&newPwd=%@",kLXHttpPostUrl(@"api/Driver/ResetPasswordWithVCode"),loginName,vcode,newPwd]
             forKey:@"url"];
//    [dict setObject:kStringConvertNull(loginName) forKey:@"loginName"];
//    [dict setObject:kStringConvertNull(vcode) forKey:@"vcode"];
//    [dict setObject:kStringConvertNull(newPwd) forKey:@"newPwd"];
    return dict;
}
+ (NSMutableDictionary *)postUserCenterUploadPic{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"api/Driver/UploadPic")
             forKey:@"url"];
    return dict;
}
+ (NSMutableDictionary *)postUserCenterLogout{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"api/Driver/Logout")
             forKey:@"url"];
    return dict;
}
+ (NSMutableDictionary *)postUserCenterLogin:(NSString *)loginName
                                   timeStamp:(NSString *)timeStamp
                                        sign:(NSString *)sign{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:@"%@?loginName=%@&timeStamp=%@&sign=%@",kLXHttpPostUrl(@"api/Driver/Login"),loginName,timeStamp,sign]
             forKey:@"url"];
//    [dict setObject:kStringConvertNull(loginName) forKey:@"loginName"];
//    [dict setObject:kStringConvertNull(timeStamp) forKey:@"timeStamp"];
//    [dict setObject:kStringConvertNull(sign) forKey:@"sign"];
    return dict;
}
+ (NSMutableDictionary *)postUserCenterRegisterWithVCode:(NSString *)vcode
                                               LoginName:(NSString *)LoginName
                                           LoginPassword:(NSString *)LoginPassword{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:@"%@?vcode=%@",kLXHttpPostUrl(@"api/Driver/RegisterWithVCode"),vcode]
             forKey:@"url"];
    [dict setObject:kStringConvertNull(LoginName) forKey:@"LoginName"];
    [dict setObject:kStringConvertNull(LoginPassword) forKey:@"LoginPassword"];

    return dict;
}
+ (NSMutableDictionary *)postUserCenterRegisterMobile:(NSString *)mobile{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:@"%@?mobile=%@",kLXHttpPostUrl(@"api/VCode/Register"),mobile]
             forKey:@"url"];
    return dict;
}
  
@end
