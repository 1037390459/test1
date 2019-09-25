//
//  LXMyWalletCollectionViewCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LXMyWalletCollectionViewBlock)(BOOL istransaction);
@interface LXMyWalletCollectionView : UIView
@property (nonatomic,copy) LXMyWalletCollectionViewBlock block;          /**< 代码块 */
- (void)didSelectBtnofIndex:(LXMyWalletCollectionViewBlock)block;
@property (nonatomic,copy) NSString *moneyStr;      /**< 金额 */
@end
