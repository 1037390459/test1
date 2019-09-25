//
//  LXBorrowTheCarNewApplyForBorrowCarMessageDetatilViewCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/5.
//  Copyright © 2017年 zheng. All rights reserved.
//  新的借车申请

#import <UIKit/UIKit.h>
typedef void (^LXBorrowTheCarNewApplyForBorrowCarMessageDetatilViewCellBlock)(BOOL isAgree);
@interface LXBorrowTheCarNewApplyForBorrowCarMessageDetatilViewCell : UICollectionViewCell
@property (nonatomic,copy) LXBorrowTheCarNewApplyForBorrowCarMessageDetatilViewCellBlock block;   /**<  */
- (void)didSelect:(LXBorrowTheCarNewApplyForBorrowCarMessageDetatilViewCellBlock)block;
@end
