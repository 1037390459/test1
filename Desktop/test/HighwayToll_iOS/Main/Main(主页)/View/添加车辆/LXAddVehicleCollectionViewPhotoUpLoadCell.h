//
//  LXAddVehicleCollectionViewPhotoUpLoadCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/24.
//  Copyright © 2017年 zheng. All rights reserved.
//  图片上传cell

#import <UIKit/UIKit.h>
typedef void (^LXAddVehicleCollectionViewPhotoUpLoadCellBlock)(NSString *title);
@interface LXAddVehicleCollectionViewPhotoUpLoadCell : UICollectionViewCell
@property (nonatomic,strong) UIButton *carFrontViewBtn;                 /**< 车头照片btn */
@property (nonatomic,strong) UIButton *drivingLicenseBtn;               /**< 行驶证btn */
@property (nonatomic,strong) UILabel *carFrontViewLabel;                /**< 车头照片label */
@property (nonatomic,strong) UILabel *drivingLicenseLabel;              /**< 行驶证label */
@property (nonatomic,strong) UILabel *descriptLabel;                    /**< 描述 */
@property (nonatomic,copy) LXAddVehicleCollectionViewPhotoUpLoadCellBlock block;    /**< 闭包 */
- (void)didSelectUpLoadPic:(LXAddVehicleCollectionViewPhotoUpLoadCellBlock)block; 
@property (nonatomic,strong) UIImage *carFrontViewImg;                  /**< 车头照片btn */
@property (nonatomic,strong) UIImage *drivingLicenseImg;                /**< 行驶证btn */
@end
