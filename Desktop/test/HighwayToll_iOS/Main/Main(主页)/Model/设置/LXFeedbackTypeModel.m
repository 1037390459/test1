//
//  LXFeedbackTypeModel.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/18.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXFeedbackTypeModel.h"

@implementation LXFeedbackTypeModel

@end
@implementation LXFeedbackTypeListModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"data"]) {
        if (!_dataArray) {
            _dataArray = [[NSMutableArray alloc] init];
        }if (!_dataNameArray) {
            _dataNameArray = [[NSMutableArray alloc] init];
        }
        for (NSDictionary *dict in value) {
            LXFeedbackTypeModel *model = [[LXFeedbackTypeModel alloc] initWithDictionary:dict];
            NSString *title = [dict objectForKey:@"FeedBackTitle"];
            [_dataNameArray addObject:kStringConvertNull(title)];
            [_dataArray addObject:model];
        }
    }
}
@end
