//
//  LXMyJourneyModel.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/19.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyJourneyModel.h"

@implementation LXMyJourneyModel

@end
@implementation LXMyJourneyListModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"rows"]) {
        if (!_dataArray) {
            _dataArray = [[NSMutableArray alloc] init];
        }
        for (NSDictionary *dict in value) {
            LXMyJourneyModel *model = [[LXMyJourneyModel alloc] initWithDictionary:dict];
            model.TollStateName          = kStringConvertNull(dict[@"MPTollStateId"][@"TollStateName"]);
           
            if (![dict[@"MPCarId"] isKindOfClass:[NSNull class]]) {
                model.CarNumber              = kStringConvertNull(dict[@"MPCarId"][@"CarNumber"]);
                model.CarId                  = (dict[@"MPCarId"][@"CarId"]) ;
            }else{
                model.CarNumber              = @"";
                model.CarId                  = @"";
            }
            NSDictionary *dic = dict[@"MPEntranceTollStationId"];
            if (![dic isKindOfClass:[NSNull class]]) {
                model.MPEnterTollStationName = kStringConvertNull(dict[@"MPEntranceTollStationId"][@"TollStationName"]);
                model.MPEnterTollStationId   = kStringConvertNull(dict[@"MPEntranceTollStationId"][@"TollStationId"]);
            }else{
                model.MPEnterTollStationName = @"";
                model.MPEnterTollStationId   = @"";
            }
            NSDictionary *dictt = dict[@"MPExitTollStationId"];
            if (![dictt isKindOfClass:[NSNull class]]) {
                model.MPExitTollStationId    = kStringConvertNull(dict[@"MPExitTollStationId"][@"TollStationId"]);
                model.MPExitTollStationName    = kStringConvertNull(dict[@"MPExitTollStationId"][@"TollStationName"]);
            }else{
                model.MPExitTollStationId    = @"";
                model.MPExitTollStationName    = @"";
            }
           
            [_dataArray addObject:model];
        }
    }
}

@end
