//
//  LXAddVehicleViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/24.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXAddVehicleViewController.h"
#import "LXAddVehicleCollectionViewCell.h"
#import "LXAddVehicleCollectionViewSecondCell.h"
#import "LXAddVehicleCollectionViewSelectCell.h"
#import "LXAddVehicleCollectionViewPhotoUpLoadCell.h"
#import "LXAddVehicleCollectionViewCommitCell.h"
#import "HSDAutoSelectView.h"
#import "LXAddVehicleSucessViewController.h"
#import "LXAddVehicleEngineAndColorViewCell.h" // 
#import "LXInterface+UserCenter.h"
#import "LXInterface+CarInfo.h"
#import "TZImagePickerController.h"
#import "LXInterface+CarInfo.h"
#import "LXAddVehicleModel.h"   //**<*数据模型*/
@interface LXAddVehicleViewController ()<TZImagePickerControllerDelegate>
@property (nonatomic,strong) NSMutableArray *titleArray;          /**< 标题数组 */
@property (nonatomic,strong) NSMutableArray *cellArray;           /**< cell数组 */
@property (nonatomic,strong) LXAddVehicleModel *vehicleModel;     /**< 车辆模型 */
@property (nonatomic,strong) LXAddCarTypeListDataModel *carModel; /**<  */
@property (nonatomic,assign) NSInteger carTypeIndex;              /**< 车辆下标*/
@property (nonatomic,strong) LXCarDetatilModel *carDetatilModel;  /**< 明细 */
@property (nonatomic,strong) LXCarType *carModel_ ;               /**< 车辆明细 */
@end
static NSString*const KLXAddVehicleCollectionViewCell_dis               = @"LXAddVehicleCollectionViewCell_dis";
static NSString*const KLXAddVehicleCollectionViewSecondCell_dis         = @"LXAddVehicleCollectionViewSecondCell_dis";
static NSString*const KLXAddVehicleCollectionViewSelectCell_dis         = @"LXAddVehicleCollectionViewSelectCell_dis";
static NSString*const KLXAddVehicleCollectionViewPhotoUpLoadCell_dis    = @"LXAddVehicleCollectionViewPhotoUpLoadCell_dis";
static NSString*const KLXAddVehicleCollectionViewCommitCell_dis         = @"KLXAddVehicleCollectionViewCommitCell_dis";
static NSString*const KLXAddVehicleEngineAndColorViewCell_dis           = @"KLXAddVehicleEngineAndColorViewCell_dis";
@implementation LXAddVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadCarTypeListData];
    [self configUI];
}
#pragma mark

/**
        配置UI
 */
