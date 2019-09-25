//
//  NSString+Extension.m
//  DYStore
//
//  Created by MyMac on 15/9/25.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "NSString+Extension.h"

#import <sys/sysctl.h>

@implementation NSString (Extension)

/**
 *  计算文字的大小
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, 0.0);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font maxH:(CGFloat)maxH {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(MAXFLOAT, maxH);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    resultSize = [self boundingRectWithSize:size
                                    options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                 attributes:@{NSFontAttributeName: font}
                                    context:nil].size;
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height)));
    return resultSize;
}

- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize
{
    NSDictionary *arrts = @{NSFontAttributeName:font};
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:arrts context:nil].size;
}

/**
 *  计算文字大小
 */
- (CGSize)sizeWithFont:(UIFont *)font {
    return [self sizeWithFont:font maxW:MAXFLOAT];
}


/**
 *  判断密码是否符合要求(6-20位密码,不带特殊符号)
 *  @return 是返回YES 否则返回NO
 */
- (BOOL)validatePassword {
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}


/**
 *  设备型号
 */
+ (NSString *)deviceType
{
    NSString *platform = [self platform];
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6S";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (GSM)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air (CDMA)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (CDMA)";
    
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (CDMA)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (CDMA)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (CDMA)";
    
    if ([platform isEqualToString:@"i386"])         return [UIDevice currentDevice].model;
    if ([platform isEqualToString:@"x86_64"])       return [UIDevice currentDevice].model;
    
    return platform;
}

/**
 *  平台信息
 */
+ (NSString *)platform
{
    return [self getSysInfoByName:"hw.machine"];
}

+ (NSString *)getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    NSString *result = [NSString stringWithCString:answer
                                          encoding:NSUTF8StringEncoding];
    free(answer);
    return result;
}



/**
 *  转为documents下的子文件夹
 */
-(NSString *)documentsSubFolder{
    
    NSString *documentFolder=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    return [NSString makeSubFolderInSuperFolder:documentFolder subFloder:self];
    
}


/**
 *  文件夹处理
 */
+(NSString *)makeSubFolderInSuperFolder:(NSString *)superFolder subFloder:(NSString *)subFloder{
    
    NSString *folder=[NSString stringWithFormat:@"%@/%@",superFolder,subFloder];
    
    BOOL isDir = NO;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL existed = [fileManager fileExistsAtPath:folder isDirectory:&isDir];
    
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return folder;
}

@end

@implementation NSString (URL)

- (NSString *)URLEncodedString {
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

@end


@implementation NSString (AttributeStr)
/**
 *  @author yunFei, 16-03-20 13:03:51
 *
 *  修改字符串中的某一段字符串属性(只含文字颜色样式)
 *
 *  @param text             待修改的字符串
 *  @param pendingCharacter 要修改属性的字符串
 *  @param color            要修改属性的字符串的颜色
 *
 *  @return 返回修改完成后的字符串
 */
+ (NSMutableAttributedString *)getAttributeFromText:(NSString *)text pendingCharacter:(NSString *)pendingCharacter pendingColor:(UIColor *)color {
    
    NSMutableAttributedString *titleColorStr = [[NSMutableAttributedString alloc] initWithString:text];
    [titleColorStr addAttribute:NSForegroundColorAttributeName value:color range:[text rangeOfString:pendingCharacter]];
    return titleColorStr;
    
}

/**
 *  @author yunFei, 16-03-20 14:03:30
 *
 *  修改字符串中的某一段字符串属性(含文字和字体样式)
 *
 *  @param text             待修改的字符串
 *  @param pendingCharacter 要修改属性的字符串
 *  @param color            要修改属性的字符串的颜色
 *  @param font             要修改属性的字符串的字体
 *
 *  @return 返回修改完成后的字符串
 */
+ (NSMutableAttributedString *)getAttributeFromText:(NSString *)text pendingCharacter:(NSString *)pendingCharacter pendingColor:(UIColor *)color font:(UIFont *)font {
    NSMutableAttributedString *titleColorStr = [[NSMutableAttributedString alloc] initWithString:text];
    [titleColorStr addAttribute:NSForegroundColorAttributeName value:color range:[text rangeOfString:pendingCharacter]];
    [titleColorStr addAttribute:NSFontAttributeName value:font range:[text rangeOfString:pendingCharacter]];
    return titleColorStr;
}


/**
 *  @author yunFei, 16-03-20 13:03:39
 *
 *  批量修改字符串中的某几段字符串属性(只含文字颜色样式)
 *
 *  @param text              待修改的字符串
 *  @param pendingCharacters 要修改属性的字符串数组
 *  @param colors            要修改属性的字符串的颜色数组
 *
 *  @return 返回修改完成后的字符串
 */
+ (NSMutableAttributedString *)getAttributeFromText:(NSString *)text pendingCharacters:(NSArray *)pendingCharacters pendingColors:(NSArray *)colors {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
    for (int i = 0; i < pendingCharacters.count; i ++) {
        UIColor *textColor;
        if (!(colors.count == pendingCharacters.count)) {
            textColor = colors[0];
            [attr addAttribute:NSForegroundColorAttributeName value:textColor range:[text rangeOfString:pendingCharacters[i]]];
        }else {
            [attr addAttribute:NSForegroundColorAttributeName value:colors[i] range:[text rangeOfString:pendingCharacters[i]]];
        }
    }
    
    return attr;
}
+ (NSMutableAttributedString *)getAttributeFromTexts:(NSArray *)texts pendingCharacters:(NSArray *)pendingCharacters pendingColors:(NSArray *)colors
{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] init];
    if (texts.count!=pendingCharacters.count||texts.count!=colors.count) return nil;
    
    for (int i = 0; i < pendingCharacters.count; i ++) {
        
        [attr appendAttributedString: [NSString getAttributeFromText:texts[i] pendingCharacter:pendingCharacters[i] pendingColor:colors[i]]];
    }
    return attr;
}
/**
 *  @author yunFei, 16-03-20 14:03:08
 *
 *  批量修改字符串中的某几段字符串属性(含文字和字体样式)
 *
 *  @param text              待修改的字符串
 *  @param pendingCharacters 要修改属性的字符串数组
 *  @param colors            要修改属性的字符串的颜色数组
 *  @param fonts             要修改属性的字符串的字体数组
 *
 *  @return 返回修改完成后的字符串
 */
