//
//  LXLeftMenuHeadCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LXLeftMenuHeadCellBlock)(void);
typedef void (^LXLeftMenuHeadPortraitCellBlock)(void);
@interface LXLeftMenuHeadCell : UICollectionViewCell
@property (nonatomic,copy) LXLeftMenuHeadCellBlock block; /**<  */
- (void)didSelectBack:(LXLeftMenuHeadCellBlock)block;
@property (nonatomic,copy) LXLeftMenuHeadPortraitCellBlock headPortraitblock; /**<  */
- (void)didSelectHeadPortrailBack:(LXLeftMenuHeadPortraitCellBlock)block;
@property (nonatomic,copy) NSString *userNameStr;                      /**< 用户名 */
@property (nonatomic,strong) NSString *moneyStr;                       /**< 金额 */
@property (nonatomic,strong) UIButton *headPortraitBtn;                /**< 头部按钮 */
@end
