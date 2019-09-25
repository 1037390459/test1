//
//  LXUserInfoModel.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/6.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXUserInfoModel.h"

@implementation LXUserInfoModel
@synthesize isLogin = _isLogin;
static LXUserInfoModel *model = nil;
+ (instancetype)shareUser
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[LXUserInfoModel alloc]init];
    });
    return model;
}
- (void)setValue:(id)value forKey:(NSString *)key
{
     KUserDefault_Set(value,key);
}
#pragma mark - 判断用户是否登录
- (void)setIsLogin:(BOOL)isLogin
{
    _isLogin = isLogin;
    if (!_isLogin) {
        [self removeAllUserInfo];
    }
}

- (BOOL)isLogin
{
    return (self.DriverId > 0 && self.LoginName);
}
#pragma mark - 清空用户信息
- (void)removeAllUserInfo
{
    KUserDefault_Set(@"",@"DriverId");
    KUserDefault_Set(@"",@"DriverStateId");
    KUserDefault_Set(@"",@"LoginName");
    KUserDefault_Set(@"",@"RealName");
    KUserDefault_Set(@"",@"Phone");
    KUserDefault_Set(@"",@"Email");
    KUserDefault_Set(@"",@"AvatorImage");
    KUserDefault_Set(@"",@"Set-Cookie");
    KUserDefault_Set(@"",@"Balance");
    KUserDefault_Set(@"",@"DriversLicenseNumber");
    KUserDefault_Set(@"",@"DriversLicenseImage");
    KUserDefault_Set(@"",@"WeChat");
    KUserDefault_Set(@[],@"Cars");
}
- (NSInteger)DriverId{
    return [KUserDefault integerForKey:@"DriverId"];
}
- (NSInteger)DriverStateId{
    return [KUserDefault integerForKey:@"DriverStateId"];
}
- (NSString *)DriverStateName
{
    return KUserDefault_Get(@"DriverStateName");
}
- (NSString *)LoginName
{
    return KUserDefault_Get(@"LoginName");
}
- (NSString *)DriversLicenseNumber
{
    return KUserDefault_Get(@"DriversLicenseNumber");
}
- (NSString *)DriversLicenseImage
{
    return KUserDefault_Get(@"DriversLicenseImage");
}
- (NSString *)RealName
{
    return KUserDefault_Get(@"RealName");
}
- (NSString *)Phone
{
    return KUserDefault_Get(@"Phone");
}
- (NSString *)Email
{
    return KUserDefault_Get(@"Email");
}
- (NSString *)AvatorImage
{
    return KUserDefault_Get(@"AvatorImage");
}
- (NSString *)WeChat
{
    return KUserDefault_Get(@"WeChat");
}
- (CGFloat )Balance
{
    return [KUserDefault floatForKey:@"Balance"];;
}
//----------------------------
- (NSArray<LXCarModel *> *)Cars
{
    
    return (NSArray *)KUserDefault_Get(@"Cars");
}
@end
@implementation LXCarModel

@end
