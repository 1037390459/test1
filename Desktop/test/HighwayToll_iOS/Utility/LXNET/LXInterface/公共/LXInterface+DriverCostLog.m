//
//  LXInterface+DriverCostLog.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/11.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXInterface+DriverCostLog.h"

@implementation LXInterface (DriverCostLog)
+ (NSMutableDictionary *)postDriverCostLog:(NSInteger)DriverCostLogId
                                MPDriverId:(NSString *)MPDriverId
                                  DriverId:(NSInteger)DriverId
                              MPCostTypeId:(NSString *)MPCostTypeId
                                CostTypeId:(NSInteger)CostTypeId
                                      Cost:(double)Cost
                                   Balance:(double)Balance
                                   AddTime:(NSDate *)AddTime{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"api/DriverCostLog/Post")
             forKey:@"url"];
    [dict setObject:@(DriverCostLogId) forKey:@"DriverCostLogId"];
    [dict setObject:kStringConvertNull(MPDriverId) forKey:@"MPDriverId"];
    [dict setObject:@(DriverId) forKey:@"DriverId"];
    [dict setObject:kStringConvertNull(MPCostTypeId) forKey:@"MPCostTypeId"];
    [dict setObject:@(Cost) forKey:@"Cost"];
    [dict setObject:@(Balance) forKey:@"Balance"];
    [dict setObject:AddTime forKey:@"AddTime"];
    return  dict;
}
@end
