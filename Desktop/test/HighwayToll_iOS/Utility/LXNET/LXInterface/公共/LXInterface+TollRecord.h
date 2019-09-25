//
//  LXInterface+TollRecord.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/6.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXInterface.h"

@interface LXInterface (TollRecord)

/**
 开始用车

 @param carId <#carId description#>
 @return <#return value description#>
 */
+ (NSMutableDictionary *)postTollRecordStartUseCar:(NSString *)carId;

/**
  进入收费站

 @param RecordId <#RecordId description#>
 @param TollStationId <#TollStationId description#>
 @param LaneId <#LaneId description#>
 @return <#return value description#>
 */
+ (NSMutableDictionary *)postTollRecordEntranceToll:(NSString *)RecordId
                                      TollStationId:(NSString *)TollStationId
                                             LaneId:(NSString *)LaneId;

/**
    结束用车

 @param RecordId <#RecordId description#>
 @return <#return value description#>
 */
+ (NSMutableDictionary *)postTollRecordFinishUseCar:(NSString *)RecordId;

/**
 收费站系统调用接口

 @param RecordId <#RecordId description#>
 @param TollStationId <#TollStationId description#>
 @param LaneId <#LaneId description#>
 @param timeStamp <#timeStamp description#>
 @param sign <#sign description#>
 @return <#return value description#>
 */
+ (NSMutableDictionary *)postTollRecordTollSysFinishUseCar:(NSString *)RecordId
                                             TollStationId:(NSString *)TollStationId
                                                    LaneId:(NSString *)LaneId
                                                 timeStamp:(NSString *)timeStamp
                                                      sign:(NSString *)sign;


@end
