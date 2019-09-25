//
//  LXMyWalletRechargeSuccessViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyWalletRechargeSuccessViewController.h"
#import "LXMyWalletRechargeSuccessView.h"
#import "LXMyWalletViewController.h" /**<充值*/
@interface LXMyWalletRechargeSuccessViewController ()
@property (nonatomic,strong) LXMyWalletRechargeSuccessView *contentView; /**<  */
@end

@implementation LXMyWalletRechargeSuccessViewController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}
- (void)configUI{
    self.title = @"充值";
    CGFloat height = kNavHeight;
    self.contentView = [[LXMyWalletRechargeSuccessView alloc] initWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight - height)];
    [self.contentView didSelectClick:^(bool flag) {
        if (flag) {
            if (self.isHome) {
                LXMyWalletViewController *VC = [LXMyWalletViewController new];
                VC.isHome = YES;
                [self.navigationController pushViewController:VC animated:YES];
            }else{
                UIViewController *viewCtl = self.navigationController.viewControllers[1];
                [self.navigationController popToViewController:viewCtl animated:YES];
            }
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    self.contentView.moneyStr = self.moneyStr;
    [self.view addSubview:self.contentView];
}
@end
