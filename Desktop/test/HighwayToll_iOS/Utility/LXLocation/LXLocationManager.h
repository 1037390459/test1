//
//  LXLocationManager.h
//  LX
//
//  Created by cheng on 2017/10/17.
//  Copyright © 2017年 LX Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXLocationManager : NSObject

@property (nonatomic, copy) NSString  *province;        /**< 省份>*/
@property (nonatomic, copy) NSString  *city;            /**< 城市>*/
@property (nonatomic, copy) NSString  *locationDetail;  /**< 详细地址>*/
@property (nonatomic, assign) CGFloat  longitude;       /**< 经度>*/
@property (nonatomic, assign) CGFloat  latitude;        /**< 韦度>*/

/**
 1.单例对象
 
 @return return value description
 */
+ (instancetype)shareInstance;

/**
 2.开启定位
 */
- (void)startLocation;

/**
 3.停止定位
 */
- (void)stopLocation;



@end
