//
//  LXMyMessageViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/28.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyMessageViewController.h"
#import "LXMyMessageCollectionViewCell.h"                           //我的消息cell
#import "LXBorrowACarFromAFriendMessageListViewController.h"        //向朋友借车
#import "LXBorrowTheCarMessageDetatilViewController.h"              //相互借车消息
#import "LXMailViewController.h"                                    /**<站内信*/
#import "LXMessageList.h"
@interface LXMyMessageViewController ()
@property (nonatomic,strong) NSMutableArray *titleArray;    /**<  */
@property (nonatomic,strong) LXMyMessageList *model;         /**< 数据模型 */
@end
static NSString*const KLXMyMessageCollectionViewCell_dis = @"LXMyMessageCollectionViewCell_dis";
@implementation LXMyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self configUI];
}
//配置UI
- (void)configUI{
    self.title = @"我的消息";
    CGFloat hight =  kNavHeight;
    self.titleArray = @[@"站内信",@"ATC公告",@"向朋友借车",@"借车给朋友"].mutableCopy;
    [self configCollectionViewWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight - hight )
                              LineSpace:5
                                 vSpace:1
                       scrollDirecation:UICollectionViewScrollDirectionVertical
                              isRefresh:NO];
    [_collectionView setBackgroundColor:kRGBColor(245, 245, 245)];
    [_collectionView registerClass:[LXMyMessageCollectionViewCell class]
        forCellWithReuseIdentifier:KLXMyMessageCollectionViewCell_dis];
   
}
#pragma mark collectionCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LXMyMessageModel *model = [self.model.dataArray objectAtIndex:0];
    LXMyMessageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXMyMessageCollectionViewCell_dis forIndexPath:indexPath];
   
    if (indexPath.section == 0) {
        cell.imageName = @"zhanNeiXin";
        cell.contentStr = kStringConvertNull(model.LastLetter.MsgContent);
        cell.addTimeStr = kStringConvertNull(model.LastLetter.AddTime);
        cell.number     = model.UnReadLetter;
    }else if (indexPath.section == 1) {
        cell.imageName = @"jieche";
        cell.contentStr = kStringConvertNull(model.LastNotice.MsgContent);
        cell.addTimeStr = kStringConvertNull(model.LastNotice.AddTime);
        cell.number     = model.UnReadNotice;
    }else if (indexPath.section == 2) {
        cell.imageName = @"jieche2";
        cell.contentStr = kStringConvertNull(model.RequestCar.MsgContent);
        cell.addTimeStr = kStringConvertNull(model.RequestCar.AddTime);
        cell.number     = model.UnReadRequestCar;
    }else{
        cell.imageName = @"ATCgonggao";
        cell.contentStr = kStringConvertNull(model.BorrowCar.MsgContent);
        cell.addTimeStr = kStringConvertNull(model.BorrowCar.AddTime);
        cell.number     = model.UnReadBorrowCar;
    }
//    cell.contentStr = model.MsgContent;
//    cell.addTimeStr = model.AddTime;
//    cell.isRead = model.IsRead;
    cell.titleStr = _titleArray[indexPath.section];
    return cell;
}
-  (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kWidth, 75);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if(section == 0)
    return  UIEdgeInsetsMake(5, 0, 1, 0);
    return  UIEdgeInsetsMake(0, 0, 1, 0);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
    if(indexPath.section == 0){
        LXMailViewController *VC = [LXMailViewController new];
        VC.type = 1;
        [self.navigationController pushViewController:VC animated:YES];
    }else if(indexPath.section == 1){

        LXMailViewController *VC = [LXMailViewController new];
        VC.type = 2;
        [self.navigationController pushViewController:VC animated:YES];
    }else if(indexPath.section == 2){
        LXBorrowTheCarMessageDetatilViewController *VC = [LXBorrowTheCarMessageDetatilViewController new];
        VC.type = 3;
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        LXBorrowTheCarMessageDetatilViewController *VC = [LXBorrowTheCarMessageDetatilViewController new];
        VC.type = 4;
        [self.navigationController pushViewController:VC animated:YES];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置NavigationBar背景颜色
    [[UINavigationBar appearance] setBackgroundColor:[UIColor redColor]];
    //@{}代表Dictionary
}
- (void)loadData{
    
    [LXNetManager postRequestWithParamDictionary:[LXInterface postMsgInfoMyMsg]
                                 finished:^(id responseObj) {
                                     if (responseObj &&
                                         [[responseObj objectForKey:@"state"] intValue] >=0) {
                                         if (!self.model) {
                                             self.model = [[LXMyMessageList alloc] init];
                                         }
                                         [self.model setValuesForKeysWithDictionary:responseObj];
                                         [_collectionView reloadData];
                                     }
                                 } failed:^(NSError *error) {
                                     [LXMessage showErrorMessage:error.localizedDescription];
    }];
}
@end
