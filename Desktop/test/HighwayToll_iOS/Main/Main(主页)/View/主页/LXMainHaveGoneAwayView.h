//
//  LXMainHaveGoneAwayView.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/4.
//  Copyright © 2017年 zheng. All rights reserved.
//  已离开

#import <UIKit/UIKit.h>
typedef void (^LXMainHaveGoneAwayViewCommitBlock)(NSInteger tag);
@interface LXMainHaveGoneAwayView : UIView
@property (nonatomic,copy) NSString *intoTheStationStr;           /**< 驶入高速公路字符串 */
@property (nonatomic,copy) NSString *tollGateStr;                 /**< 离开高速公路 */
- (void)setLabelColor:(UILabel *)sender Str:(NSString *)contentStr min:(NSString *)min;
//------------------------------------------------
@property (nonatomic,copy) LXMainHaveGoneAwayViewCommitBlock block; /**<  */
- (void)didSelectCommitClick:(LXMainHaveGoneAwayViewCommitBlock)block;
@end
