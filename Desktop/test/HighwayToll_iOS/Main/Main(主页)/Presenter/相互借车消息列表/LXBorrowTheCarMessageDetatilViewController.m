//
//  LXBorrowTheCarMessageDetatilViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/5.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXBorrowTheCarMessageDetatilViewController.h"
#import "LXBorrowTheCarSuccessMessageDetatilViewCell.h"                 //**< cell*/
#import "LXBorrowTheCarApplyForBorrowCarMessageDetatilViewCell.h"       //**< cell*/
#import "LXBorrowTheCarNewApplyForBorrowCarMessageDetatilViewCell.h"    //**< cell*/
#import "LXBorrowTheCarHadTextCollectionViewCell.h"                     //**< cell*/
#import "LXBorrowTheCarNewApplyForBorrowCarHaveBackCarViewCell.h"       //**< cell*/
#import "LXInterface+CarInfo.h"
#import "LXMessageList.h"
@interface LXBorrowTheCarMessageDetatilViewController ()
@property (nonatomic,assign) NSInteger      index;                                  /**< 下标 */
@property (nonatomic,strong) LXMessageList *model;                                  /**<  */
@property (nonatomic,strong) LXBorrowTheCarHadTextCollectionViewCell *alertView;    /**< 弹出的视图 */
  @property (nonatomic,assign) BOOL isShow;                                         /**< */
