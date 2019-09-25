//
//  LXSettingCommitCollectionViewCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LXSettingCommitCollectionViewCellBlock)(void);
@interface LXSettingCommitCollectionViewCell : UICollectionViewCell
@property (nonatomic,copy) LXSettingCommitCollectionViewCellBlock block;   /**< block */
- (void)didSelectClick:(LXSettingCommitCollectionViewCellBlock)block;
@end
