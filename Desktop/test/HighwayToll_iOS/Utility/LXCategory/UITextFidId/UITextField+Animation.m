//
//  UITextField+Animation.m
//  PeacockShop
//
//  Created by Cheng on 17/10/27.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "UITextField+Animation.h"


@implementation UITextField (Animation)


static char const *strAddrKey = "strAddrKey";

- (Completion)completionBlock {
    return objc_getAssociatedObject(self, strAddrKey);
}

- (void)setCompletionBlock:(Completion)completionBlock {
    objc_setAssociatedObject(self, strAddrKey, completionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (void)shakeWithCompletion:(void (^)())completion {
    self.completionBlock = completion;
    [self _shake:10 direction:1 currentTimes:0 withDelta:5 andSpeed:0.03];
}


/**
 *  抖动动画
 *
 *  @param times     晃动的次数
 *  @param direction 标记:形变是往左还是往右
 *  @param current   已经晃动的次数
 *  @param delta     形变水平距离
 *  @param interval  每次晃动的时间
 */
- (void)_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval {
    
    [UIView animateWithDuration:interval animations:^{
        self.transform = CGAffineTransformMakeTranslation(delta * direction, 0);
    } completion:^(BOOL finished) {
        if(current >= times) {
            self.transform = CGAffineTransformIdentity;
            if (self.completionBlock) {
                self.completionBlock();
            }
            
        }else {
            
            [self _shake:(times - 1)
               direction:direction * -1
            currentTimes:current + 1
               withDelta:delta
                andSpeed:interval];
        }
    }];
}


@end
