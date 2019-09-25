//
//  LXMainIndexViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/23.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMainIndexViewController.h"
#import "LXAddVehicleViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "LXMyMessageViewController.h"                //我的消息控制器
#import "LXBindingPhoneNumberViewController.h"       //*绑定手机号<*/
#import "LXMainAddVehicleView.h"                     //添加cell
#import "LXMainBindPhoneView.h"                      //绑定手机号码view
#import "LXUserCenterViewController.h"               //个人中心
#import "LXMainHaveGoneAwayView.h"                   //驶出
#import "LXMainHaveEnteredHighWayView.h"             //已经驶入高速公路
#import "LXRoadAdministrationController.h"           //公路
#import "LXLendACarToAfriendViewController.h"        //我要借车
#import "LXMyWalletRechargeViewController.h"         //充值
#import "LXUserCenterViewController.h"               //个人中心
#import "LXBorrowACarFromAFriendViewController.h"    //向朋友借车
#import "LXMainInUsedViewController.h"               // 未使用
#import "LXMainModel.h"                              // 主页
#import "LXNewBLEManageViewController.h"             // 蓝牙
#import "SDCycleScrollView.h"
#import "LXInterface+CarInfo.h"
#import "LXLeftMenuListViewController.h"
#import "LXNavItemModel.h"
#import "LXMainIndexCarTitleCollectionViewCell.h"           /**<cell*/
#import "LXMainIndexSelectCarCollectionViewCell.h"          /**<cell*/
#import "LXMainIndexRechargeMoneyCollectionViewCell.h"      /**<cell*/
#import "LXMainIndexCommitCollectionViewCell.h"             /**<cell*/
@interface LXMainIndexViewController ()<SDCycleScrollViewDelegate,LXMainAddVehicleViewDelegate>
@property (nonatomic,strong) NSMutableArray *cellDataArray;                 /**<  */
@property (nonatomic,assign) NSInteger index;                               /**< 下标 */
@property (nonatomic,strong) LXMainListModel *model;                        /**<  */
@end
static NSString*const KLXMainIndexCarTitleCollectionViewCell_dis        = @"KLXMainIndexCarTitleCollectionViewCell_dis";
static NSString*const KLXMainIndexSelectCarCollectionViewCell_dis       = @"KLXMainIndexSelectCarCollectionViewCell_dis";
static NSString*const KLXMainIndexRechargeMoneyCollectionViewCell_dis   = @"KLXMainIndexRechargeMoneyCollectionViewCell_dis";
static NSString*const KLXMainIndexCommitCollectionViewCell_dis          = @"KLXMainIndexCommitCollectionViewCell_dis";
@implementation LXMainIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self loadAdVData];
     [self configUI];
     [self settingShowView];
}

- (void)others{
    //    // self.fd_prefersNavigationBarHidden = YES;
    
        CGFloat kNavHeigh = kNavHeight;
        LXMainAddVehicleView *all = [[LXMainAddVehicleView alloc] initWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight-kNavHeigh)];
        all.delegate = self;
        [self.view addSubview:all];
    ////    CGFloat kNavHeigh = kNavHeight;
    ////        LXMainBindPhoneView *all = [[LXMainBindPhoneView alloc] initWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight-kNavHeigh)];
    //        //all.delegate = self;
    //        //    [self.view addSubview:all];
    //    LXMainHaveEnteredHighWayView *all = [[LXMainHaveEnteredHighWayView alloc] initWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight-kNavHeigh)];
    //            //all.delegate = self;
    //    [all didSelectCommitClick:^(NSInteger tag) {
    //        switch (tag) {
    //            case 0:
    //                [LXMessage showInfoMessage:@"左边按钮"];
    //                break;
    //            case 1:
    //                [LXMessage showInfoMessage:@"中间按钮"];
    //                break;
    //
    //            default:
    //                [LXMessage showInfoMessage:@"右边按钮"];
    //                break;
    //        }
    //    }];
    //    [self.view addSubview:all];
}

/**
   根据条件显示view
 */
