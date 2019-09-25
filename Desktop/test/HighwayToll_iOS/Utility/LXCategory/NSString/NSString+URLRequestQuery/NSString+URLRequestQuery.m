//
//  NSString+URLRequestQuery.m
//  CarWins
//
//  Created by Dandre on 16/4/23.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import "NSString+URLRequestQuery.h"

@implementation NSString (URLRequestQuery)

- (NSString *)requestQuery:(NSString *)query
{
    NSString *request = self.lowercaseString;
    NSString *queryCopy = query.lowercaseString;
    if ([request containsString:queryCopy]) {
        NSArray *arr = [request componentsSeparatedByString:[NSString stringWithFormat:@"%@=",queryCopy]];
        if (arr.count) {
            NSString *str = [arr lastObject];
            NSArray *queryArr = [str componentsSeparatedByString:@"&"];
            if (queryArr) {
                return [queryArr firstObject];
            }else{
                return @"";
            }
        }else{
            return @"";
        }
    }else{
        return @"";
    }
}

- (NSString *)request:(NSString *)query
{
    return [self requestQuery:query];
}

@end
