//
//  UITableView+CellLine.h
//  Daiyanxiu
//
//  Created by MyMac on 16/4/9.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (CellLine)
//
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace withLineColor:(NSString *)color;

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpaceAndSectionLine:(CGFloat)leftSpace withLineColor:(NSString *)color;

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace withLineColor:(NSString *)color hasSectionLine:(BOOL)hasSectionLine;

@end
