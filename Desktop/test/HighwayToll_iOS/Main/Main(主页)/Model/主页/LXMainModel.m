//
//  LXMainModel.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/21.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMainModel.h"

@implementation LXMainModel

@end
@implementation LXMainListModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"rows"]) {
        if (!_dataArray) {
            _dataArray = [[NSMutableArray alloc] init];
        }if (!_imageArray) {
            _imageArray = [[NSMutableArray alloc] init];
        }
        for (NSDictionary *dict in value) {
            LXMainModel *model = [[LXMainModel alloc] initWithDictionary:dict];
            [_imageArray addObject:[NSString stringWithFormat:@"%@%@",KimageUrl,model.ImageUrl]];
            [_dataArray addObject:model];
        }
    }
}
@end