@end
static NSString*const KLXBorrowTheCarSuccessMessageDetatilViewCell_dis = @"KLXBorrowTheCarSuccessMessageDetatilViewCell_dis";
static NSString*const KLXBorrowTheCarApplyForBorrowCarMessageDetatilViewCell_dis = @"LXBorrowTheCarApplyForBorrowCarMessageDetatilViewCell_dis";
static NSString*const KLXBorrowTheCarNewApplyForBorrowCarMessageDetatilViewCell_dis = @"LXBorrowTheCarNewApplyForBorrowCarMessageDetatilViewCell_dis";
static NSString*const KLXBorrowTheCarHadTextCollectionViewCell_dis = @"LXBorrowTheCarHadTextCollectionViewCell_dis";
static NSString*const KLXBorrowTheCarNewApplyForBorrowCarHaveBackCarViewCell_dis = @"KLXBorrowTheCarNewApplyForBorrowCarHaveBackCarViewCell_dis";
@implementation LXBorrowTheCarMessageDetatilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.index = 1;
//    [self loadMsgData];
    [self configUI];
}
- (void)configUI{

    self.title = @"相互借车列表";
    CGFloat hight =  kNavHeight;
    [self configCollectionViewWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight - hight )
                              LineSpace:5
                                 vSpace:1
                       scrollDirecation:UICollectionViewScrollDirectionVertical
                              isRefresh:NO];
    [_collectionView registerClass:[LXBorrowTheCarSuccessMessageDetatilViewCell class]
        forCellWithReuseIdentifier:KLXBorrowTheCarSuccessMessageDetatilViewCell_dis];
    [_collectionView registerClass:[LXBorrowTheCarApplyForBorrowCarMessageDetatilViewCell class]
        forCellWithReuseIdentifier:KLXBorrowTheCarApplyForBorrowCarMessageDetatilViewCell_dis];
    [_collectionView registerClass:[LXBorrowTheCarNewApplyForBorrowCarMessageDetatilViewCell class]
        forCellWithReuseIdentifier:KLXBorrowTheCarNewApplyForBorrowCarMessageDetatilViewCell_dis];
    [_collectionView registerClass:[LXBorrowTheCarNewApplyForBorrowCarHaveBackCarViewCell class]forCellWithReuseIdentifier:KLXBorrowTheCarNewApplyForBorrowCarHaveBackCarViewCell_dis];
    [_collectionView setBackgroundColor:kRGBColor(242, 242, 242)];
    UIGestureRecognizer *tap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(topClick)];
    [self.view addGestureRecognizer:tap];
    [_collectionView setUserInteractionEnabled:YES];
    [self.view setUserInteractionEnabled:YES];
}
- (void)topClick{ 
    if (self.isShow) {
        [self.alertView removeFromSuperview];
        self.view.backgroundColor  = [UIColor whiteColor];
        self.view.alpha = 1;
    }self.fd_interactivePopDisabled = false;
    self.isShow = NO;
}
#pragma mark collectionCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//   LXMessageModel *model = [self.model.dataArray objectAtIndex:indexPath.item];
////    /**
////     BorrowStateId
////     1  请求借车
////     2  同意借车
////     3  主动借车
////     4  拒绝借车
////     5  还车（请求借车）
////     6  还车(主动借车)
////     */
////    // 判断车主电话是不是等于当前登录人电话如果是的话则是向朋友借车
//    if (model.BorrowInfo.BorrowStateId  == 1 &&
//        [model.BorrowInfo.DriverPhone isEqualToString:[LXUserInfoModel shareUser].Phone]) {
//        LXBorrowTheCarApplyForBorrowCarMessageDetatilViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXBorrowTheCarApplyForBorrowCarMessageDetatilViewCell_dis forIndexPath:indexPath];
//        return cell;
//    }
//    if (model.BorrowInfo.BorrowStateId  == 1 &&
//          [model.BorrowInfo.OwnerPhone isEqualToString:[LXUserInfoModel shareUser].Phone]) {
//        LXBorrowTheCarApplyForBorrowCarMessageDetatilViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXBorrowTheCarApplyForBorrowCarMessageDetatilViewCell_dis forIndexPath:indexPath];
//        return cell;
//    }
//    //朋友向我借车
//    if ((model.BorrowInfo.BorrowStateId  == 3||
//         model.BorrowInfo.BorrowStateId  == 2) &&
//         ([model.BorrowInfo.OwnerPhone isEqualToString:[LXUserInfoModel shareUser].Phone])) {
//        LXBorrowTheCarApplyForBorrowCarMessageDetatilViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXBorrowTheCarApplyForBorrowCarMessageDetatilViewCell_dis forIndexPath:indexPath];
//        return cell;
//    }if ((model.BorrowInfo.BorrowStateId  == 3||
//         model.BorrowInfo.BorrowStateId  == 2) &&
//         ([model.BorrowInfo.DriverPhone isEqualToString:[LXUserInfoModel shareUser].Phone])) {//显示还车按钮
//        LXBorrowTheCarApplyForBorrowCarMessageDetatilViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXBorrowTheCarApplyForBorrowCarMessageDetatilViewCell_dis forIndexPath:indexPath];
//        return cell;
//    }if ( model.BorrowInfo.BorrowStateId  == 4 )
//     {//显示还车按钮
//         LXBorrowTheCarApplyForBorrowCarMessageDetatilViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXBorrowTheCarApplyForBorrowCarMessageDetatilViewCell_dis forIndexPath:indexPath];
//         return cell;
//    }
//    if ( model.BorrowInfo.BorrowStateId  == 5 ||
//        model.BorrowInfo.BorrowStateId  == 6)
//    {//显示还车按钮
//        LXBorrowTheCarSuccessMessageDetatilViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXBorrowTheCarSuccessMessageDetatilViewCell_dis forIndexPath:indexPath];
//        return cell;
//    }
//    //------------------------------------------我是分割线-------------------------------------------
//    if (indexPath.item == 0) {
//        LXBorrowTheCarSuccessMessageDetatilViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXBorrowTheCarSuccessMessageDetatilViewCell_dis forIndexPath:indexPath];
//        return cell;
//    }else if (indexPath.item == 1){
//        LXBorrowTheCarApplyForBorrowCarMessageDetatilViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXBorrowTheCarApplyForBorrowCarMessageDetatilViewCell_dis forIndexPath:indexPath];
//        return cell;
//    }else if(indexPath.item == 3){
//        LXBorrowTheCarHadTextCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXBorrowTheCarHadTextCollectionViewCell_dis forIndexPath:indexPath];
//        return cell;
//    }else{
//         LXBorrowTheCarNewApplyForBorrowCarMessageDetatilViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXBorrowTheCarNewApplyForBorrowCarMessageDetatilViewCell_dis forIndexPath:indexPath];
//    [cell didSelect:^(BOOL isAgree) {
//        if (isAgree) {
//            DLog(@"同意");
//        }else{
//            DLog(@"拒绝");
//        }
//    }];
//         return cell;
//    }
     LXBorrowTheCarNewApplyForBorrowCarHaveBackCarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXBorrowTheCarNewApplyForBorrowCarHaveBackCarViewCell_dis
                                                                                                            forIndexPath:indexPath];
    LXWeakSelf(self);
    [cell didSelect:^{
        DLog(@"ggggx");
    }];
    return cell;
}
-  (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    switch (indexPath.item) {
//        case 0:
//            return CGSizeMake(kWidth, 215);
//            break;
//        case 1:
//            return CGSizeMake(kWidth, 176);
//            break;
//        case 3:
//            return CGSizeMake(kWidth, 410);
//            break;
//        default:
//            return CGSizeMake(kWidth, 270);
//            break;
//    }
    return CGSizeMake(kWidth, 270);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return  UIEdgeInsetsMake(5, 0, 0, 0);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    DLog(@"asdfasdfasd");
}
@end
