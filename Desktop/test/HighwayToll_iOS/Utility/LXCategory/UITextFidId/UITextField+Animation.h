//
//  UITextField+Animation.h
//  PeacockShop
//
//  Created by Cheng on 17/10/27.
//  Copyright © 2017年 LX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Animation)
typedef void (^Completion)(void);
@property (nonatomic, copy) Completion completionBlock;

/**
 抖动的方法

 @param completion 抖动完成之后
 */
- (void)shakeWithCompletion:(void (^)(void))completion;
@end
