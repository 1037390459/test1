//
//  LXUserCenterUpdateUserNameController.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/1.
//  Copyright © 2017年 zheng. All rights reserved.
//   修改昵称
#import "LXRootViewController.h"
typedef NS_ENUM(NSInteger, LXUserCenterEnum)
{
    LXUserCenterEnumRealName = 0,                //真是姓名
    LXUserCenterEnumDriversLicenseNumber,        //驾驶证号
    LXUserCenterEnumEmail,                       //邮箱
    LXUserCenterEnumPhone                        //邮箱
};;
@interface LXUserCenterUpdateUserNameController : LXRootViewController
  @property (nonatomic,assign) LXUserCenterEnum userEnum;        /**< 用户枚举*/
@end
