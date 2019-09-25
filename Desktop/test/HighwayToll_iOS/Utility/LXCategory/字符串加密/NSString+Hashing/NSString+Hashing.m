

#import "NSString+Hashing.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (NSString_Hashing)

//MD5加密
- (NSString *)MD5_32_Encode
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

// MD5 16位加密
- (NSString *)MD5_16_Encode
{
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[self MD5_32_Encode];
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    
    return result;
}

//Sha1加密
- (NSString*)sha1Encode
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output.uppercaseString;
}

//用于UBai修改密码 加密
- (NSString *)ubEncryption
{
    NSMutableString * newStr = [NSMutableString stringWithString:self];
    NSString * a = @"abcdefghijklmnopqrstuvwxyz0123456789";
    NSString * b = @"~!@#$%^&*()_+,./<>?;:\"[]{}abcdefghij";
    for(NSInteger i = 0; i < a.length; i++)
    {
        char m = [a characterAtIndex:i];
        char n = [b characterAtIndex:i];
        NSRange j = [newStr rangeOfString:[NSString stringWithFormat:@"%c",m]];
        while (j.location != NSNotFound)
        {
            [newStr replaceCharactersInRange:j withString:[NSString stringWithFormat:@"%c",n]];
            j = [newStr rangeOfString:[NSString stringWithFormat:@"%c",m]];
        }
    }
    
    return newStr;
}

@end
