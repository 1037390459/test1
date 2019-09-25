//
//  LXMyJourneyViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/4.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyJourneyViewController.h"
#import "LXMyJourneyDrivingViewCell.h"
#import "LXMyJourneyFinishViewCell.h"
#import "LXMyJourneyDetailViewController.h"
#import "LXMyJourneyDrivingNotUseViewCell.h"
#import "LXMainInUsedViewController.h"
#import "LXMyJourneyModel.h"            //
@interface LXMyJourneyViewController ()
@property (nonatomic,strong) LXMyJourneyListModel *model;       /**<  */
@property (nonatomic,assign) NSInteger index;                   /**< */
@end
static NSString*const KLXMyJourneyDrivingViewCell_dis       = @"LXMyJourneyDrivingViewCell_dis";
static NSString*const KLXMyJourneyFinishViewCell_dis        = @"KLXMyJourneyFinishViewCell_dis";
static NSString*const KLXMyJourneyDrivingNotUseViewCell_dis = @"KLXMyJourneyDrivingNotUseViewCell_dis";
@implementation LXMyJourneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _index = 1;
    [self loadData];
    [self configUI];
}
- (void)configUI{
    self.title = @"我的行程";
    CGFloat hight =  kNavHeight;
    [self configCollectionViewWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight - hight )
                              LineSpace:5
                                 vSpace:1
                       scrollDirecation:UICollectionViewScrollDirectionVertical
                              isRefresh:NO];
    [_collectionView registerClass:[LXMyJourneyDrivingViewCell class]
        forCellWithReuseIdentifier:KLXMyJourneyDrivingViewCell_dis];
    [_collectionView registerClass:[LXMyJourneyFinishViewCell class]
        forCellWithReuseIdentifier:KLXMyJourneyFinishViewCell_dis];
    [_collectionView registerClass:[LXMyJourneyDrivingNotUseViewCell class]
        forCellWithReuseIdentifier:KLXMyJourneyDrivingNotUseViewCell_dis];
    LXWeakSelf(self);
    _collectionView.mj_footer  = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakself.index++;
        [weakself loadData];
    }];
    _collectionView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.index = 1;
        [weakself loadData];
    }];
}
#pragma mark collectionCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LXMyJourneyModel *model = [_model.dataArray objectAtIndex:indexPath.item];
    if (model.TollStateId == 1 ||
        model.TollStateId == 2 ||
        model.TollStateId == 3 ||
        model.TollStateId == 4 ) {
         if (model.TollStateId == 1) {
            LXMyJourneyDrivingNotUseViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXMyJourneyDrivingNotUseViewCell_dis forIndexPath:indexPath];
             cell.plateNumber = model.CarNumber;
             LXWeakSelf(self);
             [cell didSelectClick:^{
                 LXMainInUsedViewController *VC = [LXMainInUsedViewController new];
                 VC.model = [LXMyJourneyModel new];
                 VC.model.TollRecordId = model.TollRecordId;
                 VC.carId    = model.CarId;
                 [weakself.navigationController pushViewController:VC animated:YES];
             }];
             return cell;
         }else{
            LXMyJourneyDrivingViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXMyJourneyDrivingViewCell_dis forIndexPath:indexPath];
             cell.plateNumber = model.CarNumber;
             cell.enterTime   = model.EntranceTime;
             return cell;
        }
    }else{
        LXMyJourneyFinishViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXMyJourneyFinishViewCell_dis forIndexPath:indexPath];
        cell.plateNumber = model.CarNumber;
        cell.enterTime   = model.EntranceTime;
        cell.exitTime    = model.ExitTime;
        cell.costNumber  = [NSString stringWithFormat:@"%.2f",model.CostAmount];
        NSString *time   = [LXCommon dateTimeDifferenceWithStartTime:model.EntranceTime endTime:model.ExitTime];
        if (time.integerValue > 1000) {
            time = @"0.00";
        }
        cell.whenLong    = time;
        return cell;
    }
}
-  (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    LXMyJourneyModel *model = [_model.dataArray objectAtIndex:indexPath.item];
    if (model.TollStateId == 1 ||
        model.TollStateId == 2 ||
        model.TollStateId == 3 ||
        model.TollStateId == 4 ) {
        return CGSizeMake(kWidth, kCellHeight);
    }else{
        return CGSizeMake(kWidth, 117);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return  UIEdgeInsetsMake(5, 0, 0, 0);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _model.dataArray.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LXMyJourneyDetailViewController *VC = [LXMyJourneyDetailViewController new];
    LXMyJourneyModel *m= [_model.dataArray objectAtIndex:indexPath.item];
    VC.model = m;
    [self.navigationController pushViewController:VC animated:YES];
}

/**
    加载数据
 */
- (void)loadData{
    LXWeakSelf(self);
    [LXMessage showActiveViewOnView:self.view];
    [LXNetManager postRequestWithParamDictionary:[LXInterface postTollRecordListWithPageSize:@"20"
                                                                                   PageIndex:kStringByInt(_index)]
                                        finished:^(id responseObj) {
                                            [_collectionView.mj_header endRefreshing];
                                            [_collectionView.mj_footer endRefreshing];
                                            [LXMessage hideActiveView];
                                            if (responseObj && [responseObj objectForKey:@"rows"]) {
                                                if (!weakself.model) {
                                                    weakself.model = [[LXMyJourneyListModel alloc] init];
                                                }
                                                if (weakself.index == 1) {
                                                    [_model.dataArray removeAllObjects];
                                                }
                                                [_model setValuesForKeysWithDictionary:responseObj];
                                                [_collectionView reloadData];
                                            }
                                        }
                                          failed:^(NSError *error) {
                                              [LXMessage hideActiveView];
                                              [_collectionView.mj_header endRefreshing];
                                              [_collectionView.mj_footer endRefreshing];
                                              [LXMessage showErrorMessage:error.localizedDescription];
                                          }];
}

@end
