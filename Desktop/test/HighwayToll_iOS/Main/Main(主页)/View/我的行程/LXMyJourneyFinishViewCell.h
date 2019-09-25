//
//  LXMyJourneyFinishViewCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/4.
//  Copyright © 2017年 zheng. All rights reserved.
//  状态完成

#import <UIKit/UIKit.h>

@interface LXMyJourneyFinishViewCell : UICollectionViewCell
@property (nonatomic,copy) NSString *enterTime;             /**< 进入时间 */
@property (nonatomic,copy) NSString *exitTime;              /**< 退出时间 */
@property (nonatomic,copy) NSString *plateNumber;           /**< 车牌号 */
@property (nonatomic,copy) NSString *costNumber;            /**< 时间 */
@property (nonatomic,copy) NSString *whenLong;              /**< 时长 */
@end
