//
//  LXAddVehicleModel.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/11.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXObject.h"

@interface LXAddVehicleModel : LXObject
@property (nonatomic,assign) NSInteger CarId;                   /**< 车辆ID*/
@property (nonatomic,assign) NSInteger CarTypeId;               /**< CarTypeId*/
@property (nonatomic,assign) NSInteger CarStateId;              /**<  状态编号*/
@property (nonatomic,strong) NSString *CarNumber;               /**<  车型编号*/
@property (nonatomic,strong) NSString *VIN;                     /**<  VIN*/
@property (nonatomic,strong) NSString *EngineNo;                /**<  发动机编号*/
@property (nonatomic,strong) NSString *CarImage;                /**<  图片*/
@property (nonatomic,strong) NSString *CarColor;                /**<  车颜色*/
@property (nonatomic,strong) NSDate   *AddTime;                 /**<  添加时间*/
@property (nonatomic,strong) NSDate   *UpdateTime;              /**< 修改时间*/
@property (nonatomic,strong) NSDate   *DeleteTime;              /**<  删除时间*/
@property (nonatomic,strong) NSString   *DrivingLicence;        /**<  行驶证*/
@property (nonatomic,strong) NSString *carTypeName;             /**<  */
@property (nonatomic,assign) BOOL   Inuse;                      /**<  使用中*/
@property (nonatomic,assign) BOOL   isDefault;                      /**<  使用中*/
@end
@interface LXDriversLicenseType : LXObject
@property (nonatomic,assign) NSInteger DriversLicenseTypeId;        /**< */
@property (nonatomic,strong) NSString *DriversLicenseTypeName;      /**< 驾照类型 */
@property (nonatomic,strong) NSString *EnumName;                    /**< 枚举类型 */
@end
@interface LXCarType : LXObject
@property (nonatomic,assign) NSInteger CarTypeId; /**< CarTypeId */
@property (nonatomic,strong) LXDriversLicenseType *MPDriversLicenseTypeId; /**< 驾驶证类别 */
@property (nonatomic,assign) NSInteger DriversLicenseTypeId;     /**< 驾驶证类别 */
@property (nonatomic,strong) NSString *CarCatalogName;           /**< 车系名称 */
@property (nonatomic,assign) NSInteger ParentId;                 /**< 上一级 */
@property (nonatomic,assign) NSInteger NavLevel;                 /**< 导航级别 */
@property (nonatomic,assign) NSInteger SortNO;                   /**< 排序号 */
@property (nonatomic,assign) NSInteger EnumName;                 /**< 枚举类型 */
@property (nonatomic,strong) NSDate *AddTime;                    /**< 添加时间 */
@property (nonatomic,strong) NSDate *UpdateTime;                 /**< 修改时间 */
@property (nonatomic,strong) NSDate *DeleteTime;                 /**< 删除时间 */
@end
@interface LXCarState : LXObject
@property (nonatomic,assign) NSInteger CarStateId;        /**< {displayName:"状态编号"}*/
@property (nonatomic,strong) NSString *CarStateName;      /**< 状态名称 */
@property (nonatomic,strong) NSString *EnumName;          /**< DriverStateEnum */
@end
@interface LXAddVehicleListModel : LXObject
@property (nonatomic,assign) NSInteger  CarId;      /**<  carid*/
@property (nonatomic,strong) NSString *CarNumber;   /**<  车牌*/
@property (nonatomic,strong) NSString *CarColor;    /**<  车颜色*/
@property (nonatomic,assign) NSInteger CarStateId;  /**<  状态 */
@property (nonatomic,strong) NSString *Owner;       /**<  真是姓名 */
@property (nonatomic,assign) NSInteger State ;      /**<  状态*/
@property (nonatomic,assign) bool Inuse;            /**<  */
@property (nonatomic,strong) NSString *CarCatalogName; /**< 车型名称 */
@end
@interface LXAddVehicleListDataModel :LXObject
@property (nonatomic,strong) NSMutableArray *dataArray;             /**<  */
@property (nonatomic,assign) bool isFlag;                           /**< */
@property (nonatomic,strong) NSMutableArray *dataNameArray;         /**<  */
@end
@interface LXAddCarTypeListDataModel :LXObject
@property (nonatomic,strong) NSMutableArray *dataArray;            /**<  */
@property (nonatomic,strong) NSMutableArray *carTypeArray; /**<  */
@end

@interface LXCarDetatilModel :LXObject
@property (nonatomic,assign) NSInteger  CarId;                  /**<  carid*/
@property (nonatomic,strong) NSString *CarNumber;               /**<  车牌*/
@property (nonatomic,strong) NSString *CarColor;                /**<  车颜色*/
@property (nonatomic,assign) NSInteger CarStateId;              /**<  状态 */
@property (nonatomic,strong) NSString *Owner;                   /**<  真是姓名 */
@property (nonatomic,assign) NSInteger State ;                  /**<  状态*/
@property (nonatomic,assign) bool Inuse;                        /**<  */
@property (nonatomic,strong) NSString *CarCatalogName;          /**< 车型名称 */
@property (nonatomic,assign) NSInteger CarTypeId;            /**<  */
@property (nonatomic,strong) NSString   *DrivingLicence;        /**<  行驶证*/
@property (nonatomic,strong) NSString *VIN;                     /**<  VIN*/
@property (nonatomic,strong) NSString *EngineNo;                /**<  发动机编号*/
@property (nonatomic,strong) NSString *CarImage;                /**<  图片*/
@property (nonatomic,assign) bool IsDefault;                    /**< 是不是默认 */
@end

