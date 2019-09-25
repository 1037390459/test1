//
//  LXMainIndexRechargeMoneyCollectionViewCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/4.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LXMainIndexRechargeMoneyCollectionViewCellBlock)(void);
@interface LXMainIndexRechargeMoneyCollectionViewCell : UICollectionViewCell
//------------------------------------------------
@property (nonatomic,copy) LXMainIndexRechargeMoneyCollectionViewCellBlock block; /**<  */
- (void)didSelectCommitClick:(LXMainIndexRechargeMoneyCollectionViewCellBlock)block;
@property (nonatomic,copy) NSString *moneyStr;       /**<  */
@end
