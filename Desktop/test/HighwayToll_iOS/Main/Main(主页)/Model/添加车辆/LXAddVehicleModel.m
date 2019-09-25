//
//  LXAddVehicleModel.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/11.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXAddVehicleModel.h"

@implementation LXAddVehicleModel
 
@end
@implementation LXDriversLicenseType

@end
@implementation LXCarType

@end
@implementation LXCarState

@end
@implementation LXAddVehicleListDataModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"data"]) {
        if (!_dataArray) {
            _dataArray = [[NSMutableArray alloc] init];
        }
        if (!_dataNameArray) {
            _dataNameArray = [[NSMutableArray alloc] init];
        }
        for (NSDictionary *dict in value) {
            LXAddVehicleListModel *model = [[LXAddVehicleListModel alloc] initWithDictionary:dict];
            if (self.isFlag     &&
                model.State ==  2) {
                [_dataArray addObject:model];
                [_dataNameArray addObject:kStringConvertNull(model.CarNumber)];
            }else{
                 [_dataArray addObject:model];
            }
            
        }
    }
}
@end
@implementation LXAddVehicleListModel

@end
@implementation LXAddCarTypeListDataModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"data"]) {
        if (!_dataArray) {
            _dataArray = [[NSMutableArray alloc] init];
        }
        if(!_carTypeArray){
            _carTypeArray = [[NSMutableArray alloc] init];
        }
        for (NSDictionary *dict in value) {
            LXCarType *model = [[LXCarType alloc] initWithDictionary:dict];
            [_dataArray addObject:model];
            [_carTypeArray addObject:model.CarCatalogName];
        }
    }
}
@end

@implementation LXCarDetatilModel
@end
