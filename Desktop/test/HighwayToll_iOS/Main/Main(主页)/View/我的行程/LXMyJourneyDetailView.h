//
//  LXMyJourneyDetailView.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/4.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LXMyJourneyDetailCommitBlock)(void);
@interface LXMyJourneyDetailView : UIView
@property (nonatomic,copy) NSString *intoTheStationStr;           /**< 驶入高速公路字符串 */
@property (nonatomic,copy) NSString *tollGateStr;                 /**< 离开高速公路 */
@property (nonatomic,copy) NSString *carNumber;                   /**< 车牌号 */
@property (nonatomic,copy) NSString *time;                        /**< 行驶时长 */
@property (nonatomic,copy) NSString *costNumber;                  /**< 费用详情 */
@property (nonatomic,copy) NSString *statusStr;                   /**< 状态 */
@property (nonatomic,copy) NSString *titleStr;                    /**< 标题 */
- (void)setLabelColor:(UILabel *)sender Str:(NSString *)contentStr min:(NSString *)min;
//------------------------------------------------
@property (nonatomic,copy) LXMyJourneyDetailCommitBlock block; /**<  */
- (void)didSelectCommitClick:(LXMyJourneyDetailCommitBlock)block;
@end
