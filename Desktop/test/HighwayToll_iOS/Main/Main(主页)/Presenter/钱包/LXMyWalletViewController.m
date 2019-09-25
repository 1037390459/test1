//
//  LXMyWalletViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyWalletViewController.h"
#import "LXMyWalletCollectionView.h"
#import "LXMyWalletTransactionDescriptViewController.h" //*<交易明细*/
#import "LXMyWalletRechargeViewController.h"            //*<充值*/
@interface LXMyWalletViewController ()
@property (nonatomic,strong) LXMyWalletCollectionView *contentView; /**<  */
@end

@implementation LXMyWalletViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configUI];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
   配置UI
 */
- (void)configUI{
    self.title = @"钱包";
    CGFloat height = kNavHeight;
    LXMyWalletCollectionView *view = [[LXMyWalletCollectionView alloc] initWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight - height)];
    LXWeakSelf(self);
    view.moneyStr = [NSString stringWithFormat:@"%.2f",[LXUserInfoModel shareUser].Balance];
    [view didSelectBtnofIndex:^(BOOL istransaction) {
        if (istransaction) {
            LXMyWalletRechargeViewController *VC = [LXMyWalletRechargeViewController new];
            [weakself.navigationController pushViewController:VC animated:YES];
        }else{
            LXMyWalletTransactionDescriptViewController *VC = [[LXMyWalletTransactionDescriptViewController alloc] init];
            [weakself.navigationController pushViewController:VC animated:YES];
        }
    }];
    [self.view addSubview:view];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backBtnClick{
    if (self.isHome) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [super backBtnClick];
    }
}
- (void)dealloc{
    DLog(@"我是钱包");
}
@end
