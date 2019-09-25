//
//  LXMyJourneyDrivingNotUseViewCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/19.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LXMyJourneyDrivingNotUseViewBlock)(void);
@interface LXMyJourneyDrivingNotUseViewCell : UICollectionViewCell
@property (nonatomic,copy) NSString *plateNumber;           /**< 车牌号 */
@property (nonatomic,copy) LXMyJourneyDrivingNotUseViewBlock block; /**<  */
- (void)didSelectClick:(LXMyJourneyDrivingNotUseViewBlock)block;
@end
