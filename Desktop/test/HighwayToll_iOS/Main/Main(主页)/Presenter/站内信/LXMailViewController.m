//
//  LXMailViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/27.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMailViewController.h"
#import "LXMailCollectionViewCell.h"
#import "LXMessageList.h"
@interface LXMailViewController ()
@property (nonatomic,strong) UIButton      *rightBtn;                 /**<  */
@property (nonatomic,strong) LXMessageList *model;                    /**< 模型 */
@property (nonatomic,assign) NSInteger      index;                    /**< 下标 */
@end
static NSString*const KLXMailCollectionViewCell_dis = @"LXMailCollectionViewCell_dis";
@implementation LXMailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.index = 1;
    [self loadMsgData];
    [self configUI];
}
- (void)configUI{
    self.title = @"站内信";
    //--------------------------------------------start---------------------------------
    UIButton *rightBtn =  [self createNavigationItemWithTitle:@"清空列表"
                                                    imageName:nil
                                                       action:@selector(removeAllClick)
                                                       isLeft:NO];
    [rightBtn setTitleColor:[UIColor blackColor] forState:0];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(13)]];
    rightBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
  
    //--------------------------------------------end-----------------------------------
    CGFloat hight =  kNavHeight;
    [self configCollectionViewWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight - hight )
                              LineSpace:5
                                 vSpace:1
                       scrollDirecation:UICollectionViewScrollDirectionVertical
                              isRefresh:NO];
    [_collectionView setBackgroundColor:kRGBColor(245, 245, 245)];
    [_collectionView registerClass:[LXMailCollectionViewCell class]
        forCellWithReuseIdentifier:KLXMailCollectionViewCell_dis];
    LXWeakSelf(self);
    _collectionView.mj_footer  = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakself.index++;
        [weakself loadMsgData];
    }];
    _collectionView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.index = 1;
        [weakself loadMsgData];
    }];
}
- (void)removeAllClick{
    [LXMessage showInfoMessage:@"清除全部"];
}
#pragma mark collectionCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LXMailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXMailCollectionViewCell_dis
                                                                           forIndexPath:indexPath];
    LXMessageModel *model = self.model.dataArray[indexPath.item];
    cell.titleStr = model.TypeName;
    cell.addTimeStr = model.AddTime;
    cell.contentStr = model.MsgContent;
    return cell;
}
-  (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kWidth, 125);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return  UIEdgeInsetsMake(5, 0, 0, 0);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.dataArray.count;
}

/**
 加载消息数据
 */
- (void)loadMsgData{
    [LXNetManager postRequestWithParamDictionary:[LXInterface postMsgListMsgTypeIdArr:@[@(self.type)]
                                                                             pageSize:@"20"
                                                                            pageIndex:kStringByInt(self.index)]
                                        finished:^(id responseObj) {
                                            [LXMessage hideActiveView];
                                            [_collectionView.mj_header endRefreshing];
                                            [_collectionView.mj_footer endRefreshing];
                                            if (responseObj && [[responseObj objectForKey:@"state"] integerValue] > 0) {
                                                if (!self.model) {
                                                    self.model = [[LXMessageList alloc] init];
                                                }
                                                [_model.dataArray removeAllObjects];
                                                [_model setValuesForKeysWithDictionary:responseObj];
                                                if( _model.dataArray.count >0){
                                                    [_collectionView reloadData];
                                                }
                                            }
                                        } failed:^(NSError *error) {
                                            [_collectionView.mj_header endRefreshing];
                                            [_collectionView.mj_footer endRefreshing];
                                            [LXMessage show:error.localizedDescription onView:self.view autoHidden:YES];
                                            [LXMessage hideActiveView];
                                        }];
}
@end
