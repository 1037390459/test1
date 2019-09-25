//
//  LXMainInUsedViewController.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/20.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXRootViewController.h"
#import "LXMyJourneyModel.h"
@interface LXMainInUsedViewController : LXRootViewController 
@property (nonatomic,copy)   NSString *RecordId;                              /**< 记录行程 */
@property (nonatomic,copy)   NSString *carId;                                 /**< 车辆id */
@property (nonatomic,strong) LXMyJourneyModel *model;                         /**< 数据模型 */
@end
