//
//  LXMyJourneyModel.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/19.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXObject.h"

@interface LXMyJourneyModel : LXObject
@property (nonatomic,copy) NSString    *TollStateName;                        /**< 状态名称 */
@property (nonatomic,assign) NSInteger TollRecordId;                          /**< 行程id*/
@property (nonatomic,assign) NSInteger TollStateId;                           /**< */
@property (nonatomic,strong) NSString  *EntranceTime;                          /**< 进站时间 */
@property (nonatomic,strong) NSString  *ExitTime;                              /**< 出站时间 */
@property (nonatomic,strong) NSString  *CarNumber;                             /**< 车牌号 */
@property (nonatomic,assign) CGFloat   CostAmount;                            /**< 费用 */
@property (nonatomic,copy)  NSString   *MPEnterTollStationId;                 /**< 进站口id */
@property (nonatomic,copy)  NSString   *MPExitTollStationId;                  /**< 出站口id */
@property (nonatomic,copy)  NSString   *MPEnterTollStationName;               /**< 进站口Name */
@property (nonatomic,copy)  NSString   *MPExitTollStationName;                /**< 出站口Name */
@property (nonatomic,copy)  NSString  *CarId;                                /**<  */
@end
@interface LXMyJourneyListModel : LXObject
@property (nonatomic,strong) NSMutableArray *dataArray;         /**< 数组元素 */
@end
