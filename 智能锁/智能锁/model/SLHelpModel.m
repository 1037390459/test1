//
//  SLHelpModel.m
//  智能锁
//
//  Created by million on 2019/4/10.
//  Copyright © 2019 million. All rights reserved.
//

#import "SLHelpModel.h"

@implementation SLHelpModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.title = dic[@"title"];
        self.type = [dic[@"type"] integerValue];
        self.hidden = [dic[@"hidden"] boolValue];
    }
    return self;
}

@end
