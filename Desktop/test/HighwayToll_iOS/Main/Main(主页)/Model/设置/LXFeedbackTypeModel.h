//
//  LXFeedbackTypeModel.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/18.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXObject.h"

@interface LXFeedbackTypeModel : LXObject
@property (nonatomic,assign) NSInteger FeedbackTypeId;        /**< 主键id */
@property (nonatomic,copy) NSString *FeedBackTitle;           /**<  name  */
@end
@interface LXFeedbackTypeListModel : LXObject
@property (nonatomic,strong) NSMutableArray *dataArray;     /**<  */
@property (nonatomic,strong) NSMutableArray *dataNameArray; /**<  */
@end
