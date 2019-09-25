//
//  LXBorrowTheCarNewApplyForBorrowCarHaveBackCarViewCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/22.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LXBorrowTheCarNewApplyForBorrowCarHaveBackCarViewCellBlock)(void);
@interface LXBorrowTheCarNewApplyForBorrowCarHaveBackCarViewCell : UICollectionViewCell
@property (nonatomic,copy) LXBorrowTheCarNewApplyForBorrowCarHaveBackCarViewCellBlock block;      /**<  */
- (void)didSelect:(LXBorrowTheCarNewApplyForBorrowCarHaveBackCarViewCellBlock )block;
@end
