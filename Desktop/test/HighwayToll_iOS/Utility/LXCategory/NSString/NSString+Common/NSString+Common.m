//
//  NSString+Common.m
//  CarWins
//
//  Created by Lone on 2016/12/7.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

#pragma mark - 1.字符串反转
- (NSString *)reverseWords
{
    NSMutableString *newString = [[NSMutableString alloc] initWithCapacity:self.length];
//    for (NSInteger i = self.length - 1; i >= 0 ; i --)
//    {        unichar ch = [self characterAtIndex:i];
//        [newString appendFormat:@"%c", ch];
//    }
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                             options:NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              [newString appendString:substring];
                          }];
    return newString;
}

#pragma mark - 2.字符串分割（多字符）
- (NSArray *)componentsSeparatedWithCharsString:(NSString *)chars
{
    // Create @"iOS Developer Tips encoded in Base64"
//    NSData *nsdata = [self dataUsingEncoding:NSUTF8StringEncoding];// Get NSString from NSData object in Base64
//    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];// Print the Base64 encoded string
//    NSLog(@"Encoded: %@", base64Encoded);
//    // Let's go the other way...// NSData from the Base64 encoded str
//    NSData *nsdataFromBase64String = [[NSData alloc] initWithBase64EncodedString:base64Encoded options:0];// Decoded NSString from the NSData
//    NSString *base64Decoded = [[NSString alloc] initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
//    NSLog(@"Decoded: %@", base64Decoded);
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:chars];
    return [self componentsSeparatedByCharactersInSet:set];
}

#pragma mark - 3.汉字转拼音
- (NSString *)transformPinYin
{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [self mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    NSLog(@"%@", pinyin);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    //返回最近结果
    return pinyin;
}

#pragma mark - 计算字符串字符长度，一个汉字算两个字符
- (NSInteger)unicodeLength
{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++)
    {
        unichar uc = [self characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

#pragma mark - URL 编码
- (NSString *)urlEncode
{
    return  [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

#pragma mark -url 解码
- (NSString *)urlUnEncode
{
    return [self stringByRemovingPercentEncoding];
}
/**
 *  计算一段文字size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);

    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;

}
/**
 *  计算一行文字size
 */
- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

//验证车牌号
- (BOOL)isCarNo
{
    NSString * carNoRegex = @"^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$";
    NSPredicate * carNoTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", carNoRegex];
    return [carNoTest evaluateWithObject:self];
}
-(BOOL)isTel{
    NSString *telRegex = @"^[1][3-8]\\d{9}$";
    NSPredicate *telTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [telTest evaluateWithObject:self];
}

-(BOOL)isEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

-(BOOL)isDeviceCode{
    //    NSString *emailRegex = @"^[\\d]{12,21}$";
    NSString *emailRegex = @"^[0-9]{4}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

-(BOOL)isDevice{
    NSString *emailRegex = @"^[0-9]{15}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isNotNil
{
    if (self == nil || (id)self == [NSNull null] || [self isEqualToString:@""])
        return NO;
    return YES;
}

-(BOOL)isCode{
    NSString *codeRegex = @"\\d{4,6}";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", codeRegex];
    return [codeTest evaluateWithObject:self];
}

-(BOOL)isPWD{
    NSString *emailRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,13}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

-(BOOL)isIDCard{
    NSString *idCardRegex = @"(^\\d{15}$)|(^\\d{17}([0-9]|X)$)";
    NSPredicate *idCardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", idCardRegex];
    return [idCardTest evaluateWithObject:self];
}

-(BOOL)isNumOrsASC{
    NSString *numOrBigASC = @"\\w+";
    NSPredicate *numOrBigASCTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numOrBigASC];
    return [numOrBigASCTest evaluateWithObject:self];
}


+(NSString *) compareCurrentTime:(NSTimeInterval) compareDate
{
    NSDate *confromTimesp        = [NSDate dateWithTimeIntervalSince1970:compareDate/1000];
    
    NSTimeInterval  timeInterval = [confromTimesp timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    
    NSCalendar *calendar     = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags      = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents*referenceComponents=[calendar components:unitFlags fromDate:confromTimesp];
    //    NSInteger referenceYear  =referenceComponents.year;
    //    NSInteger referenceMonth =referenceComponents.month;
    //    NSInteger referenceDay   =referenceComponents.day;
    NSInteger referenceHour  =referenceComponents.hour;
    //    NSInteger referemceMinute=referenceComponents.minute;
    
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp= timeInterval/60) < 60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = timeInterval/3600) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if ((temp = timeInterval/3600/24)==1)
    {
        result = [NSString stringWithFormat:@"昨天%ld时",(long)referenceHour];
    }
    else if ((temp = timeInterval/3600/24)==2)
    {
        result = [NSString stringWithFormat:@"前天%ld时",(long)referenceHour];
    }
    
    else if((temp = timeInterval/3600/24) <31){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = timeInterval/3600/24/30) <12){
        result = [NSString stringWithFormat:@"%ld个月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}
+ (NSString*) getDateStringWithTimestamp:(NSTimeInterval)timestamp
{
    NSDate *confromTimesp    = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    NSCalendar *calendar     = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags      = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents*referenceComponents=[calendar components:unitFlags fromDate:confromTimesp];
    NSInteger referenceYear  =referenceComponents.year;
    NSInteger referenceMonth =referenceComponents.month;
    NSInteger referenceDay   =referenceComponents.day;
    
    return [NSString stringWithFormat:@"%ld年%ld月%ld日",referenceYear,(long)referenceMonth,(long)referenceDay];
}



+ (NSString*) getStringWithTimestamp:(NSTimeInterval)timestamp formatter:(NSString*)formatter
{
    if ([NSString stringWithFormat:@"%@", @(timestamp)].length == 13) {
        timestamp /= 1000.0f;
    }
    NSDate*timestampDate=[NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *strDate = [dateFormatter stringFromDate:timestampDate];
    
    return strDate;
}
@end
