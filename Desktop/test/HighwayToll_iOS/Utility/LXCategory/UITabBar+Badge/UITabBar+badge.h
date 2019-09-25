//
//  UITabBar+badge.h
//  CarWins
//
//  Created by Dandre on 16/3/22.
//  Copyright © 2016年 CarWins Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)

/**
 *  显示小红点
 */
- (void)showBadgeOnItemIndex:(int)index;

/**
 *  隐藏小红点
 */
- (void)hideBadgeOnItemIndex:(int)index;

@end