- (void)settingShowView{
    if ([LXUserInfoModel shareUser].Cars.count  == 0 && [LXUserInfoModel shareUser].Balance == 0) {
        [self others];
    }else{ 
        self.index = -1;
        [self setCollectionConfigUI];
    }
}
- (void)setCollectionConfigUI{
    CGFloat hight =  kNavHeight;
    [self configCollectionViewWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight - hight )
                              LineSpace:1
                                 vSpace:1
                       scrollDirecation:UICollectionViewScrollDirectionVertical
                              isRefresh:NO];
    [_collectionView registerClass:[LXMainIndexCarTitleCollectionViewCell class]
        forCellWithReuseIdentifier:KLXMainIndexCarTitleCollectionViewCell_dis];
    [_collectionView registerClass:[LXMainIndexSelectCarCollectionViewCell class]
        forCellWithReuseIdentifier:KLXMainIndexSelectCarCollectionViewCell_dis];
    [_collectionView registerClass:[LXMainIndexRechargeMoneyCollectionViewCell class]
        forCellWithReuseIdentifier:KLXMainIndexRechargeMoneyCollectionViewCell_dis];
    [_collectionView registerClass:[LXMainIndexCommitCollectionViewCell class]
        forCellWithReuseIdentifier:KLXMainIndexCommitCollectionViewCell_dis];
    [_collectionView.layer setContents:(id _Nullable) [UIImage imageNamed:@"goAwayBgView"].CGImage];
    //注册头视图
    [_collectionView registerClass:[UICollectionReusableView class]
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:@"UICollectionViewHeader"];
}
//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                            withReuseIdentifier:@"UICollectionViewHeader"
                                                                                   forIndexPath:indexPath];
    
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(headView.x, 10, headView.width-30, headView.height-20) delegate:self
                                                                     placeholderImage:[UIImage imageNamed:@"timg"]];

    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    [cycleScrollView2.layer setCornerRadius:8];
    [cycleScrollView2.layer setMasksToBounds:YES];
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    cycleScrollView2.imageURLStringsGroup = self.model.imageArray;
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    CGFloat i = self.view.center.x;
    cycleScrollView2.center = CGPointMake(i, cycleScrollView2.centerY);
    [headView addSubview:cycleScrollView2];
    return headView;
}
// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(kWidth-30, 155);
    }
    else {
        return CGSizeMake(0, 0);
    }
}
#pragma mark collectionCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        LXMainIndexCarTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXMainIndexCarTitleCollectionViewCell_dis forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 1){
        
        NSArray *array = [LXUserInfoModel shareUser].Cars;
        LXCarModel *model = [[LXCarModel alloc] initWithDictionary:[array objectAtIndex:indexPath.item]];
        LXMainIndexSelectCarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXMainIndexSelectCarCollectionViewCell_dis forIndexPath:indexPath];
        cell.plateStr = model.CarNumber;
        cell.isDefault = model.IsDefaultCar;
        if (model.IsDefaultCar) {
            self.index = indexPath.item;
        }
//        if (model.IsDefaultCar) {
//            cell.isSelect = YES;
//            cell.isSelectType = YES;
//        }else{
//            cell.isSelect = NO;
//            cell.isSelectType = NO;
//        }
        [self.cellDataArray addObject:cell];
        cell.tag = indexPath.item;
        return cell;
    }else if(indexPath.section == 2){
        LXMainIndexRechargeMoneyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXMainIndexRechargeMoneyCollectionViewCell_dis forIndexPath:indexPath];
        cell.moneyStr = [NSString stringWithFormat:@"%.2f",[LXUserInfoModel shareUser].Balance];
        [cell didSelectCommitClick:^{
            LXMyWalletRechargeViewController *VC = [LXMyWalletRechargeViewController new];
            VC.isHome = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }];
        return cell;
    }else{
        LXMainIndexCommitCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXMainIndexCommitCollectionViewCell_dis forIndexPath:indexPath];
        LXWeakSelf(self);
        [cell didSelectCommitClick:^(NSInteger tag) {
                            switch (tag) {
                                case 0:{ 
                                    [self.navigationController pushViewController:[LXUserCenterViewController new] animated:YES];
                                }
                                    break;
                                case 1:{
                                    
                                    [weakself setUseCar];
                                }
                                    break;
                    
                                default:
                                    [LXMessage showInfoMessage:@"右边按钮"];
                                    break;
                            }
        }];
        return cell;
    }
}
-  (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 3:
            return CGSizeMake(kWidth-30, 230);
            break;
            
        default:
            return CGSizeMake(kWidth-30, kCellHeight);
            break;
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
   
    if (section == 0) {
        return  UIEdgeInsetsMake(0, 15, 5, 15);
    }else if (section == 1) {
        return  UIEdgeInsetsZero;
    }else if(section == 2){
        return  UIEdgeInsetsMake(5, 15, 5, 15);
    }else{
       return  UIEdgeInsetsZero;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 1) {
        return [LXUserInfoModel shareUser].Cars.count;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 1) {
        for (LXMainIndexSelectCarCollectionViewCell *cell in self.cellDataArray) {
            cell.isSelectType = YES;
            if (indexPath.item == cell.tag) {
               
                self.index = indexPath.item;
                cell.isSelect = YES;
            }else{
                cell.isSelect = NO;
            }
        }

    }else{
        if (indexPath.section == 0) {
            [self.navigationController pushViewController:[LXBorrowACarFromAFriendViewController new] animated:YES];
        }
        for (LXMainIndexSelectCarCollectionViewCell *cell in self.cellDataArray) {
            cell.isSelectType = NO;
        }
    }
}
- (void)setConfigUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)configUI{
    self.cellDataArray = [[NSMutableArray alloc] init];
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
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll]; 
}

