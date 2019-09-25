//
//  LXSettingSelectCollectionViewCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LXSettingSelectCollectionViewCellBlock)(BOOL flag);
@interface LXSettingSelectCollectionViewCell : UICollectionViewCell
@property (nonatomic,copy) NSString *titleStr;          /**< 名称 */
@property (nonatomic,copy) LXSettingSelectCollectionViewCellBlock block; /**< */
- (void)switchClick:(LXSettingSelectCollectionViewCellBlock)block;
@end
