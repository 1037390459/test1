//
//  LXMyWalletRechargeSuccessViewController.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXRootViewController.h"

@interface LXMyWalletRechargeSuccessViewController : LXRootViewController
@property (nonatomic,copy) NSString *moneyStr;           /**< 金额 */
@property (nonatomic,assign) bool isHome;                /**< 是不是冲首页跳过来*/
@end
