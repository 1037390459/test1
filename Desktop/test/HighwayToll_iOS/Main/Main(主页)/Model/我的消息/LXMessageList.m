//
//  LXMessageList.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/13.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMessageList.h"

@implementation LXMessageList
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
  
    if ([key isEqualToString:@"rows"]) {
       
        if (!_dataArray) {
            _dataArray = [[NSMutableArray alloc] init];
        }
        for (NSDictionary *dict in value) {
            LXMessageModel *model = [[LXMessageModel alloc] initWithDictionary:dict];
            NSDictionary *dic = [dict objectForKey:@"MPMsgTypeId"];
            if (![dic isKindOfClass:[NSNull class]]) {
                model.TypeName = kStringConvertNull(dic[@"TypeName"]);
            } 
            model.BorrowInfo = [[LXBorrowInfoModel alloc] initWithDictionary:dict[@"BorrowInfo"]];
             [_dataArray addObject:model];
        }
    }
}
@end
@implementation LXBorrowInfoModel
@end
@implementation LXMessageModel

@end
@implementation LXMyMessageList
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
 
    if ([key isEqualToString:@"data"]) {
        if (!_dataArray) {
            _dataArray = [[NSMutableArray alloc] init];
        }
         LXMyMessageModel *model = [[LXMyMessageModel alloc] initWithDictionary:value];
        model.LastLetter =  [[LXMyMessageDetailModel alloc] initWithDictionary:[value objectForKey:@"LastLetter"]];
        model.LastNotice =  [[LXMyMessageDetailModel alloc] initWithDictionary:[value objectForKey:@"LastNotice"]];
        model.RequestCar =  [[LXMyMessageDetailModel alloc] initWithDictionary:[value objectForKey:@"RequestCar"]];
        model.BorrowCar =   [[LXMyMessageDetailModel alloc] initWithDictionary:[value objectForKey:@"BorrowCar"]];
         [_dataArray addObject:model];
        
    }
}
@end
@implementation LXMyMessageModel

@end
@implementation LXMyMessageDetailModel

@end
