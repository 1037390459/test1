//
//  Theme.h
//  智能锁
//
//  Created by million on 2019/4/6.
//  Copyright © 2019 million. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Theme : NSObject

+ (UIColor *)colorPrimary;
+ (UIColor *)colorPrimaryDark;
+ (UIColor *)colorAccent;
+ (UIColor *)colorPrimaryLight;
+ (UIFont *)pc_fontWithSize:(NSInteger)size;

@end

NS_ASSUME_NONNULL_END