+ (NSMutableAttributedString *)getAttributeFromText:(NSString *)text pendingCharacters:(NSArray *)pendingCharacters pendingColors:(NSArray *)colors fonts:(NSArray *)fonts {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
    for (int i = 0; i < pendingCharacters.count; i ++) {
        UIColor *textColor;
        if (!(colors.count == pendingCharacters.count)) {
            textColor = colors[0];
            [attr addAttribute:NSForegroundColorAttributeName value:textColor range:[text rangeOfString:pendingCharacters[i]]];
        }else {
            [attr addAttribute:NSForegroundColorAttributeName value:colors[i] range:[text rangeOfString:pendingCharacters[i]]];
        }
        
        UIFont *font;
        if (!(fonts.count == pendingCharacters.count)) {
            font = fonts[0];
            [attr addAttribute:NSFontAttributeName value:font range:[text rangeOfString:pendingCharacters[i]]];
        }else {
            [attr addAttribute:NSFontAttributeName value:fonts[i] range:[text rangeOfString:pendingCharacters[i]]];
        }
    }
    
    return attr;
}
//给字符串加上中划线
+ (NSMutableAttributedString *)getAttributeFromTextIntoUnderline:(NSString *)text
{
    if (text==nil||[text isEqualToString:@""])return nil;
    
    NSDictionary *dic = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text attributes:dic];
    return attr;
}
//给字符串加上下划线
+ (NSMutableAttributedString *)getAttributeFromTextBottomUnderline:(NSString *)text  WithColor:(UIColor *)color
{
    if (text==nil||[text isEqualToString:@""])return nil;
    
    NSDictionary *dic = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:color};
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text attributes:dic];
    return attr;
}

+ (NSMutableAttributedString *)getAttributeToSetlineSpaceWithText:(NSString *)text WithLineSpace:(CGFloat)lineSpace
{
    if (text==nil||[text isEqualToString:@""])return nil;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    return attributedString;
}
@end

@implementation NSString (DateFormatter)
#pragma mark - 时间转换
+ (NSString *)stringWithDateAndTimeNumber:(long long)integer
{
    return [self stringWithDateNumber:integer formatter:@"yyyy-MM-dd HH:mm"];
    
}
+ (NSString *)stringWithDateAndTimeAndMinnueNumber:(long long)integer
{
    return [self stringWithDateNumber:integer formatter:@"yyyy-MM-dd HH:mm:ss"];
}
+ (NSString *)stringWithDateNumber:(long long)integer formatter:(NSString*)format
{
    if (integer <= 0) {
        return @"";
    }
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:integer];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //如果format传空 则设置默认format
    if (!format)format = @"yyyy-MM-dd HH:mm:ss";
    
    [dateFormatter setDateFormat:format];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}

@end

@implementation NSString (NSDictionary)

+ (NSDictionary *)stringWithJSONToNSDictionary:(NSString *)jsonString {
    
    NSData *JSONData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}

@end