- (void)configUI{
    _carTypeIndex = -1;
    self.vehicleModel = [[LXAddVehicleModel alloc] init];
    self.titleArray = [NSMutableArray arrayWithObjects:@"车牌号码    沪",@"车架号",@"车身颜色",@"车型选择",@"",@"", nil];
    if (self.isEdit) {
        self.title = @"编辑车辆";
        [self getCarDetailById];
    }else{self.title = @"添加车辆";}
    [self configCollectionViewWithFrame:CGRectMake(0, 64, kWidth, kHeight-64)
                              LineSpace:5
                                 vSpace:1
                       scrollDirecation:UICollectionViewScrollDirectionVertical
                              isRefresh:NO];
    
    [_collectionView registerClass:[LXAddVehicleCollectionViewCell class]
        forCellWithReuseIdentifier:KLXAddVehicleCollectionViewCell_dis];
    [_collectionView registerClass:[LXAddVehicleCollectionViewSecondCell class]
        forCellWithReuseIdentifier:KLXAddVehicleCollectionViewSecondCell_dis];
    [_collectionView registerClass:[LXAddVehicleCollectionViewSelectCell class]
        forCellWithReuseIdentifier:KLXAddVehicleCollectionViewSelectCell_dis];
    [_collectionView registerClass:[LXAddVehicleCollectionViewPhotoUpLoadCell class]
        forCellWithReuseIdentifier:KLXAddVehicleCollectionViewPhotoUpLoadCell_dis];
    [_collectionView registerClass:[LXAddVehicleCollectionViewCommitCell class]
        forCellWithReuseIdentifier:KLXAddVehicleCollectionViewCommitCell_dis];
    [_collectionView registerClass:[LXAddVehicleEngineAndColorViewCell class]
        forCellWithReuseIdentifier:KLXAddVehicleEngineAndColorViewCell_dis];
    
    [_collectionView setBackgroundColor:kRGBColor(242, 242, 242)];
}
#pragma mark collectionCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = nil;
    if (indexPath.section == 0) {
      cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXAddVehicleCollectionViewCell_dis forIndexPath:indexPath];
      LXAddVehicleCollectionViewCell *vCell = (LXAddVehicleCollectionViewCell*)cell;
        NSArray *data = @[@"京",@"沪",@"浙",@"苏",@"粤",@"鲁",@"晋",@"冀",@"豫",@"川",@"渝",@"辽",@"吉",@"黑",@"皖",@"鄂",@"津",@"贵",@"云",@"桂",@"琼",@"青",@"新",@"藏",@"蒙",@"宁",@"甘",@"陕",@"闽",@"赣",@"湘"];
        if (self.isEdit) {//如果是编辑则赋值
            NSString *plate = self.carDetatilModel.CarNumber;
            plate = [plate substringWithRange:NSMakeRange(0, 1)];
            vCell.strTitle = [NSString stringWithFormat:@"车牌号码    %@",plate];
            vCell.contentStr  = [self.carDetatilModel.CarNumber  stringByReplacingOccurrencesOfString:plate withString:@""];
            vCell.titleBtn.tag = [data indexOfObject:plate];
        }else{
            vCell.strTitle = self.titleArray[indexPath.section];
        }
         LXWeakSelf(vCell)
        [vCell didSelectTypeClick:^{
            HSDAutoSelectView *selectView = [HSDAutoSelectView instanceView];
            selectView.dataArray =  data;
            selectView.selectIndex = vCell.titleBtn.tag;
            [selectView showWithView:cell callBack:^(NSInteger selectedIndex, NSString *selectTitle) {
                [weakvCell.titleBtn setTitle:[NSString stringWithFormat:@"车牌号码    %@",selectTitle] forState:0];
                weakvCell.titleBtn.tag = selectedIndex;
                
            }];
        }];
    }else if(indexPath.section == 1 ){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXAddVehicleCollectionViewSecondCell_dis forIndexPath:indexPath];
        LXAddVehicleCollectionViewSecondCell *vCell = (LXAddVehicleCollectionViewSecondCell*)cell;
        vCell.strTitle = self.titleArray[indexPath.section];
        if (_isEdit) {
            vCell.contentStr = self.carDetatilModel.VIN;
        }
    }else if (indexPath.section == 2){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXAddVehicleEngineAndColorViewCell_dis forIndexPath:indexPath];
         LXAddVehicleEngineAndColorViewCell *vCell = (LXAddVehicleEngineAndColorViewCell*)cell;
        if (self.isEdit) {
            vCell.colorStr = self.carDetatilModel.CarColor;
            vCell.EngineNo = self.carDetatilModel.EngineNo;
        }
    }else if(indexPath.section == 3){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXAddVehicleCollectionViewSelectCell_dis forIndexPath:indexPath];
        LXAddVehicleCollectionViewSelectCell *vCell = (LXAddVehicleCollectionViewSelectCell*)cell;
        vCell.strTitle = self.titleArray[indexPath.section];
        if (self.isEdit) {
            vCell.contentStr = self.carDetatilModel.CarTypeId == 0?@"请选择":kStringConvertNull(self.carModel_.CarCatalogName);
            vCell.isDefault = self.carDetatilModel.IsDefault;
        }else{
            vCell.contentStr = @"请选择";
        }
        LXWeakSelf(vCell)
        LXWeakSelf(self);
        [vCell didSelectTypeClick:^{
            HSDAutoSelectView *selectView = [HSDAutoSelectView instanceView];
            selectView.selectIndex = vCell.contentBtn.tag;
            
            selectView.dataArray = self.carModel.carTypeArray;
            [selectView showWithView:cell callBack:^(NSInteger selectedIndex, NSString *selectTitle) {
                [weakvCell.contentBtn setTitle:selectTitle forState:0];
                weakvCell.contentBtn.tag = selectedIndex;
                weakself.carTypeIndex = selectedIndex;
            }];
        }];
        [vCell didSelectSwitchClick:^(bool flag) {
//            NSString *msg = flag?@"打开":@"关闭";
//            [LXMessage showInfoMessage:msg];
        }];
    }else if(indexPath.section == 4){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXAddVehicleCollectionViewPhotoUpLoadCell_dis forIndexPath:indexPath];
        LXAddVehicleCollectionViewPhotoUpLoadCell *vCell = (LXAddVehicleCollectionViewPhotoUpLoadCell *)cell;
        [vCell.carFrontViewBtn sd_setImageWithURL:[NSURL URLWithString:KImage_Str(self.carDetatilModel.CarImage)] forState:0 placeholderImage:[UIImage imageNamed:@"carHead"]];
        [vCell.drivingLicenseBtn sd_setImageWithURL:[NSURL URLWithString:KImage_Str(self.carDetatilModel.DrivingLicence)] forState:0 placeholderImage:[UIImage imageNamed:@"DrivingLicense"]];
        LXWeakSelf(self);
        [vCell didSelectUpLoadPic:^(NSString *title) {
            //0是车头 1是行驶证
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
            imagePickerVc.cropRect = CGRectMake(0, 0, 320, 320*0.75);
            // 设置竖屏下的裁剪尺寸
            NSInteger left = 30;
            NSInteger widthHeight = weakself.view.width - 2 * left;
            NSInteger top = (weakself.view.height - widthHeight) / 2;
            imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight*0.7);
            imagePickerVc.allowCrop = YES;
            // You can get the photos by block, the same as by delegate.
            // 你可以通过block或者代理，来得到用户选择的照片.
            LXWeakSelf(self);
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) { 
                [LXMessage showActiveViewMessage:@"上传中" onView:weakself.view];
                
                if ([title isEqualToString:@"车头"]) {
                    [weakself upLoadPic:photos[0] isCarImg:YES];
                    vCell.carFrontViewImg = photos[0];
                }else{
                    [weakself upLoadPic:photos[0] isCarImg:NO];
                    vCell.drivingLicenseImg = photos[0];
                }
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
            
        }];
        
    }else{
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXAddVehicleCollectionViewCommitCell_dis
                                                         forIndexPath:indexPath];
       LXAddVehicleCollectionViewCommitCell *vCell = (LXAddVehicleCollectionViewCommitCell *)cell;
        LXWeakSelf(self)
        [vCell didSelectClick:^{
            if (weakself.cellArray &&weakself.cellArray.count >0) {
                LXAddVehicleCollectionViewCell *cell1 = [weakself.cellArray objectAtIndex:0];
                
                LXAddVehicleCollectionViewSecondCell *cell2 = [weakself.cellArray objectAtIndex:1];
                
                LXAddVehicleEngineAndColorViewCell *cell3 = [weakself.cellArray objectAtIndex:2];
                
                LXAddVehicleCollectionViewSelectCell *cell4 = [weakself.cellArray objectAtIndex:3];
                if ([LXCommon isValidateCarNumber:cell1.contentStr]) {
                    [LXMessage showErrorMessage:@"车牌格式不正确"];
                    return ;
                }else{
                    weakself.vehicleModel.CarNumber = [cell1.contentStr stringByReplacingOccurrencesOfString:@" " withString:@""];
                }
                if (![LXCommon isValidVinCode:cell2.contentStr]) {
                    [LXMessage showErrorMessage:@"车架号/VIN格式不正确"];
                    return ;
                }else{
                    weakself.vehicleModel.VIN = cell2.contentStr;
                }
                if (cell3.EngineNo.length == 0) {
                    [LXMessage showErrorMessage:@"发动机号不能为空"];
                    return ;
                }else{
                    weakself.vehicleModel.EngineNo = cell3.EngineNo;
                }
                if (cell3.colorStr.length == 0) {
                    [LXMessage showErrorMessage:@"车身颜色不能为空"];
                    return ;
                }else{
                    weakself.vehicleModel.CarColor = cell3.colorStr;
                }
                if (weakself.vehicleModel.CarImage == 0) {
                    [LXMessage showErrorMessage:@"请上传车头照片"];
                    return ;
                }
                if (weakself.vehicleModel.DrivingLicence.length == 0) {
                    [LXMessage showErrorMessage:@"请上传行驶证照片"];
                    return ;
                }
                weakself.vehicleModel.isDefault = cell4.isDefault;
                weakself.vehicleModel.carTypeName = cell4.contentStr;
                if ([cell4.contentStr isEqualToString:@"请选择"]) {
                    return ;
                }
                DLog(@"%@--%@--%@--%@--%@--%i---%@--%@",weakself.vehicleModel.CarNumber,weakself.vehicleModel.VIN,weakself.vehicleModel.CarColor,weakself.vehicleModel.EngineNo,weakself.vehicleModel.EngineNo,weakself.vehicleModel.isDefault,weakself.vehicleModel.CarImage,weakself.vehicleModel.DrivingLicence);
                if (self.isEdit) {
                    weakself.vehicleModel.CarId = 1001;
                }else{
                    weakself.vehicleModel.CarId = 0;
                }
                if (weakself.carTypeIndex != -1) {
                    self.carModel_ = [weakself.carModel.dataArray objectAtIndex:weakself.carTypeIndex];
                }
                weakself.vehicleModel.CarTypeId = weakself.carModel_.CarTypeId;
                [LXNetManager postRequestWithParamDictionary:[LXInterface postCarInfoAddCar:weakself.carId== 0?@"":kStringByInt(weakself.carId)
                                                                           isDefault:weakself.vehicleModel.isDefault
                                                                         MPCarTypeId:kStringByInt(weakself.vehicleModel.CarTypeId)
                                                                           CarTypeId:nil
                                                                        MPCarStateId:nil
                                                                          CarStateId:nil
                                                                           CarNumber:weakself.vehicleModel.CarNumber
                                                                                 VIN:weakself.vehicleModel.VIN
                                                                            EngineNo:weakself.vehicleModel.EngineNo
                                                                            CarImage:weakself.vehicleModel.CarImage
                                                                            CarColor:weakself.vehicleModel.CarColor
                                                                             AddTime:[NSDate date]
                                                                          UpdateTime:nil
                                                                          DeleteTime:nil
                                                                      DrivingLicence:weakself.vehicleModel.DrivingLicence
                                                                               Inuse:NO]
                                             finished:^(id responseObj) {
                                                 if (responseObj && [[responseObj objectForKey:@"state"] integerValue] > 0) {
                                                     [LXMessage showSuccessMessage:@"添加成功"];
                                                     LXWeakSelf(self);
                                                     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                         LXAddVehicleSucessViewController *VC = [LXAddVehicleSucessViewController new];
                                                         VC.isFormMain = weakself.isFormMain;
                                                         [weakself.navigationController pushViewController:VC  animated:YES];
                                                     });
                                                 }else{
                                                     [LXMessage showSuccessMessage:[responseObj objectForKey:@"msg"]];
                                                 }
                }
                                               failed:^(NSError *error) {
                                                   [LXMessage showErrorMessage:error.localizedDescription];
                                                   
                }];
                                      
            }
        }];
    }
    //[collectionView toTopAnimation];
    [self.cellArray addObject:cell];
    return cell;
}
- (NSMutableArray *)cellArray{
    if (!_cellArray) {
        _cellArray = [[NSMutableArray alloc] init];
    }
    return _cellArray;
}
- (void)upLoadPic:(UIImage *)image isCarImg:(BOOL)isCarImg{
    NSString *tempStr = [LXDate getNowTimeTimestamp];
    NSData *data = UIImagePNGRepresentation(image);
    LXWeakSelf(self);
    [LXNetManager postUploadImageWithUrlString:[[LXInterface postCarInfoUploadPic] objectForKey:@"url"]
                                        params:@[]
                                         image:data
                                        imgKey:tempStr
                                 finishedBlock:^(id responseObj) {
                                     [LXMessage hideActiveView];
                                     [LXMessage showSuccessMessage:[responseObj objectForKey:@"msg"]];
                                     if (responseObj && [responseObj objectForKey:@"data"] && isCarImg) {
                                         weakself.vehicleModel.CarImage = [responseObj objectForKey:@"data"];
                                     }else{
                                         weakself.vehicleModel.DrivingLicence = [responseObj objectForKey:@"data"];
                                     }
                                 }
                                   failedBlock:^(NSError *error) {
                                       [LXMessage hideActiveView];
                                       [LXMessage showErrorMessage:error.localizedDescription];
                                   }];
}
-  (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4) {
        return CGSizeMake(kWidth, 210 *k_height);
    }else if(indexPath.section == 5){
        return CGSizeMake(kWidth, 120*k_height);
    }else{
        return CGSizeMake(kWidth, 50*k_height);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
         return  UIEdgeInsetsMake(5, 0, 5, 0);
    }else if(section == 5){
         return  UIEdgeInsetsZero;
    }else if(section == 4){
        return  UIEdgeInsetsMake(5, 0, 0, 0);
    }else if(section == 0 ||section == 1 ||section == 2 ||section == 2 ){
        return  UIEdgeInsetsMake(0, 0, 1, 0);
    }else{
        return UIEdgeInsetsZero;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.titleArray.count;
}
- (void)dealloc{
    DLog(@"我是添加车辆");
}

