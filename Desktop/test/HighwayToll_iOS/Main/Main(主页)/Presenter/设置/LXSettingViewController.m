//
//  LXSettingViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXSettingViewController.h"
#import "LXSettingSelectCollectionViewCell.h"
#import "LXSettingtTextCollectionViewCell.h"
#import "LXSettingCleanCollectionViewCell.h"
#import "LXSettingCommitCollectionViewCell.h"
#import "LXSettingComplaintProposalViewController.h" /**<投诉建议*/
#import "LXAboutUSViewController.h"                  /**<关于我们*/
#import "NSFileManager+PathMethod.h"
#import "LXInterface+UserCenter.h"
@interface LXSettingViewController ()
@property (nonatomic,strong) NSMutableArray *dataArray;         /**< 数据源 */
@end
static NSString*const KLXSettingSelectCollectionViewCell_dis = @"LXSettingSelectCollectionViewCell_dis";
static NSString*const KLXSettingtTextCollectionViewCell_dis  = @"KLXSettingtTextCollectionViewCell_dis";
static NSString*const KLXSettingCleanCollectionViewCell_dis  = @"KLXSettingCleanCollectionViewCell_dis";
static NSString*const KLXSettingCommitCollectionViewCell_dis = @"KLXSettingCommitCollectionViewCell_dis";
@implementation LXSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}
- (void)configUI{
    CGFloat hight =  kNavHeight;
    self.title = @"设置";
    self.dataArray = [NSMutableArray arrayWithObjects:@"语音",@"投诉与建议",@"关于我们",@"清除缓存",@"", nil];
    [self configCollectionViewWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight - hight )
                              LineSpace:5
                                 vSpace:1
                       scrollDirecation:UICollectionViewScrollDirectionVertical
                              isRefresh:NO];
    [_collectionView registerClass:[LXSettingSelectCollectionViewCell class]
        forCellWithReuseIdentifier:KLXSettingSelectCollectionViewCell_dis];
    [_collectionView registerClass:[LXSettingtTextCollectionViewCell class]
        forCellWithReuseIdentifier:KLXSettingtTextCollectionViewCell_dis];
    [_collectionView registerClass:[LXSettingCleanCollectionViewCell class]
        forCellWithReuseIdentifier:KLXSettingCleanCollectionViewCell_dis];
    [_collectionView registerClass:[LXSettingCommitCollectionViewCell class]
        forCellWithReuseIdentifier:KLXSettingCommitCollectionViewCell_dis];
    [_collectionView setBackgroundColor:kRGBColor(245, 245, 245)];
}
#pragma mark collectionCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LXSettingSelectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXSettingSelectCollectionViewCell_dis forIndexPath:indexPath];
        cell.titleStr = self.dataArray[indexPath.section];
        [cell switchClick:^(BOOL flag) {
            NSString *status = flag?@"打开":@"关闭";
            [LXMessage showInfoMessage:status];
        }];
        return cell;
    }else if (indexPath.section == 3){
       LXSettingCleanCollectionViewCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXSettingCleanCollectionViewCell_dis forIndexPath:indexPath];
        cell.titleStr = self.dataArray[indexPath.section];
        cell.contentStr = [NSString stringWithFormat:@"%.2fM",(float)[NSFileManager getAllCacheDataSize]];
        return cell;
    }else if (indexPath.section == 4){
        LXSettingCommitCollectionViewCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXSettingCommitCollectionViewCell_dis forIndexPath:indexPath];
    LXWeakSelf(self);
        [cell didSelectClick:^{ 
            [[LXMessage shareMessage] show:@"是否确定退出？"
                                   okTitle:@"确定"
                                   Clicked:^(NSInteger buttonIndex) {
                                       if (buttonIndex == 1) {
                                           [LXMessage showActiveViewMessage:@"退出中..." onView:self.view];
                                           [LXNetManager postRequestWithParamDictionary:[LXInterface postUserCenterLogout]
                                                                               finished:^(id responseObj) {
                                                                                   [LXMessage hideActiveView];
                                                                                   if ([[responseObj objectForKey:@"state"] intValue] >= 0) {
                                                                                       [[LXUserInfoModel shareUser] removeAllUserInfo];
                                                                                       [weakself.navigationController popToRootViewControllerAnimated:NO];
                                                                                       [LXMessage showSuccessMessage:@"退出成功"];
                                                                                       [[AppDelegate shareInstance] enterRootViewController:NO];
                                                                                   }else{
                                                                                       [LXMessage showErrorMessage:@"失败"];
                                                                                   }
                                                                               }
                                                                                 failed:^(NSError *error) {
                                                                                     [LXMessage hideActiveView];
                                                                                     [LXMessage showErrorMessage:error.localizedDescription];
                                                                                 }];
                                       }
                                   }
                            ViewController:self];
        }];
        return cell;
    }else{
        LXSettingSelectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXSettingtTextCollectionViewCell_dis forIndexPath:indexPath];
        cell.titleStr = self.dataArray[indexPath.section];
        return cell;
    }
}
-  (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.dataArray.count-1)
    return CGSizeMake(kWidth, 85);
    return CGSizeMake(kWidth, kCellHeight);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0)
      return  UIEdgeInsetsMake(5, 0, 5, 0);
      return  UIEdgeInsetsMake(0, 0, 1, 0);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        LXSettingComplaintProposalViewController *VC = [LXSettingComplaintProposalViewController new];
        [self.navigationController pushViewController:VC animated:YES];
    }else if(indexPath.section == 2){
        LXAboutUSViewController *VC= [LXAboutUSViewController new];
        [self.navigationController pushViewController:VC animated:YES];
    }else if(indexPath.section == 3){
        
        [[LXMessage shareMessage] show:@"是否确定清除缓存记录?"
                               okTitle:@"确定"
                               Clicked:^(NSInteger buttonIndex) {
                                   if (buttonIndex == 1) {
                                       [NSFileManager clearAllCache];
                                       [LXMessage show:@"清理完成!"
                                                onView:self.view
                                            autoHidden:YES];
                                       [_collectionView reloadData];
                                   }
                               }
                        ViewController:self];
    }
}
@end
