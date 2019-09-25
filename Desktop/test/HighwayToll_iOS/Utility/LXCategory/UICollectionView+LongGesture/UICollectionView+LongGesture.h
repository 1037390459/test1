//
//  UICollectionView+LongGesture.h
//  CarWins
//
//  Created by Lone on 2016/11/17.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UICollectionViewLongGestureDelegate <NSObject>


/**
 * 开始移动
 */
- (BOOL)collectionView:(UICollectionView *)collectionView beginMoveAtIndexpath:(NSIndexPath *)indexpath;

/**
 * 移动结束
 */
- (void)collectionView:(UICollectionView *)collectionView endMoveAtIndexpath:(NSIndexPath *)indexpath;

@end

@interface UICollectionView (LongGesture)

@property (nonatomic, weak) id<UICollectionViewLongGestureDelegate> gesture_delegate;


/**
 * 添加长按手势（item 可移动）
 */
- (void)addLongGesture;

@end
