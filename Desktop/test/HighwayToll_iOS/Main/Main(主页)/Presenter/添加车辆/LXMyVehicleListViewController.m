//
//  LXMyVehicleListViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/27.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyVehicleListViewController.h"
#import "LXMyVehicleCollectionViewCell.h"       //**<我的车辆cell*/
#import "LXAddVehicleViewController.h"          //**<添加成功*/
#import "LXLendACarToAfriendViewController.h"   //**<借车给朋友*/
#import "LXAddVehicleModel.h"
#import "LXInterface+CarInfo.h"
#import "LXLendACarToAfriendViewController.h"
@interface LXMyVehicleListViewController ()
@property (nonatomic,strong) UIButton *commitBtn;               /**< 提交按钮 */
@property (nonatomic,strong) LXAddVehicleListDataModel *model;  /**<  */
@end
static NSString*const KLXMyVehicleCollectionViewCell_dis = @"LXMyVehicleCollectionViewCell_dis";
@implementation LXMyVehicleListViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

/**
    配置UI
 */
- (void)configUI{
    self.title = @"我的车辆";
    CGFloat hight =  kNavHeight;
    [self createNavigationItemWithTitle:@""
                              imageName:@"Add"
                                 action:@selector(add)
                                 isLeft:NO];
    [self configCollectionViewWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight - hight )
                              LineSpace:5
                                 vSpace:1
                       scrollDirecation:UICollectionViewScrollDirectionVertical
                              isRefresh:NO];
    [_collectionView registerClass:[LXMyVehicleCollectionViewCell class]
        forCellWithReuseIdentifier:KLXMyVehicleCollectionViewCell_dis];
    [_collectionView setBackgroundColor:kRGBColor(242, 242, 242)];
    LXWeakSelf(self);
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadData];
    }];
}

- (void)addCommit{
    [self.view addSubview:self.commitBtn];
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-30*k_height);
        make.width.mas_equalTo(kWidth*0.75);
        make.height.mas_equalTo(kCellHeight);
        make.centerX.equalTo(self.view);
    }];
}
- (void)add{
    LXAddVehicleViewController *VC = [LXAddVehicleViewController new];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark collectionCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LXAddVehicleListModel *vModel = [self.model.dataArray objectAtIndex:indexPath.section];
    LXMyVehicleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXMyVehicleCollectionViewCell_dis forIndexPath:indexPath];
    cell.plateNumberStr = vModel.CarNumber;
    cell.ownerStr       =  kStringConvertNull(vModel.Owner);
    cell.carColorStr    = vModel.CarColor;
    cell.carTypeStr     = vModel.CarCatalogName;
    /// <summary>
    /// 正常
    /// </summary>
    // 正常=0,
    
    /// <summary>
    /// 车已借出
    /// </summary>
    // 车已借出 = 1,
    
    /// <summary>
    /// 借来的车
    /// </summary>
    // 借来的车=2,
    
    if (vModel.State == 0) {
        cell.isBorrow       = NO;
        cell.isShowRight    = NO;
    }
    else if (vModel.State == 1) {
        cell.isBorrow       = YES;
        cell.isShowRight    = NO;
    }
    else if (vModel.State == 2) {
        cell.isBorrow       = YES;
        cell.isShowRight    = YES;
    }
    LXWeakSelf(self);
    [cell didSelectClick:^{
//        [[LXMessage shareMessage] show:@"确定还车吗？" okTitle:@"确定"  Clicked:^(NSInteger buttonIndex) {
//            if (buttonIndex == 0) {
//                [weakself backCar:kStringByInt(vModel.CarId)];
//            }
//        } ViewController:self];
        DLog(@"点我了");
    }];
    return cell;
}
-  (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kWidth, 70);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0)
    return  UIEdgeInsetsMake(5, 0, 5, 0);
    return  UIEdgeInsetsMake(0, 0, 5, 0);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.model.dataArray.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LXAddVehicleViewController *VC = [LXAddVehicleViewController new];
    VC.isEdit = YES;
    VC.carId  =  ((LXAddVehicleListModel *)[self.model.dataArray objectAtIndex:indexPath.section]).CarId;
    [self.navigationController pushViewController:VC animated:YES];
}
//---------- 按钮-------------
- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn =     [LXView createButtonWithFrame:CGRectZero
                                                title:@"借车给朋友"
                                              bgColor:kRGBColor(56, 158, 61)
                                               radius:kfontValue(23)
                                               target:self
                                               action:@selector(commitBtnClick)];
        [_commitBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(17)]];
        _commitBtn.titleLabel.textColor = [UIColor whiteColor];
    }
    return _commitBtn;
}
- (void)commitBtnClick{
    LXLendACarToAfriendViewController *VC = [LXLendACarToAfriendViewController new];
    [self.navigationController pushViewController:VC animated:YES];
}
- (void)loadData{
    LXWeakSelf(self);
    [LXMessage showActiveViewOnView:self.view];
    [LXNetManager getRequestWithUrlString:[[LXInterface postCarInfoGetAllCar] objectForKey:@"url"]
                                   params:@[]
                                 finished:^(id responseObj) {
                                     [LXMessage hideActiveView];
                                     [_collectionView.mj_header endRefreshing];
                                     if ([responseObj objectForKey:@"data"] && responseObj) {
                                         if (!self.model) {
                                             self.model = [[LXAddVehicleListDataModel alloc] init];
                                         }
                                         [_model.dataArray removeAllObjects];
                                         [_model setValuesForKeysWithDictionary:responseObj];
                                         if( _model.dataArray.count >0){
                                             [weakself addCommit];
                                         }
                                         [_collectionView reloadData];
                                     }
                                 }
                                failed:^(NSError *error) { 
                                    [_collectionView.mj_header endRefreshing];
                                    [LXMessage show:error.localizedDescription onView:self.view autoHidden:YES];
                                    [LXMessage hideActiveView];
                                }];
}
- (void)dealloc{
    DLog(@"我是车辆列表");
}

/**
   还车

 @param carId carId description
 */
- (void)backCar:(NSString *)carId{
    [LXNetManager postWithParamDictionary:[LXInterface postRel_Car_BorrowBackCar:carId]
                                 finished:^(id responseObj) {
                                     [LXMessage showSuccessMessage:[responseObj objectForKey:@"msg"]];
                                     if (responseObj && [[responseObj objectForKey:@"state"] integerValue] >= 0) {
                                         [_collectionView reloadData];
                                     }
                                 }
                                   failed:^(NSError *error) {
                                       [LXMessage showErrorMessage:error.localizedDescription];
                                   }];
}
@end
