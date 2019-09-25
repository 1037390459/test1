
//
//  LXMyJourneyDrivingViewCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/4.
//  Copyright © 2017年 zheng. All rights reserved.
//  行驶中

#import <UIKit/UIKit.h>

@interface LXMyJourneyDrivingViewCell : UICollectionViewCell
@property (nonatomic,copy) NSString *plateNumber;           /**< 车牌号 */
@property (nonatomic,copy) NSString *enterTime;             /**< 进入时间 */
@end
