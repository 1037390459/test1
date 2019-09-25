//
//  LXLendACarToAfriendSelectPlateCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/27.
//  Copyright © 2017年 zheng. All rights reserved.
//  车牌选择

#import <UIKit/UIKit.h> 
@interface LXLendACarToAfriendSelectPlateCell : UICollectionViewCell
@property (nonatomic,copy) NSString *contentStr;                 /**<  */
@property (nonatomic,strong) NSString *titleStr;                 /**<  title*/
@property (nonatomic,strong) UILabel *contentLabel;              /**< 内容label */
@end
