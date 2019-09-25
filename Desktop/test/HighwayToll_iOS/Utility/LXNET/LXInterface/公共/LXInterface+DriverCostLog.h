//
//  LXInterface+DriverCostLog.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/11.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXInterface.h"

@interface LXInterface (DriverCostLog)
+ (NSMutableDictionary *)postDriverCostLog:(NSInteger)DriverCostLogId
                                MPDriverId:(NSString *)MPDriverId
                                  DriverId:(NSInteger)DriverId
                              MPCostTypeId:(NSString *)MPCostTypeId
                                CostTypeId:(NSInteger)CostTypeId
                                      Cost:(double)Cost
                                   Balance:(double)Balance
                                   AddTime:(NSDate *)AddTime;
@end
