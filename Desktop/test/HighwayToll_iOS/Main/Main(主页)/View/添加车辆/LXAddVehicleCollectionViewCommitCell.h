//
//  LXAddVehicleCollectionViewCommitCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/24.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LXAddVehicleCollectionViewCommitCellBlock)(void);
@interface LXAddVehicleCollectionViewCommitCell : UICollectionViewCell
@property (nonatomic,strong) UIButton *loginBtn;                            /**< 提交按钮 */
@property (nonatomic,strong) UILabel *descriptLabel;                        /**< 描述 */
@property (nonatomic,copy) LXAddVehicleCollectionViewCommitCellBlock block ; /**<  */
- (void)didSelectClick:(LXAddVehicleCollectionViewCommitCellBlock )block;
@end
