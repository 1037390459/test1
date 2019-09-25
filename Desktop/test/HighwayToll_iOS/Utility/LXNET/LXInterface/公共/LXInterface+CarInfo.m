//
//  LXInterface+CarInfo.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/6.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXInterface+CarInfo.h"
@implementation LXInterface (CarInfo)
+ (NSMutableDictionary *)postCarInfoUploadPic{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"Car/UploadPic")
             forKey:@"url"];
    return dict;
}
+ (NSMutableDictionary *)postCarInfoCarType:(NSString *)id{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:@"%@?id=%@",kLXHttpPostUrl(@"api/CarInfo/GetCarById"),id]
             forKey:@"url"]; 
    return dict;
}
+ (NSMutableDictionary *)postCarInfoSetDefault:(NSInteger)carId{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:@"%@?id=%ld",kLXHttpPostUrl(@"Car/SetDefault"),(long)carId]
             forKey:@"url"];
    return  dict;
}
+ (NSMutableDictionary *)postCarInfoSetCarInfo:(NSInteger)id{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"api/CarInfo")
             forKey:@"url"];
    [dict setObject:@(id) forKey:@"id"];
    return  dict;
}
+ (NSMutableDictionary *)postCarInfoPost:(NSString *)carId
                             MPCarTypeId:(LXCarType *)MPCarTypeId
                               CarTypeId:(NSString *)CarTypeId
                            MPCarStateId:(NSString *)MPCarStateId
                              CarStateId:(LXCarState *)CarStateId
                               CarNumber:(NSString *)CarNumber
                                     VIN:(NSString *)VIN
                                EngineNo:(NSString *)EngineNo
                                CarImage:(NSString *)CarImage
                                CarColor:(NSString *)CarColor
                                 AddTime:(NSDate *)AddTime
                              UpdateTime:(NSDate *)UpdateTime
                              DeleteTime:(NSDate *)DeleteTime
                          DrivingLicence:(NSString *)DrivingLicence
                                   Inuse:(BOOL )Inuse{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"api/CarInfo/Post")
             forKey:@"url"];
    [dict setObject:carId forKey:@"carId"];
    [dict setObject:
     [LXCommon dictionaryWithModel:MPCarTypeId]
             forKey:@"MPCarTypeId"];
    [dict setObject:CarTypeId forKey:@"CarTypeId"];
    [dict setObject:MPCarStateId forKey:@"MPCarStateId"];
    [dict setObject:[LXCommon dictionaryWithModel:CarStateId]
             forKey:@"CarStateId"];
    [dict setObject:CarNumber forKey:@"CarNumber"];
    [dict setObject:VIN forKey:@"VIN"];
    [dict setObject:EngineNo forKey:@"EngineNo"];
    [dict setObject:CarImage forKey:@"CarImage"];
    [dict setObject:CarColor forKey:@"CarColor"];
    [dict setObject:AddTime forKey:@"AddTime"];
    [dict setObject:UpdateTime forKey:@"UpdateTime"];
    [dict setObject:DeleteTime forKey:@"DeleteTime"];
    [dict setObject:DrivingLicence forKey:@"DrivingLicence"];
    [dict setObject:@(Inuse) forKey:@"Inuse"];
    return  dict;
}
+ (NSMutableDictionary *)postCarInfoAddCar:(NSString *)carId
                                  isDefault:(BOOL)isDefault
                                MPCarTypeId:(NSString *)MPCarTypeId
                                  CarTypeId:(NSString *)CarTypeId
                               MPCarStateId:(NSString *)MPCarStateId
                                 CarStateId:(LXCarState *)CarStateId
                                  CarNumber:(NSString *)CarNumber
                                        VIN:(NSString *)VIN
                                   EngineNo:(NSString *)EngineNo
                                   CarImage:(NSString *)CarImage
                                   CarColor:(NSString *)CarColor
                                    AddTime:(NSDate *)AddTime
                                 UpdateTime:(NSDate *)UpdateTime
                                 DeleteTime:(NSDate *)DeleteTime
                             DrivingLicence:(NSString *)DrivingLicence
                                     Inuse:(BOOL )Inuse{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:@"%@?isDefault=%i",kLXHttpPostUrl(@"api/CarInfo/AddCar"),isDefault]
             forKey:@"url"];
    [dict setObject:kStringConvertNull(carId) forKey:@"carId"];
    [dict setObject: MPCarTypeId
             forKey:@"CarTypeId"];
   // [dict setObject:kStringConvertNull(CarTypeId) forKey:@"CarTypeId"];
    //[dict setObject:kStringConvertNull(MPCarStateId) forKey:@"MPCarStateId"];
   // [dict setObject:[LXCommon dictionaryWithModel:CarStateId]
       //      forKey:@"CarStateId"];
    [dict setObject:kStringConvertNull(CarNumber) forKey:@"CarNumber"];
    [dict setObject:kStringConvertNull(VIN) forKey:@"VIN"];
    [dict setObject:kStringConvertNull(EngineNo) forKey:@"EngineNo"];
    [dict setObject:kStringConvertNull(CarImage) forKey:@"CarImage"];
    [dict setObject:kStringConvertNull(CarColor) forKey:@"CarColor"];
    //[dict setObject:AddTime forKey:@"AddTime"];
   // [dict setObject:UpdateTime forKey:@"UpdateTime"];
   // [dict setObject:DeleteTime forKey:@"DeleteTime"];
    [dict setObject:kStringConvertNull(DrivingLicence) forKey:@"DrivingLicence"];
   // [dict setObject:@(Inuse) forKey:@"Inuse"];
    return  dict;
}
+ (NSMutableDictionary *)postCarInfoGetAllCar{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"api/CarInfo/GetAllCar")
             forKey:@"url"];
    return dict;
}
+ (NSMutableDictionary *)postCarInfoCarTypeList{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kLXHttpPostUrl(@"api/CarInfo/GetCarType")
             forKey:@"url"];
    return dict;
}
+ (NSMutableDictionary *)postCarInfoUseCar:(NSString *)CarId{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:@"%@?carid=%@",kLXHttpPostUrl(@"Toll/StartUseCar"),CarId]
             forKey:@"url"];
    return dict;
}
@end
