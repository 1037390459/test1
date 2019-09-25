//
//  LXInterface+CarInfo.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/6.
//  Copyright © 2017年 zheng. All rights reserved.
//  车型选择

#import "LXInterface.h"
#import "LXAddVehicleModel.h"

@interface LXInterface (CarInfo)
/**
 退出登录
 
 @return <#return value description#>
 */
+ (NSMutableDictionary *)postCarInfoUploadPic;

/**
  设置默认车

 @param id <#id description#>
 @return <#return value description#>
 */
+ (NSMutableDictionary *)postCarInfoSetDefault:(NSInteger)id;

/**
  根据主键删除

 @param id <#id description#>
 @return <#return value description#>
 */
+ (NSMutableDictionary *)postCarInfoSetCarInfo:(NSInteger)id;

/**
 新增数据 车型

 @param carId carid
 @param MPCarTypeId 车型类别
 @param CarTypeId 车型类别
 @param MPCarStateId 状态编号
 @param CarStateId 状态编号
 @param CarNumber 车型编号
 @param VIN VIN
 @param EngineNo EngineNo
 @param CarImage 图片
 @param CarColor
 车颜色
 @param AddTime 添加时间
 @param UpdateTime 修改时间
 @param DeleteTime 删除时间
 @param DrivingLicence 行驶证
 @param Inuse 使用中
 @return <#return value description#>
 */
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
                                   Inuse:(BOOL )Inuse;
/**
 新增数据 车型
 
 @param carId carid
 @param MPCarTypeId 车型类别
 @param CarTypeId 车型类别
 @param MPCarStateId 状态编号
 @param CarStateId 状态编号
 @param CarNumber 车型编号
 @param VIN VIN
 @param EngineNo EngineNo
 @param CarImage 图片
 @param CarColor
 车颜色
 @param AddTime 添加时间
 @param UpdateTime 修改时间
 @param DeleteTime 删除时间
 @param DrivingLicence 行驶证
 @param Inuse 使用中
 @return <#return value description#>
 */
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
                                   Inuse:(BOOL )Inuse;

/**
 车辆列表

 @return return value description
 */
+ (NSMutableDictionary *)postCarInfoGetAllCar;

/**
 根据逐渐查找 车型

 @param id 车辆id
 @return return value description
 */
+ (NSMutableDictionary *)postCarInfoCarType:(NSString *)id;

/**
 根据条件获取 车型

 @return <#return value description#>
 */
+ (NSMutableDictionary *)postCarInfoCarTypeList;

/**
    开始用车

 @param CarId 车辆id
 @return return value description
 */
+ (NSMutableDictionary *)postCarInfoUseCar:(NSString *)CarId;
@end
