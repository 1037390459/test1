//
//  CWParentModel.m
//  CarWins
//
//  Created by Dandre on 16/3/22.
//  Copyright © 2016年 Dandre. All rights reserved.
//

#import "LXObject.h"

@implementation LXObject

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [self init];
    if ([dict isKindOfClass:[NSDictionary class]]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"Code"]) {
        _code = [value integerValue];
    }else if ([key isEqualToString:@"Message"]) {
        _message = value;
    }
    
    DLog(@"key %@ is missed! value：%@",key,value);
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

//时间格式日期转换
- (NSString *)dateFormTransfer:(NSString *)dateString{
    NSString *dataStr = [[[dateString componentsSeparatedByString:@" "] firstObject] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    if ([LXDate isValidDateStr:dataStr]) {
        return dataStr;
    }
    return @"";
}


@end
