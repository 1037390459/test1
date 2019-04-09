//
//  Theme.m
//  智能锁
//
//  Created by million on 2019/4/6.
//  Copyright © 2019 million. All rights reserved.
//

#import "Theme.h"

@implementation Theme

+ (UIColor *)colorPrimary {
    return [UIColor colorWithHexString:@"#02A2F4"];
}
+ (UIColor *)colorPrimaryDark {
    return [UIColor colorWithHexString:@"#3D464E"];
}
+ (UIColor *)colorAccent {
    return [UIColor colorWithHexString:@"#3D464E"];
}
+ (UIColor *)colorPrimaryLight {
    return [UIColor colorWithHexString:@"#6A737D"];
}
+ (UIFont *)pc_fontWithSize:(NSInteger)size {
    return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
}

@end
