//
//  LXMyWalletRechargeViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyWalletRechargeViewController.h"
#import "LXMyWalletRechargeView.h"                                //**<充值*/
#import "LXMyWalletRechargeSuccessViewController.h"               //**<充值*/
#import <AlipaySDK/AlipaySDK.h>
@interface LXMyWalletRechargeViewController ()
@property (nonatomic,strong) LXMyWalletRechargeView  *contentView; /**<  */
@end

@implementation LXMyWalletRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}
- (void)configUI{
    self.title = @"充值";
    CGFloat height = kNavHeight;
    self.contentView = [[LXMyWalletRechargeView alloc] initWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight - height)];
    LXWeakSelf(self);
    [self.contentView didSelectClick:^(NSString *contentStr) {
        [weakself loadData:contentStr];
    }];
    [self.view addSubview:self.contentView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadData:(NSString *)cost{
    [LXNetManager postRequestWithParamDictionary:[LXInterface postDriverCostLogRecharge:cost
                                           ]
                                    finished:^(id responseObj) {
        
                                        if (responseObj && [[responseObj objectForKey:@"state"] integerValue]>0) { 
                                            LXWeakSelf(self);
                                           
                                            [weakself loadDataMoney:cost];
                                        }
                                   }
                                   failed:^(NSError *error) {
                                        [LXMessage showSuccessMessage:error.localizedDescription];
                                   }];
}

/**
   加载金额
 */
- (void)loadDataMoney:(NSString *)cost{
    [[LXNetManager shareManager] getRequestWithUrlString:[[LXInterface postDriverInfoGetBaseInfo] objectForKey:@"url"]
                                                finished:^(id responseObj) {
                                                    if (responseObj && [responseObj objectForKey:@"data"]) {
                                                         LXWeakSelf(self);
                                                        KUserDefault_Set([[responseObj objectForKey:@"data"] objectForKey:@"Cars"], @"Cars");
                                                        KUserDefault_Set([[responseObj objectForKey:@"data"] objectForKey:@"Balance"], @"Balance");
                                                        [LXMessage showSuccessMessage:@"成功"];
                                                                                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                                                                LXMyWalletRechargeSuccessViewController *VC  = [LXMyWalletRechargeSuccessViewController new];
                                                                                                        VC.isHome = weakself.isHome;                        VC.moneyStr = cost;
                                                                                                                [weakself.navigationController pushViewController:VC animated:YES];
                                                                                                    });
                                                    }
                                                }
                                                  failed:^(NSError *error) {
                                                      
                                                  }];;
     
}
@end
