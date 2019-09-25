//
//  LXMainInUsedViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/20.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMainInUsedViewController.h"
#import "LXRoadAdministrationController.h"
#import "LXMyMessageViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "LXMainHaveEnteredHighWayView.h"
#import "LXUserCenterViewController.h"
#import "LXInterface+CarInfo.h"
#import "LXAddVehicleModel.h"
@interface LXMainInUsedViewController ()
@property (nonatomic,strong) LXMainHaveEnteredHighWayView *inUseView;       /**< 正在使用的view */
@property (nonatomic,strong) LXCarDetatilModel *carDetatilModel;            /**<  */
@end

@implementation LXMainInUsedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = true; 
    [self loadData];
    [self configUI];
    [self addInUserView];
}
- (void)configUI{ 
    LXNavItemModel *left = [[LXNavItemModel alloc] init];
    left.imageName = @"menu";
    left.isLeft = YES;
    LXNavItemModel *message = [[LXNavItemModel alloc] init];
    message.imageName = @"message";
    message.isLeft = NO;
    LXNavItemModel *gonglu = [[LXNavItemModel alloc] init];
    gonglu.imageName = @"gonglu";
    gonglu.isLeft = NO;
    LXWeakSelf(self)
    [self addBarButtonItemsWithArray:@[left,message,gonglu] selectorBlock:^(UIButton *item, NSInteger index) {
        switch (index) {
            case 0:
                [weakself show];
                break;
            case 1:
                [weakself messageClick];
                break;
            default:
                [weakself.navigationController pushViewController:[LXRoadAdministrationController new] animated:YES];
                break;
        }
    }];
    UIImageView *img =   [LXView createImageViewFrame:CGRectZero imageName:@"logo" isUIEnabled:YES];
    [self.view.layer setContents:(id _Nullable) [UIImage imageNamed:@"background"].CGImage];
    self.view.layer.backgroundColor = [UIColor clearColor].CGColor;
    self.navigationItem.titleView = img;
}
- (void)messageClick{
    LXMyMessageViewController *VC = [LXMyMessageViewController new];
    [self.navigationController pushViewController:VC animated:YES];
}
- (void)show{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
/**
 添加正在使用的View
 */
- (void)addInUserView{
    CGFloat kNavHeigh = kNavHeight;
    self.inUseView = [[LXMainHaveEnteredHighWayView alloc] initWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight-kNavHeigh)];
 
    LXWeakSelf(self);
    [self.inUseView didSelectCommitClick:^(NSInteger tag) {
        switch (tag) {
            case 0:
                [weakself.navigationController pushViewController:[LXUserCenterViewController new] animated:YES];
                break;
            case 1:{
                [weakself notUse];
            }
                break;
                
            default:
                [LXMessage showInfoMessage:@"右边按钮"];
                break;
        }
    }];
    [self.view addSubview:self.inUseView];
}
/**
 不想用了
 */
- (void)notUse{
    LXWeakSelf(self);
    [LXNetManager postWithParamDictionary:[LXInterface postTollFinishUseCarRecordId:kStringByInt(self.model.TollRecordId)]
                                 finished:^(id responseObj) {
                                     if (responseObj &&
                                         [responseObj objectForKey:@"data"] &&
                                         [[responseObj objectForKey:@"state"] intValue] >= 1) {
                                         [weakself.navigationController popViewControllerAnimated:YES];
                                     }else{
                                         [LXMessage showErrorMessage:[responseObj objectForKey:@"msg"]];
                                     }
                                 }
                                   failed:^(NSError *error) {
                                       [LXMessage showErrorMessage:error.localizedDescription];
                                   }];
}
- (void)loadData{
    LXWeakSelf(self);
    [LXNetManager getWithParamDictionary:[LXInterface postTollRecordGetId:kStringByInt(self.model.TollRecordId)]
                                finished:^(id responseObj) {
                                    if (responseObj &&
                                        [[responseObj objectForKey:@"state"] integerValue] >= 1) {
                                        weakself.model = [[LXMyJourneyModel alloc] initWithDictionary:[responseObj objectForKey:@"rows"][0]];
                                        if (![([responseObj objectForKey:@"rows"][0][@"MPCarId"]) isKindOfClass:[NSNull class]]) {
                                            weakself.model.CarNumber = [responseObj objectForKey:@"rows"][0][@"MPCarId"][@"CarNumber"];
                                        }
                                        weakself.inUseView.plateStr = self.model.CarNumber;
                                        if (weakself.model.TollStateId == 5 ||
                                            weakself.model.TollStateId == 6 ||
                                            weakself.model.TollStateId == 7) {
                                            weakself.inUseView.intoTheStationStr = @"行程结束";
                                        }else{
                                            weakself.inUseView.intoTheStationStr = kStringConvertNull(weakself.model.TollStateName);
                                        }
                                    } 
                                }
                                  failed:^(NSError *error) {
                                      [LXMessage showErrorMessage:error.localizedDescription];
                                  }];
}
@end
