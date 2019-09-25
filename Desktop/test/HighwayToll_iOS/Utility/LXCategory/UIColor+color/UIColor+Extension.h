//
//  UIColor+Extension.h
//  NetCulture
//
//  Created by MyMac on 15/10/13.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)
/**
 *  rgbHex字符转换UIColor
 *
 */
+ (UIColor *)colorWithRGBHex:(UInt32)hex;
/**
 *  Hex字符转换UIColor
 *
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (UIColor *)transformRGBColor:(NSString *)colorValue;

+ (UIColor *)transformRGBColorAlpha:(NSString *)colorValue alpha:(CGFloat) alpha;
@end
