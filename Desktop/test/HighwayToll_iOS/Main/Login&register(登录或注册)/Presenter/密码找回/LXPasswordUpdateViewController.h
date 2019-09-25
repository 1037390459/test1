//
//  LXPasswordUpdateViewController.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/23.
//  Copyright © 2017年 zheng. All rights reserved.
//  密码修改

#import "LXRootViewController.h"

@interface LXPasswordUpdateViewController : LXRootViewController
@property (nonatomic,strong) NSString *vCode;           /**< 验证码 */
@property (nonatomic,strong) NSString *phoneStr;        /**< 验证码 */
@end
