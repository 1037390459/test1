//
//  LXMyVehicleCollectionViewCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/27.
//  Copyright © 2017年 zheng. All rights reserved.
//  我的车辆

#import <UIKit/UIKit.h>
typedef void (^LXMyVehicleCollectionViewCellBlock)(void);
@interface LXMyVehicleCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UILabel *plateNumberLabel;              /**<   车牌号码 */
@property (nonatomic,strong) UILabel *owner;                         /**<   拥有人 */
@property (nonatomic,strong) UILabel *carColor;                      /**<   车身颜色 */
@property (nonatomic,strong) UILabel *carType;                       /**<   车辆类型 */
@property (nonatomic,strong) UIImageView  *viewImage;                /**<   车辆类型 */
@property (nonatomic,strong) UIButton *rightIcon;                    /**<   右边视图 */
@property (nonatomic,strong) UIImageView *borrowIcon;                /**<   借icon*/
@property (nonatomic,copy) NSString *plateNumberStr;                 /**<   车牌号码 */
@property (nonatomic,copy) NSString *ownerStr;                       /**<   拥有人 */
@property (nonatomic,copy) NSString *carColorStr;                    /**<   车身颜色 */
@property (nonatomic,copy) NSString *carTypeStr;                     /**<   车辆类型 */
@property (nonatomic,assign) bool  isBorrow;                         /**<   借车*/
@property (nonatomic,assign) bool  isShowRight;                       /**<   借车*/
@property (nonatomic,copy) LXMyVehicleCollectionViewCellBlock  block; /**<  是否显示 */
- (void)didSelectClick:(LXMyVehicleCollectionViewCellBlock)block;
@end
