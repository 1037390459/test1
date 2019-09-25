//
//  LXLendACarToAfriendCommitCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/27.
//  Copyright © 2017年 zheng. All rights reserved.
//  确认借出

#import <UIKit/UIKit.h>
typedef void (^LXLendACarToAfriendCommitCellBlock)(void);
@interface LXLendACarToAfriendCommitCell : UICollectionViewCell
@property (nonatomic,strong) NSString *descrioptStr;                        /**< 描述*/
@property (nonatomic,copy) LXLendACarToAfriendCommitCellBlock block ;       /**<  */
- (void)didSelectClick:(LXLendACarToAfriendCommitCellBlock )block;
@end
