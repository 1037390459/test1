

#import <Foundation/Foundation.h>
@interface NSString (NSString_Hashing)

/** MD5 32 位加密 */
- (NSString *)MD5_32_Encode;
/** MD5 16 位加密 */
- (NSString *)MD5_16_Encode;
/** sha1散列加密 */
- (NSString *)sha1Encode;
/** 用于UBai修改密码 加密 */
- (NSString *)ubEncryption;
@end
