//
//  NSString+TimeDeal.h
//  CarWins
//
//  Created by Lone on 16/5/27.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TimeDeal)

- (NSString *)timeTransformWhenUpdate;/**<将时间日期- 转为/*/
- (NSString *)timeTransformWhenReduction;/**<还原时间日期*/
@end
