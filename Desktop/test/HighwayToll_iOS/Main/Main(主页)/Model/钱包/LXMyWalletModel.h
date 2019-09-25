//
//  LXMyWalletModel.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/13.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXObject.h"

@interface LXMyWalletModel : LXObject
@property (nonatomic,assign) NSInteger  DriverCostLogId;    /**< 主键 */
@property (nonatomic,strong) NSString   *DriverId;          /**< 驾驶人id */
@property (nonatomic,copy) NSString *CostTypeName;          /**< 消费title */
@property (nonatomic,assign) CGFloat Cost;                  /**< 金额*/
@property (nonatomic,strong) NSString *AddTime;             /**< 添加时间 */

@end
@interface LXMyWalletListModel : LXObject
@property (nonatomic,strong) NSMutableArray  *dataArray;            /**< 时间 */
@end
