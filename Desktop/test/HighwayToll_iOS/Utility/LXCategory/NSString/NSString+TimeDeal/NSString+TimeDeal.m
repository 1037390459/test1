//
//  NSString+TimeDeal.m
//  CarWins
//
//  Created by Lone on 16/5/27.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import "NSString+TimeDeal.h"

@implementation NSString (TimeDeal)

- (NSString *)timeTransformWhenUpdate
{
    return [self stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
}
- (NSString *)timeTransformWhenReduction
{
    return [self stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
}

@end
