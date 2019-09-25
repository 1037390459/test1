//
//  LXMyWalletTransactionDescriptSelectViewCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LXMyWalletTransactionDescriptSelectViewCellBlock)(NSInteger index);
@interface LXMyWalletTransactionDescriptSelectViewCell : UICollectionViewCell
@property (nonatomic,copy) LXMyWalletTransactionDescriptSelectViewCellBlock block; /**<  */
- (void)didSelectClick:(LXMyWalletTransactionDescriptSelectViewCellBlock)block;
@end
