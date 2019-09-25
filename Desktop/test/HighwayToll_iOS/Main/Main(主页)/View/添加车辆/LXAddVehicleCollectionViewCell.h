//
//  LXAddVehicleCollectionViewCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/24.
//  Copyright © 2017年 zheng. All rights reserved.
//  添加车辆的第一个cell

#import <UIKit/UIKit.h>
typedef void (^LXAddVehicleCollectionViewCellBlock)(void);
@interface LXAddVehicleCollectionViewCell : UICollectionViewCell 
@property (nonatomic,strong) UIButton *titleBtn;             /**< 车牌号码 */
@property (nonatomic,copy) NSString  *strTitle;              /**< 字符串 */
@property (nonatomic,copy) NSString *contentStr;             /**< 内容文本 */
@property (nonatomic,copy) LXAddVehicleCollectionViewCellBlock block; /**<  */
- (void)didSelectTypeClick:(LXAddVehicleCollectionViewCellBlock)block;
@end
