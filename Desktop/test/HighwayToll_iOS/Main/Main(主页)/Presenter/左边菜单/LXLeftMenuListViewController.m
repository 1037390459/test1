//
//  LXLeftMenuListViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXLeftMenuListViewController.h"
#import "LXLeftMenuHeadCell.h"
#import "LXLeftMenuBodyCell.h"
#import "UIViewController+MMDrawerController.h"
#import "LXSettingViewController.h" //设置
#import "LXMyWalletViewController.h"//钱包
#import "LXMyVehicleListViewController.h" /**<车辆*/
#import "LXUserCenterViewController.h"    /**<个人中心*/
#import "LXMyJourneyViewController.h"     /**<行程*/
#import "LXNewBLEManageViewController.h"
@interface LXLeftMenuListViewController ()
@property (nonatomic,strong) NSMutableArray *titleArray;            /**< 标签 */
@property (nonatomic,strong) NSMutableArray *iconArray;             /**< 标签 */
@end
static NSString*const KLXLeftMenuHeadCell_dis = @"KLXLeftMenuHeadCell_dis";
static NSString*const KLXLeftMenuBodyCell_dis = @"LXLeftMenuBodyCell_dis";
@implementation LXLeftMenuListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}
- (void)configUI{
     self.fd_prefersNavigationBarHidden = YES;
     self.view.backgroundColor = [UIColor redColor];
     self.titleArray = [NSMutableArray arrayWithObjects:@"行程",@"车辆",@"钱包",@"客服",@"设置", nil];
     self.iconArray = [NSMutableArray arrayWithObjects:@"record",@"car",@"moneyNew",@"CustomerService",@"setting", nil];
    CGFloat height = IPHONE_X?40:20;
    [self configCollectionViewWithFrame:CGRectMake(0,-height, kWidth, kHeight +height)
                              LineSpace:5
                                 vSpace:1
                       scrollDirecation:UICollectionViewScrollDirectionVertical
                              isRefresh:NO];
    [_collectionView registerClass:[LXLeftMenuHeadCell  class]
        forCellWithReuseIdentifier:KLXLeftMenuHeadCell_dis];
    [_collectionView registerClass:[LXLeftMenuBodyCell  class]
        forCellWithReuseIdentifier:KLXLeftMenuBodyCell_dis];
}
#pragma mark collectionCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.item == 0){
        LXLeftMenuHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXLeftMenuHeadCell_dis forIndexPath:indexPath];
        LXWeakSelf(self)
        CGFloat log = [LXUserInfoModel shareUser].Balance;
        cell.moneyStr = [NSString stringWithFormat:@"%.2f",log];
        cell.userNameStr = [LXUserInfoModel shareUser].LoginName;
        [cell.headPortraitBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KimageUrl,KUserDefault_Get(@"AvatorImage")]] forState:0];
        [cell didSelectBack:^{
            [weakself.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
                //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
                [weakself.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
            }];
        }];
        [cell didSelectHeadPortrailBack:^{
            UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
            [nav pushViewController:[LXUserCenterViewController new] animated:NO];
            [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
                [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
            }];
        }];
        return cell;
    }else{
        LXLeftMenuBodyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXLeftMenuBodyCell_dis forIndexPath:indexPath];
        cell.imageNameStr = self.iconArray[indexPath.item-1];
        cell.titleStr     = self.titleArray[indexPath.item-1];
        return cell;
    }
}
-  (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.item == 0) return CGSizeMake(kWidth, kHeight *0.555);
    return CGSizeMake(kWidth, 44);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return  UIEdgeInsetsZero;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item != 0 &&
        [self.titleArray[indexPath.item-1] isEqualToString:@"设置"]) {
        //拿到我们的LitterLCenterViewController，让它去push
        LXSettingViewController *VC = [LXSettingViewController new];
        UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
        [nav pushViewController:VC animated:NO];
        //当我们push成功之后，关闭我们的抽屉
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];
    }else if (indexPath.item != 0 &&
              [self.titleArray[indexPath.item-1] isEqualToString:@"钱包"]) {
        UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
        [nav pushViewController:[LXMyWalletViewController new] animated:NO]; 
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];
    }else if (indexPath.item != 0 &&
              [self.titleArray[indexPath.item-1] isEqualToString:@"车辆"]) {
        UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
        [nav pushViewController:[LXMyVehicleListViewController new] animated:NO];
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];
    }else if (indexPath.item != 0 &&
              [self.titleArray[indexPath.item-1] isEqualToString:@"行程"]) {
        UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
        [nav pushViewController:[LXMyJourneyViewController new] animated:NO];
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];
    }else if (indexPath.item != 0 &&
              [self.titleArray[indexPath.item-1] isEqualToString:@"客服"]) {
        UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
        [nav pushViewController:[LXNewBLEManageViewController new] animated:NO];
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_collectionView reloadData];
}
@end
