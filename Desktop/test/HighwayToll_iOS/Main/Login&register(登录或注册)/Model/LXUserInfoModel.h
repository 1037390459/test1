//
//  LXUserInfoModel.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/6.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXObject.h"
@interface LXCarModel : LXObject
@property (nonatomic,assign) NSInteger CarId;                /**< 车辆编号*/
@property (nonatomic,assign) NSInteger DriverId;             /**< 驾驶人编号*/
@property (nonatomic,copy) NSString *CarNumber;              /**< 车牌号 */
@property (nonatomic,assign) bool IsDefaultCar; ;       /**< 默认车 */
@property (nonatomic,assign) bool Inuse;                     /**< 使用*/
@end

@interface LXUserInfoModel : LXObject
/**
 *  创建单例对象
 *
 *  @return instancetype
 */
+ (instancetype)shareUser;
@property (nonatomic,assign) NSInteger DriverId;                        /**< 驾驶员ID */
@property (nonatomic,assign) NSInteger DriverStateId;                   /**< 驾驶员状态id */
@property (nonatomic,strong) NSString *DriverStateName;                 /**< 驾驶员状态名字 */
@property (nonatomic,strong) NSString *LoginName;                       /**< 用户名 */
@property (nonatomic,strong) NSString *RealName;                        /**< 真实姓名 */
@property (nonatomic,strong) NSString *Phone;                           /**< 电话 */
@property (nonatomic,strong) NSString *Email;                           /**< 邮箱 */
@property (nonatomic,strong) NSString *AvatorImage;                     /**< 头像 */
@property (nonatomic,strong) NSString *DriversLicenseNumber;            /**< 驾驶证 */
@property (nonatomic,strong) NSString *DriversLicenseImage;             /**< 驾驶证图片 */
@property (nonatomic, assign) BOOL   isLogin;                           /**  用户是否登录 */
@property (nonatomic,strong) NSString *WeChat;                          /**< 微信 */
@property (nonatomic,assign) CGFloat Balance;                           /**< 金额 */
@property (nonatomic,strong) NSMutableArray<LXCarModel *> *Cars;        /**< 车辆 */
- (void)removeAllUserInfo;
@end


