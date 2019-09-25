//
//  LXInterface+TollRecord.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/6.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXInterface+TollRecord.h"

@implementation LXInterface (TollRecord)
+ (NSMutableDictionary *)postTollRecordStartUseCar:(NSString *)carId{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"Toll/StartUseCar")
             forKey:@"url"];
    [dict setObject:kStringConvertNull(carId) forKey:@"carId"];
    return  dict;
}
+ (NSMutableDictionary *)postTollRecordEntranceToll:(NSString *)RecordId
                                      TollStationId:(NSString *)TollStationId
                                             LaneId:(NSString *)LaneId{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"Toll/EntranceToll")
             forKey:@"url"];
    [dict setObject:kStringConvertNull(RecordId) forKey:@"RecordId"];
    [dict setObject:kStringConvertNull(TollStationId) forKey:@"TollStationId"];
    [dict setObject:kStringConvertNull(LaneId) forKey:@"LaneId"];
    return  dict; 
}
+ (NSMutableDictionary *)postTollRecordFinishUseCar:(NSString *)RecordId{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"Toll/FinishUseCar")
             forKey:@"url"];
    [dict setObject:kStringConvertNull(RecordId) forKey:@"RecordId"];
    return  dict;
}
+ (NSMutableDictionary *)postTollRecordTollSysFinishUseCar:(NSString *)RecordId
                                             TollStationId:(NSString *)TollStationId
                                                    LaneId:(NSString *)LaneId
                                                 timeStamp:(NSString *)timeStamp
                                                      sign:(NSString *)sign{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"Toll/SysFinishUseCar")
             forKey:@"url"];
    [dict setObject:kStringConvertNull(RecordId) forKey:@"RecordId"];
    [dict setObject:kStringConvertNull(TollStationId) forKey:@"TollStationId"];
    [dict setObject:kStringConvertNull(LaneId) forKey:@"LaneId"];
    [dict setObject:kStringConvertNull(timeStamp) forKey:@"timeStamp"];
    [dict setObject:kStringConvertNull(sign) forKey:@"sign"];
    return  dict;
}
@end
