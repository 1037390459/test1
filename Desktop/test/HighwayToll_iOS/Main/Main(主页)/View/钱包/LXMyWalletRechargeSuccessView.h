//
//  LXMyWalletRechargeSuccessView.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LXMyWalletRechargeSuccessBlock)(bool flag);
@interface LXMyWalletRechargeSuccessView : UIView
@property (nonatomic,copy) NSString *moneyStr;  /**<  金额*/
@property (nonatomic,copy) LXMyWalletRechargeSuccessBlock block;    /**<  */
- (void)didSelectClick:(LXMyWalletRechargeSuccessBlock)block;
@end
