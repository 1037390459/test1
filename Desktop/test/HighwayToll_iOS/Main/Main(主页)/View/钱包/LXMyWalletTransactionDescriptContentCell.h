//
//  LXMyWalletTransactionDescriptContentCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXMyWalletTransactionDescriptContentCell : UICollectionViewCell
@property (nonatomic,copy) NSString *titleStr;        /**< 标题 */
@property (nonatomic,copy) NSString *addTimeStr;      /**< 时间 */
@property (nonatomic,copy) NSString *moneyStr;        /**< 钱包 */
@property (nonatomic,assign) NSInteger index;         /**<  */
@end
