//
//  UICollectionView+LongGesture.m
//  CarWins
//
//  Created by Lone on 2016/11/17.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import "UICollectionView+LongGesture.h"

static char GestureDelegateKey;

@implementation UICollectionView (LongGesture)

- (void)setGesture_delegate:(id<UICollectionViewLongGestureDelegate>)gesture_delegate
{
    if (gesture_delegate) {
        objc_setAssociatedObject(self, &GestureDelegateKey, gesture_delegate, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (id<UICollectionViewLongGestureDelegate>)gesture_delegate
{
    return objc_getAssociatedObject(self, &GestureDelegateKey);
}

#pragma mark - 添加手势
- (void)addLongGesture{
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                   action:@selector(longPressGesture:)];
    gesture.minimumPressDuration = 0.25f;
    [self addGestureRecognizer:gesture];
}

#pragma mark - 开始拖拽
- (void)longPressGesture:(UILongPressGestureRecognizer *)gesture
{
    if ([LXDeviceManager currentVersion] < 9) {
        return;
    }
    NSIndexPath *selectedIndexPath = [self indexPathForItemAtPoint:[gesture locationInView:self]];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (selectedIndexPath == nil) {
                return;
            }
            [self beginMoveAtIndexpath:selectedIndexPath];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            @try {
                //更新位移
                [self updateInteractiveMovementTargetPosition:[gesture locationInView:gesture.view]];
            } @catch (NSException *exception) {
                [self endMoveAtIndexpath:selectedIndexPath];
            } @finally {
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            [self endMoveAtIndexpath:selectedIndexPath];
           
            break;
        }
        default:
        {
            [self cancelMoveAtIndexpath:selectedIndexPath];
            break;
        }
    }
}

#pragma mark - 开始移动
- (void)beginMoveAtIndexpath:(NSIndexPath *)indexpath
{
    if ([self.gesture_delegate respondsToSelector:@selector(collectionView:beginMoveAtIndexpath:)]) {
        if ([self.gesture_delegate collectionView:self beginMoveAtIndexpath:indexpath]) {
            [self beginInteractiveMovementForItemAtIndexPath:indexpath];
        }
    }
}

#pragma mark - 结束移动
- (void)endMoveAtIndexpath:(NSIndexPath *)indexpath
{
    if ([self.gesture_delegate respondsToSelector:@selector(collectionView:beginMoveAtIndexpath:)]) {
        [self.gesture_delegate collectionView:self endMoveAtIndexpath:indexpath];
    }
     [self endInteractiveMovement];
}

#pragma mark - 取消移动
- (void)cancelMoveAtIndexpath:(NSIndexPath *)indexpath
{
    if ([self.gesture_delegate respondsToSelector:@selector(collectionView:beginMoveAtIndexpath:)]) {
        [self.gesture_delegate collectionView:self endMoveAtIndexpath:indexpath];
    }
    [self cancelInteractiveMovement];
}

@end
