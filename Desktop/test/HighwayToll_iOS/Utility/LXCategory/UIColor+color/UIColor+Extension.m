//
//  UIColor+Extension.m
//  NetCulture
//
//  Created by MyMac on 15/10/13.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *)colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    NSScanner *scanner = [NSScanner scannerWithString:cString];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [UIColor colorWithRGBHex:hexNum];
}

+ (UIColor *)transformRGBColor:(NSString *)colorValue
{
    UIColor * color = nil;
    
    NSMutableString * value = [NSMutableString stringWithFormat:@"%@",colorValue];
    
    //转换成16进制
    [value replaceCharactersInRange:[value rangeOfString:@"#"] withString:@"0x" ];
    
    //将16进制转换成整形
    long longColor = strtoul([value cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    
    //通过位与方法获取三色值
    int R = (longColor & 0xFF0000)>>16;
    int G = (longColor & 0x00FF00)>>8;
    int B = (longColor & 0x0000FF);
    
    color = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
    
    return color;
}

+(UIColor *)transformRGBColorAlpha:(NSString *)colorValue alpha:(CGFloat)alpha
{
    UIColor * color = nil;
    
    NSMutableString * value = [NSMutableString stringWithFormat:@"%@",colorValue];
    
    //转换成16进制
    [value replaceCharactersInRange:[value rangeOfString:@"#"] withString:@"0x" ];
    
    //将16进制转换成整形
    long longColor = strtoul([value cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    
    //通过位与方法获取三色值
    int R = (longColor & 0xFF0000)>>16;
    int G = (longColor & 0x00FF00)>>8;
    int B = (longColor & 0x0000FF);
    
    color = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:alpha];
    
    return color;
}
@end
