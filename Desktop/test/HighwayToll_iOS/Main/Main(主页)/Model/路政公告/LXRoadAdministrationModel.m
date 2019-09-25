//
//  LXRoadAdministrationModel.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/21.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXRoadAdministrationModel.h"

@implementation LXRoadAdministrationModel

@end
@implementation LXRoadAdministrationDetailModel

@end
@implementation LXRoadAdministrationListModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"rows"]) {
        if (!_dataArray) {
            _dataArray = [[NSMutableArray alloc] init];
        }
        for (NSDictionary *dict in value) {
            LXRoadAdministrationModel *model = [[LXRoadAdministrationModel alloc] initWithDictionary:dict]; 
            [_dataArray addObject:model];
        }
    }
}
@end
