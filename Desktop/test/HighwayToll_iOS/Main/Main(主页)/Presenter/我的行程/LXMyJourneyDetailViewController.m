//
//  LXMyJourneyDetailViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/4.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyJourneyDetailViewController.h"
#import "LXMyJourneyDetailView.h"
@interface LXMyJourneyDetailViewController ()
@property (nonatomic,strong) LXMyJourneyDetailView *VC; /**<  */
@end

@implementation LXMyJourneyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}

/**
   配置UI
 */
- (void)configUI{
    self.title = @"行程明细";
    CGFloat NavHeight = kNavHeight;
    self.VC = [[LXMyJourneyDetailView alloc] initWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight-NavHeight)];
    [self.VC didSelectCommitClick:^{
        [LXMessage showInfoMessage:@"点击我了"];
    }];
    self.VC.intoTheStationStr = kStringConvertNull(self.model.EntranceTime);
    self.VC.tollGateStr       = kStringConvertNull(self.model.ExitTime);
    self.VC.carNumber         = kStringConvertNull(self.model.CarNumber);
    self.VC.costNumber        = [NSString stringWithFormat:@"%.2f",self.model.CostAmount];
    if (self.model.TollStateId == 5 ||
        self.model.TollStateId == 6 ||
        self.model.TollStateId == 7) {
        self.VC.titleStr = @"行程结束";
    }else{
        self.VC.titleStr = kStringConvertNull(self.model.TollStateName);
    }
    NSString *time   = [LXCommon dateTimeDifferenceWithStartTime:_model.EntranceTime endTime:_model.ExitTime];
    self.VC.time = time;
    [self.view addSubview:self.VC];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadData{
    LXWeakSelf(self);
    [LXNetManager getWithParamDictionary:[LXInterface postTollRecordGetId:kStringByInt(self.model.TollRecordId)]
                                 finished:^(id responseObj) {
                                     if (responseObj &&
                                         [[responseObj objectForKey:@"state"] integerValue] >= 1) {
                                         self.model = [[LXMyJourneyModel alloc] initWithDictionary:[responseObj objectForKey:@"rows"][0]];
                                         if (![([responseObj objectForKey:@"rows"][0][@"MPCarId"]) isKindOfClass:[NSNull class]]) {
                                             self.model.CarNumber = [responseObj objectForKey:@"rows"][0][@"MPCarId"][@"CarNumber"];
                                             NSDictionary *dic = [responseObj objectForKey:@"rows"][0];
                                             if (![[dic objectForKey:@"MPTollStateId"] isKindOfClass:[NSNull class]]) {
                                                 self.model.TollStateName = dic[@"MPTollStateId"][@"TollStateName"];
                                             } 
                                         }
                                     }
                                     [weakself configUI];
                                 }
                                   failed:^(NSError *error) {
                                       [LXMessage showErrorMessage:error.localizedDescription];
                                   }];
}
@end
