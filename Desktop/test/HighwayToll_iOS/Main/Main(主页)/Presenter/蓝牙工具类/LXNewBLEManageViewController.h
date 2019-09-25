//
//  LXNewBLEManageViewController.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/23.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXRootViewController.h"

@interface LXNewBLEManageViewController : LXRootViewController

/**
  单列
 */
+ (instancetype)manager;

/**
  手机状态
 */
- (BOOL)blueToothState;
@property (nonatomic,assign) NSInteger TollRecordId;       /**< 行程id*/

/**
   停止扫描
 */
- (void)stopScan;

/**
   扫描
 */
- (void)canScan;
@end
