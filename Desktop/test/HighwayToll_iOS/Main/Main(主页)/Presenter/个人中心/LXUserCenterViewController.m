//
//  LXUserCenterViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/28.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXUserCenterViewController.h"
#import "LXUserCenterUserNameCell.h"
#import "LXUserCenterLabelCell.h"
#import "LXUserCenterDUpLoadriversLicenseViewController.h" //**<驾驶证*/
#import "LXUserCenterUpdateUserNameController.h"           //*<修改昵称*/
#import "LXInterface+UserCenter.h"
#import "TZImagePickerController.h"
#import <UIButton+WebCache.h>
@interface LXUserCenterViewController ()
@property (nonatomic,strong) NSMutableArray *titleArray;          /**<  名字数组*/ 
@end
static NSString*const KLXUserCenterLabelCell_dis   = @"KLXUserCenterLabelCell_dis";
static NSString*const KLXUserCenterUserNameCell_dis = @"KLXUserCenterUserNameCell_dis_dis";

@implementation LXUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

/**
   配置UI
 */
- (void)configUI{
    self.titleArray = [NSMutableArray arrayWithObjects:@"姓名",@"手机号码",@"驾驶证号",@"电子邮箱",@"微信",@"驾驶证", nil];
    self.title = @"个人中心";
    CGFloat hight =  kNavHeight;
    [self configCollectionViewWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight - hight )
                              LineSpace:5
                                 vSpace:1
                       scrollDirecation:UICollectionViewScrollDirectionVertical
                              isRefresh:NO]; 
    [_collectionView registerClass:[LXUserCenterLabelCell class]
        forCellWithReuseIdentifier:KLXUserCenterLabelCell_dis];
    [_collectionView registerClass:[LXUserCenterUserNameCell class]
        forCellWithReuseIdentifier:KLXUserCenterUserNameCell_dis];
}
#pragma mark collectionCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LXUserCenterUserNameCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXUserCenterUserNameCell_dis forIndexPath:indexPath];
        
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KimageUrl,KUserDefault_Get(@"AvatorImage")]] forState:0];
        LXWeakSelf(self);
        LXWeakSelf(cell);
        [cell UpLoadPic:^{
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
            imagePickerVc.cropRect = CGRectMake(0, 0, 320, 320*0.75);
            // 设置竖屏下的裁剪尺寸
            NSInteger left = 30;
            NSInteger widthHeight = weakself.view.width - 2 * left;
            NSInteger top = (weakself.view.height - widthHeight) / 2;
            imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
            imagePickerVc.allowCrop = YES;
            imagePickerVc.needCircleCrop = YES;
            // You can get the photos by block, the same as by delegate.
            // 你可以通过block或者代理，来得到用户选择的照片.
            LXWeakSelf(self);
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                UIImage *img = photos[0];
                [weakcell.headImage setBackgroundImage:img forState:0];
                [weakself upLoadPic:img];
            }];
            [weakself presentViewController:imagePickerVc animated:YES completion:nil];
        }];
        return cell;
    }else{
         LXUserCenterLabelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXUserCenterLabelCell_dis forIndexPath:indexPath];
         cell.titleStr = self.titleArray[indexPath.section-1];
        if ([self.titleArray[indexPath.section-1] isEqualToString:@"微信"]) {
            cell.isShowWechat = YES;
        }
        if (indexPath.section == 1) {
            cell.contentStr = [LXUserInfoModel shareUser].RealName;
        }else if (indexPath.section == 2) {
            cell.contentStr = [LXUserInfoModel shareUser].Phone;
            
        }else if (indexPath.section == 3) {
            cell.contentStr = [LXUserInfoModel shareUser].DriversLicenseNumber;
        }else if (indexPath.section == 4) {
            cell.contentStr = [LXUserInfoModel shareUser].Email;
        }else if (indexPath.section == 6) {
             cell.contentStr = [LXUserInfoModel shareUser].DriverStateName;
        }else if (indexPath.section == 5) {
            cell.contentStr = @"";
        }
         return cell;
    }
   
}
-  (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0)
        return CGSizeMake(kWidth, 98);
        return CGSizeMake(kWidth, kCellHeight);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0)
    return  UIEdgeInsetsZero;
    return  UIEdgeInsetsMake(0, 0, 1, 0);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 7;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 6) {
        [self.navigationController pushViewController: [LXUserCenterDUpLoadriversLicenseViewController  new] animated:YES];
    }else if (indexPath.section == 1) {
        LXUserCenterUpdateUserNameController *VC = [LXUserCenterUpdateUserNameController new];
        VC.userEnum = LXUserCenterEnumRealName;
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.section == 2) {
        LXUserCenterUpdateUserNameController *VC = [LXUserCenterUpdateUserNameController new];
        VC.userEnum = LXUserCenterEnumPhone;
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.section == 3) {
        LXUserCenterUpdateUserNameController *VC = [LXUserCenterUpdateUserNameController new];
        VC.userEnum = LXUserCenterEnumDriversLicenseNumber;
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.section == 4) {
        LXUserCenterUpdateUserNameController *VC = [LXUserCenterUpdateUserNameController new];
        VC.userEnum = LXUserCenterEnumEmail;
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.section == 5) {
        [LXMessage showInfoMessage:@"攻城狮正在拼命开发中~"];
    }
}
- (void)upLoadPic:(UIImage *)image {
    NSString *tempStr = [LXDate getNowTimeTimestamp];
    NSData *data = UIImagePNGRepresentation(image);
    [LXMessage showActiveViewOnView:self.view];
    LXWeakSelf(self);
    [LXNetManager postUploadImageWithUrlString:[[LXInterface postUserCenterUploadPic] objectForKey:@"url"]
                                        params:@[]
                                         image:data
                                        imgKey:tempStr
                                 finishedBlock:^(id responseObj) {
                                     [LXMessage hideActiveView];
                                     
                                     if (responseObj && [responseObj objectForKey:@"data"]  ) {
                                         KUserDefault_Set([responseObj objectForKey:@"data"], @"AvatorImage");
                                         [weakself modifyUserCenter];
                                     }else{
                                         [LXMessage showSuccessMessage:[responseObj objectForKey:@"msg"]];
                                     }
                                 }
                                   failedBlock:^(NSError *error) {
                                       [LXMessage hideActiveView];
                                       [LXMessage showErrorMessage:error.localizedDescription];
                                   }];
}

/**
   修改头像
 */
- (void)modifyUserCenter{
    [LXNetManager postRequestWithUrlString:[NSString stringWithFormat:@"%@?field=AvatorImage&content=%@",kLXHttpPostUrl(@"api/DriverInfo/UpdateDrive"),KUserDefault_Get(@"AvatorImage")]
                                    params:@[]
                                  finished:^(id responseObj) {
                                      if (responseObj && [[responseObj objectForKey:@"state"] integerValue] >= 0) {
                                          [LXMessage showInfoMessage:@"头像修改成功"];
                                      }
                                  }
                                    failed:^(NSError *error) {
                                        [LXMessage showErrorMessage:error.localizedDescription];
                                    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_collectionView reloadData];
}
@end
