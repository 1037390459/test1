//
//  LXAddVehicleViewController.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/24.
//  Copyright © 2017年 zheng. All rights reserved.
//  添加汽车

#import "LXRootViewController.h"

@interface LXAddVehicleViewController : LXRootViewController
@property (nonatomic,assign) bool isEdit;               /**< 是不是编辑*/
@property (nonatomic,assign) bool isFormMain;           /**< 是不是来自主页*/
@property (nonatomic,assign) NSInteger carId;           /**< 车辆id */
@end
