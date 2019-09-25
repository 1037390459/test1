//
//  LXMyWalletTransactionDescriptViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyWalletTransactionDescriptViewController.h"
#import "LXMyWalletTransactionDescriptSelectViewCell.h"
#import "LXMyWalletTransactionDescriptContentCell.h"
#import "LXMyWalletModel.h"
@interface LXMyWalletTransactionDescriptViewController ()
@property (nonatomic,strong) LXMyWalletListModel *model;     /**<  */
@property (nonatomic,copy) NSString *typeId;                 /**< 类型id */
@end
static NSString*const KLXMyWalletTransactionDescriptSelectViewCell_dis = @"LXMyWalletTransactionDescriptSelectViewCell_dis";
static NSString*const KLXMyWalletTransactionDescriptContentCell_dis = @"KLXMyWalletTransactionDescriptContentCell_dis";
@implementation LXMyWalletTransactionDescriptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.typeId = @"1";
    [self loadData];
    [self configUI];
}
- (void)configUI{
    self.title = @"交易明细";
    CGFloat hight =  kNavHeight;
    [self configCollectionViewWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight - hight )
                              LineSpace:5
                                 vSpace:1
                       scrollDirecation:UICollectionViewScrollDirectionVertical
                              isRefresh:NO];
    [_collectionView registerClass:[ LXMyWalletTransactionDescriptSelectViewCell  class]
        forCellWithReuseIdentifier:KLXMyWalletTransactionDescriptSelectViewCell_dis];
    [_collectionView registerClass:[LXMyWalletTransactionDescriptContentCell  class]
        forCellWithReuseIdentifier:KLXMyWalletTransactionDescriptContentCell_dis];
    _collectionView.backgroundColor = kRGBColor(245, 245, 245);
}
#pragma mark collectionCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LXMyWalletTransactionDescriptSelectViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXMyWalletTransactionDescriptSelectViewCell_dis forIndexPath:indexPath];
        LXWeakSelf(self);
        [cell didSelectClick:^(NSInteger index) {
            weakself.typeId = kStringByInt(index);
            [weakself loadData];
        }];
        return cell;
    }else{
        LXMyWalletTransactionDescriptContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXMyWalletTransactionDescriptContentCell_dis forIndexPath:indexPath];
        LXMyWalletModel *model  = [self.model.dataArray objectAtIndex:indexPath.item];
        cell.index = self.typeId.integerValue;
        cell.titleStr   = model.CostTypeName;
        cell.addTimeStr = model.AddTime;
        cell.moneyStr = [NSString stringWithFormat:@"%.2f",model.Cost];
        return cell;
    }
}
-  (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kWidth, 65);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0)
    return  UIEdgeInsetsMake(5, 0, 5, 0);
    return  UIEdgeInsetsMake(0, 0, 1, 0);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.model.dataArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

//----------------------------
- (void)loadData{
    [LXNetManager postWithParamDictionary:[LXInterface postDriverCostLogList:self.typeId]
                                        finished:^(id responseObj) {
                                            [LXMessage hideActiveView];
                                            [_collectionView.mj_header endRefreshing];
                                            if (responseObj && [[responseObj objectForKey:@"state"] integerValue] > 0) {
                                                if (!self.model) {
                                                    self.model = [[LXMyWalletListModel alloc] init];
                                                }
                                                [_model.dataArray removeAllObjects];
                                                [_model setValuesForKeysWithDictionary:responseObj];
                                                if( _model.dataArray.count >0){
                                                    [_collectionView reloadData];
                                                }
                                            }
                                        } failed:^(NSError *error) {
                                            [_collectionView.mj_header endRefreshing];
                                            [LXMessage show:error.localizedDescription onView:self.view autoHidden:YES];
                                            [LXMessage hideActiveView];
                                        }];
}
@end
