//
//  LXRoadAdministrationController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/5.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXRoadAdministrationController.h"
#import "LXRoadAdministrationCollectionViewCell.h"
#import "LXCustomNavigationView.h"
#import "LXRoadAdministrationDetailControllerViewController.h"              //明细
#import "LXRoadAdministrationModel.h"
@interface LXRoadAdministrationController ()
@property (nonatomic,strong) LXCustomNavigationView *bgView;                /**<  */
@property (nonatomic,strong) LXRoadAdministrationListModel *model;          /**<  */
@property (nonatomic,assign) NSInteger index;                               /**< */
@end
static NSString*const KLXRoadAdministrationCollectionViewCell_Dis = @"LXRoadAdministrationCollectionViewCell_dis";
@implementation LXRoadAdministrationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

/**
   配置UI
 */
- (void)configUI{
    CGFloat hight =  kNavHeight;
    [self configCollectionViewWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight - hight )
                              LineSpace:5
                                 vSpace:1
                       scrollDirecation:UICollectionViewScrollDirectionVertical
                              isRefresh:NO];
    [_collectionView registerClass:[LXRoadAdministrationCollectionViewCell class]
        forCellWithReuseIdentifier:KLXRoadAdministrationCollectionViewCell_Dis];
    [_collectionView setBackgroundColor:kRGBColor(235, 235, 235)];
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
    LXRoadAdministrationModel *model = [self.model.dataArray objectAtIndex:indexPath.item];
    
    LXRoadAdministrationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXRoadAdministrationCollectionViewCell_Dis forIndexPath:indexPath];
      cell.contentStr = model.Introduction;
      cell.titleStr   = kStringConvertNull(model.ArticleContent);
      cell.timeStr   = model.PublishTime;
    return cell;
}
-  (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kWidth, 130);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.dataArray.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 0, 0, 0);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[LXRoadAdministrationDetailControllerViewController new] animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    LXWeakSelf(self);
    [self.navigationController.navigationBar addSubview:self.bgView];
    self.index = 1;
    [self loadData];
    [self.bgView didSelectClick:^{
        [weakself.bgView removeFromSuperview];
        [weakself.navigationController popViewControllerAnimated:YES];
    }];
    
}
- (void)viewDidDisappear:(BOOL)animated{
      [super viewDidDisappear:animated];
       [self.bgView removeFromSuperview];
}
- (LXCustomNavigationView *)bgView{
    if (!_bgView) {
        _bgView = [[LXCustomNavigationView alloc] initWithFrame:CGRectMake(0, -20, kWidth, kNavHeight)];
    }
    return _bgView;
}
- (void)loadData{
    LXWeakSelf(self);
    [LXNetManager postWithParamDictionary:[LXInterface postMsgCMSArticleListPageIndex:kStringByInt(self.index)
                                                                             PageSize:@"20"]
                                 finished:^(id responseObj) {
                                     [_collectionView.mj_header endRefreshing];
                                     [_collectionView.mj_footer endRefreshing];
                                     [LXMessage hideActiveView];
                                     if (responseObj &&
                                         [[responseObj objectForKey:@"state"] intValue] >=0) {
                                         if (!_model) {
                                             _model = [[LXRoadAdministrationListModel alloc] init];
                                         }
                                         
                                         if (weakself.index == 1 ) {
                                             [_model.dataArray removeAllObjects];
                                         }
                                         [_model setValuesForKeysWithDictionary:responseObj];
                                         [_collectionView reloadData];
                                     }
                                 } failed:^(NSError *error) {
                                     [_collectionView.mj_header endRefreshing];
                                     [_collectionView.mj_footer endRefreshing];
                                     [LXMessage hideActiveView];
                                     [LXMessage showErrorMessage:error.localizedDescription];
    }];
}
@end
