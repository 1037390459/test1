//
//  LXMainHaveEnteredHighWayView.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/4.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LXMainHaveEnteredHighWayViewBlock)(NSInteger tag);
@interface LXMainHaveEnteredHighWayView : UIView
@property (nonatomic,copy) NSString *intoTheStationStr;             /**< 驶入高速公路字符串 */
@property (nonatomic,copy) NSString *plateStr;                      /**< 车牌号 */
@property (nonatomic,copy) NSString *time;                          /**< 时间 */
//------------------------------------------------
@property (nonatomic,copy) LXMainHaveEnteredHighWayViewBlock block; /**<  */
- (void)didSelectCommitClick:(LXMainHaveEnteredHighWayViewBlock)block;
@end
