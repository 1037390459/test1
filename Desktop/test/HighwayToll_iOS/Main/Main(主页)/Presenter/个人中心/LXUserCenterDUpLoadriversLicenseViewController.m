//
//  LXUserCenterDUpLoadriver'sLicenseViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/1.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXUserCenterDUpLoadriversLicenseViewController.h"
#import "LXInterface+UserCenter.h"
#import "TZImagePickerController.h"
#import <UIButton+WebCache.h>
@interface LXUserCenterDUpLoadriversLicenseViewController ()<TZImagePickerControllerDelegate>
@property (nonatomic,strong) UIButton *upLoadBtn;           /**< 上传驾驶证 */
@property (nonatomic,strong) UILabel *descrioptLabel;       /**< 描述 */
@property (nonatomic,strong) UIButton *commitBtn;           /**< 提交 */
@end

@implementation LXUserCenterDUpLoadriversLicenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}
- (void)configUI{
    self.title = @"上传驾驶证";
    [self.view addSubview:self.commitBtn];
    [self.view addSubview:self.descrioptLabel];
    [self.view addSubview:self.upLoadBtn];
    //-------------配置--------------------
    [self.upLoadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavHeight+20);
        make.width.mas_equalTo(kWidth *0.86);
        make.height.mas_equalTo(kWidth *0.86*0.69);
         make.centerX.equalTo(self.view);
    }];
    [self.descrioptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.upLoadBtn.mas_bottom).offset(22*k_width);
        make.centerX.equalTo(self.view);
    }];
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kWidth*0.75);
        make.height.mas_equalTo(kCellHeight);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.descrioptLabel.mas_bottom).offset(36*k_height);
    }];
    [self.upLoadBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KimageUrl,KUserDefault_Get(@"DriversLicenseImage")]] forState:0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UILabel *)descrioptLabel{
    if (!_descrioptLabel) {
        _descrioptLabel =  [LXView createLabelWithFrame:CGRectZero
                                                 text:@"注意：上传驾驶证并审核后，姓名和驾驶证不可修改"
                                            TextAlign:center];
        _descrioptLabel.textColor = kRGBColor(135, 135, 135);
        _descrioptLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
        
    }
    return _descrioptLabel;
}
- (UIButton *)upLoadBtn{
    if (!_upLoadBtn) {
        _upLoadBtn =     [LXView createButtonWithFrame:CGRectZero
                                                title:@""
                                            imageName:@""
                                          bgImageName:@"upload"
                                               radius:-1
                                               target:self
                                               action:@selector(click)
                                                color:nil];
        
    }
    return _upLoadBtn;
}
- (void)click{
    //0是车头 1是行驶证
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVc.cropRect = CGRectMake(0, 0, 320, 320*0.75);
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = self.view.width - 2 * left;
    NSInteger top = (self.view.height - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight*0.7);
    imagePickerVc.allowCrop = YES;
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    LXWeakSelf(self);
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        UIImage *img = photos[0];
        [weakself upLoadPic:img isCarImg:YES];
        self.upLoadBtn.imageView.image = img;
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
  
}
- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [LXView createButtonWithFrame:CGRectZero
                                             title:@"上传"
                                           bgColor:kRGBColor(56, 158, 61)
                                            radius:kfontValue(25)
                                            target:self
                                            action:@selector(commitBtnClick)];
        [_commitBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(18)]];
        _commitBtn.titleLabel.textColor = [UIColor whiteColor];
        _commitBtn.tag = 1;
    }
    return _commitBtn;
}
- (void)commitBtnClick{
    
}
- (void)upLoadPic:(UIImage *)image isCarImg:(BOOL)isCarImg{
    NSString *tempStr = [LXDate getNowTimeTimestamp];
    NSData *data = UIImagePNGRepresentation(image);
    LXWeakSelf(self);
    [LXMessage showActiveViewOnView:self.view];
    [LXNetManager postUploadImageWithUrlString:[[LXInterface postUserCenterUploadPic] objectForKey:@"url"]
                                        params:@[]
                                         image:data
                                        imgKey:tempStr
                                 finishedBlock:^(id responseObj) {
                                     [LXMessage hideActiveView];
                                     if (responseObj && [responseObj objectForKey:@"data"]  ) {
                                         KUserDefault_Set([responseObj objectForKey:@"data"], @"DriversLicenseImage");
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
    [LXNetManager postRequestWithUrlString:[NSString stringWithFormat:@"%@?field=DriversLicenseImage&content=%@",kLXHttpPostUrl(@"api/DriverInfo/UpdateDrive"),KUserDefault_Get(@"DriversLicenseImage")]
                                    params:@[]
                                  finished:^(id responseObj) {
                                      if (responseObj && [[responseObj objectForKey:@"state"] integerValue] >= 0) {
                                          [LXMessage showInfoMessage:@"驾驶证上传成功"];
                                      }
                                  }
                                    failed:^(NSError *error) {
                                        [LXMessage showErrorMessage:error.localizedDescription];
                                    }];
}
@end