#pragma mark LXMainAddVehicleViewDelegate

- (void)didSelectStartBtnClick{
    [LXMessage showInfoMessage:@"开始用车"];
}
//添加车辆
- (void)didSelectAddVehicleClick{
    LXAddVehicleViewController *VC =  [LXAddVehicleViewController new];
    VC.isFormMain = YES;
    [self.navigationController pushViewController:VC animated:YES];
}
//借呗
- (void)didSelectBorrowCarClick{
    [self.navigationController pushViewController:[LXBorrowACarFromAFriendViewController new] animated:YES];
}


/**
   设置默认车
 */
- (void)setDefaultCar:(NSInteger )carId{
    [LXNetManager postRequestWithParamDictionary:[LXInterface postCarInfoSetDefault:carId]
                                        finished:^(id responseObj) {
                                            
                                        } failed:^(NSError *error) {
                                            
                                        }];
}
/**
    开始用车
 */
- (void)setUseCar{
    if ([LXNewBLEManageViewController manager].blueToothState) {
        [LXMessage showSuccessMessage:@"手机蓝牙正常"];
    }else{
        [LXMessage showErrorMessage:@"手机蓝牙异常"];
        return;
    }
    if (self.index == -1) {
        [LXMessage showErrorMessage:@"请选择默认车辆"];
        return;
    }
    LXWeakSelf(self);
    NSArray *array = [LXUserInfoModel shareUser].Cars;
    LXCarModel *model = [[LXCarModel alloc] initWithDictionary:[array objectAtIndex:self.index]];
    [LXNetManager postRequestWithParamDictionary:[LXInterface postCarInfoUseCar:kStringByInt(model.CarId)]
                                                finished:^(id responseObj) {

                                                    if ([[responseObj objectForKey:@"state"] integerValue] >0) {
                                                        [LXMessage showSuccessMessage:@"已开始用车"];
                                                        LXMainInUsedViewController *VC = [LXMainInUsedViewController new];
                                                        VC.model = [LXMyJourneyModel new];
                                                        VC.model.TollRecordId = [[responseObj objectForKey:@"data"] intValue];
                                                        VC.carId    = [NSString stringWithFormat:@"%ld",(long)model.CarId];
                                                        [LXNewBLEManageViewController manager].TollRecordId =  [[responseObj objectForKey:@"data"] intValue];
                                                        [weakself.navigationController pushViewController:VC animated:YES];
                                                    }else{
                                                        [LXMessage showErrorMessage:[responseObj objectForKey:@"msg"]];
                                                    }
                                                }
                                                  failed:^(NSError *error) {
                                                       [LXMessage showErrorMessage:error.localizedDescription];
                                                  }];
}
/**
 加载金额
 */
- (void)loadDataMoney{
    [[LXNetManager shareManager] getRequestWithUrlString:[[LXInterface postDriverInfoGetBaseInfo] objectForKey:@"url"]
                                                finished:^(id responseObj) {
                                                    if (responseObj && [responseObj objectForKey:@"data"]) {
                                                        KUserDefault_Set([[responseObj objectForKey:@"data"] objectForKey:@"Cars"], @"Cars");
                                                        KUserDefault_Set([[responseObj objectForKey:@"data"] objectForKey:@"Balance"], @"Balance");
                                                        [_collectionView reloadData];
                                                    }
                                                }
                                                  failed:^(NSError *error) {
                                                      
                                                  }];;
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.index = -1;
    [self loadDataMoney];
}

/**
   加载广告
 */
- (void)loadAdVData{
    [LXNetManager getWithParamDictionary:[LXInterface postAdvList]
                                        finished:^(id responseObj) {
                                            if (responseObj &&
                                                [[responseObj objectForKey:@"state"] integerValue]>= 0) {
                                                if (!_model) {
                                                    _model = [[LXMainListModel alloc] init];
                                                }
                                                [_model setValuesForKeysWithDictionary:responseObj];
                                            }
                                        }
                                          failed:^(NSError *error) {
                                              [LXMessage showErrorMessage:error.localizedDescription];
                                          }];
}
@end
