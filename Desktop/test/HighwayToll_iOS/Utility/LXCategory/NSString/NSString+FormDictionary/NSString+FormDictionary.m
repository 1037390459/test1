//
//  NSString+FormDictionary.m
//  CarWins
//
//  Created by Dandre on 16/5/4.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import "NSString+FormDictionary.h"

@implementation NSString (FormDictionary)

+ (NSString *)stringWithDictionary:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString *base64Str = [NSString base64StringWithString:str];
    
    return [NSString stringWithBase64String:base64Str];
}

+ (NSString *)stringWithArray:(NSArray *)array
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString *base64Str = [NSString base64StringWithString:str];
    
    return [NSString stringWithBase64String:base64Str];
}

+ (NSString *)stringWithJsonString:(NSString *)json
{
    NSString * text = json;
    text = [[text componentsSeparatedByString:@"\n"] componentsJoinedByString:@""];
    
    NSMutableArray * t = [NSMutableArray array];
    char inString = false;
    for (NSInteger i = 0, len = text.length; i < len; i++) {
        char c = [text characterAtIndex:i];
        //因为中文问题,这里按位置读取字符串,如果是中文,直接拼上去 __Sz1
        NSString *cstr = [text substringWithRange:NSMakeRange(i, 1)];
        if ([NSString isChinese:cstr]) {
            
        }else{
            if (inString && c == inString) {
                // TODO: \\"
                if ([text characterAtIndex:i-1] != '\\') {
                    inString = false;
                }
            } else if (!inString && (c == '"' || c == '\'')) {
                inString = c;
            } else if (!inString && (c == ' ' || c == '\t')) {
                cstr = @"";
            }
        }
        [t addObject:cstr];
    }
    text = [t componentsJoinedByString:@""];
    
    return text;
}

+ (BOOL)isChinese:(NSString *)str
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
}

@end
