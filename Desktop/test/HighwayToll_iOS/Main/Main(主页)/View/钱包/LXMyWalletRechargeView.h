//
//  LXMyWalletRechargeView.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//  充值

#import <UIKit/UIKit.h>
typedef void (^LXMyWalletRechargeViewBlock)(NSString * contentStr);
@interface LXMyWalletRechargeView : UIView
@property (nonatomic,copy)  LXMyWalletRechargeViewBlock block;    /**<  */
- (void)didSelectClick:(LXMyWalletRechargeViewBlock)block;
@end
