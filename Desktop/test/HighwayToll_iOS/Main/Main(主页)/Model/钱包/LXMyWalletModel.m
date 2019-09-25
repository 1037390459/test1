//
//  LXMyWalletModel.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/13.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyWalletModel.h"

@implementation LXMyWalletModel

@end
@implementation LXMyWalletListModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"rows"]) {
        if (!_dataArray) {
            _dataArray = [[NSMutableArray alloc] init];
        } 
        for (NSDictionary *dict in value) {
            LXMyWalletModel *model = [[LXMyWalletModel alloc] initWithDictionary:dict];
            NSDictionary *dic = [dict objectForKey:@"MPCostTypeId"];
            if (dic) {
                model.CostTypeName = kStringConvertNull(dic[@"CostTypeName"]);
            }
            [_dataArray addObject:model];
        }
    }
}
@end
