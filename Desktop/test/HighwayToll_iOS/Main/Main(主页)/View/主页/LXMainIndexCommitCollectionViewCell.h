//
//  LXMainIndexCommitCollectionViewCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/4.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LXMainIndexCommitCollectionViewCellBlock)(NSInteger tag);
@interface LXMainIndexCommitCollectionViewCell : UICollectionViewCell
//------------------------------------------------
@property (nonatomic,copy) LXMainIndexCommitCollectionViewCellBlock block; /**<  */
- (void)didSelectCommitClick:(LXMainIndexCommitCollectionViewCellBlock)block;
@end