/**
   获取所有车辆的类型
 */
- (void)loadCarTypeListData{
    LXWeakSelf(self);
    [LXNetManager getWithParamDictionary:[LXInterface postCarInfoCarTypeList]
                                finished:^(id responseObj) {
                                    [LXMessage hideActiveView];
                                    [_collectionView.mj_header endRefreshing];
                                    if ([responseObj objectForKey:@"data"] && responseObj) {
                                        if (!weakself.carModel) {
                                            weakself.carModel = [[LXAddCarTypeListDataModel alloc] init];
                                        }
                                        [weakself.carModel.dataArray removeAllObjects];
                                        [weakself.carModel setValuesForKeysWithDictionary:responseObj];
                                        
                                        [_collectionView reloadData];
                                    }
                                }
                                  failed:^(NSError *error) {
                                      [_collectionView.mj_header endRefreshing];
                                      [LXMessage show:error.localizedDescription onView:weakself.view autoHidden:YES];
                                      [LXMessage hideActiveView];
    }];
}

/**
   获取当辆车的信息
 */
- (void)getCarDetailById{
    [LXMessage showActiveViewOnView:self.view];
    LXWeakSelf(self);
    [[LXNetManager shareManager] getRequestWithUrlString:
     [[LXInterface postCarInfoCarType:kStringByInt(self.carId)] objectForKey:@"url"]
                                                finished:^(id responseObj) {
        [LXMessage hideActiveView];
        if (responseObj && [[responseObj objectForKey:@"state"] integerValue] >= 0) {
            self.carDetatilModel = [[LXCarDetatilModel alloc] initWithDictionary:[responseObj objectForKey:@"data"]];
            weakself.vehicleModel.CarImage = weakself.carDetatilModel.CarImage;
            weakself.vehicleModel.DrivingLicence = weakself.carDetatilModel.DrivingLicence;
            weakself.vehicleModel.CarTypeId = weakself.carDetatilModel.CarTypeId;
            for (LXCarType *carModel  in weakself.carModel.dataArray) {
                if (weakself.vehicleModel.CarTypeId == carModel.CarTypeId) {
                    weakself.carModel_ = carModel;
                }
            }
            [_collectionView reloadData];
        }
    } failed:^(NSError *error) {
        [LXMessage hideActiveView];
        [LXMessage showErrorMessage:error.localizedDescription];
    }];
}
@end
