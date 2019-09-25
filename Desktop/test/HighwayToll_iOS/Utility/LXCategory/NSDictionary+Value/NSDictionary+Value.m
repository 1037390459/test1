//
//  NSDictionary+Value.m
//  DYStore
//
//  Created by MyMac on 15/8/12.
//  Copyright (c) 2015年 daiyanwang. All rights reserved.
//

#import "NSDictionary+Value.h"

@implementation NSDictionary (Value)

- (NSString *)stringValueForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    
    if ([NSNull null] == (NSNull*)object) {
        return @"";
    }
    if ([object isEqual:@"null"]) {
        return @"";
    }
    return object ? [NSString stringWithFormat:@"%@", object] : @"";
}

- (int)intValueForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    return [object intValue];
}

- (float)floatValueForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    return [object floatValue];
}

- (double)doubleValueForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    return [object doubleValue];
}

- (BOOL)boolValueForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    return [object boolValue];
}

- (NSInteger)integerValueForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    return [object integerValue];
}

- (long long)longLongValueForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    return [object longLongValue];
}

@end
