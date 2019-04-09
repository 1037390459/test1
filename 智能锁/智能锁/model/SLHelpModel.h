//
//  SLHelpModel.h
//  智能锁
//
//  Created by million on 2019/4/10.
//  Copyright © 2019 million. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLHelpModel : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, assign) NSInteger type;
@property(nonatomic, assign) BOOL hidden;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
