//
//  LXAddVehicleCollectionViewPhotoUpLoadCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/24.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXAddVehicleCollectionViewPhotoUpLoadCell.h"

@implementation LXAddVehicleCollectionViewPhotoUpLoadCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.carFrontViewLabel];
    [self.contentView addSubview:self.drivingLicenseLabel];
    [self.contentView addSubview:self.carFrontViewBtn];
    [self.contentView addSubview:self.drivingLicenseBtn];
    [self.contentView addSubview:self.descriptLabel];
    //----------------配置----------------------------
    [self.carFrontViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kWidth*0.42);
        make.height.mas_equalTo(kWidth*0.42*0.69);
        make.top.equalTo(self).offset(15*k_height);
        make.left.equalTo(self).offset(20*k_width);
    }];
    [self.drivingLicenseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kWidth*0.42);
        make.height.mas_equalTo(kWidth*0.42*0.69);
        make.top.equalTo(self).offset(15*k_height);
        make.right.equalTo(self).offset(-20*k_width);
    }];
    [self.carFrontViewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carFrontViewBtn.mas_bottom).offset(5*k_height);
        make.centerX.equalTo(self.carFrontViewBtn);
    }];
    [self.drivingLicenseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.carFrontViewLabel);
        make.centerX.equalTo(self.drivingLicenseBtn);
    }];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-23*k_height);
        make.centerX.equalTo(self);
    }];
}
#pragma mark 懒加载
- (UIButton *)carFrontViewBtn{
    if (!_carFrontViewBtn) {
        _carFrontViewBtn =     [LXView createButtonWithFrame:CGRectZero
                                                title:@""
                                            imageName:@""
                                          bgImageName:@"carHead"
                                               radius:-1
                                               target:self
                                               action:@selector(carClick)
                                                color:nil];
        _carFrontViewBtn.tag = 0;
    }
    return _carFrontViewBtn;
}
- (void)carClick{
    if (_block) {
        _block(@"车头");
    }
}
- (void)DrivingClick{
    if (_block) {
        _block(@"行驶证");
    }
}
- (UIButton *)drivingLicenseBtn{
    if (!_drivingLicenseBtn) {
        _drivingLicenseBtn =     [LXView createButtonWithFrame:CGRectZero
                                                title:@""
                                            imageName:@"DrivingLicense"
                                          bgImageName:nil
                                               radius:-1
                                               target:self
                                               action:@selector(DrivingClick)
                                                color:nil];
        _descriptLabel.tag = 1;
    }
    return _drivingLicenseBtn;
}
- (UILabel *)carFrontViewLabel{
    if (!_carFrontViewLabel) {
        _carFrontViewLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"车头照片"
                                             TextAlign:center];
        _carFrontViewLabel.font = [UIFont systemFontOfSize:kfontValue(14)];
        _carFrontViewLabel.textColor = kRGBColor(135, 135, 135);
    }
    return _carFrontViewLabel;
}
- (UILabel *)drivingLicenseLabel{
    if (!_drivingLicenseLabel) {
        _drivingLicenseLabel =  [LXView createLabelWithFrame:CGRectZero
                                                      text:@"行驶证照片"
                                                 TextAlign:center];
        _drivingLicenseLabel.font = [UIFont systemFontOfSize:kfontValue(14)];
        _drivingLicenseLabel.textColor = kRGBColor(135, 135, 135);
    }
    return _drivingLicenseLabel;
}
- (UILabel *)descriptLabel{
    if (!_descriptLabel) {
        _descriptLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"请确保车头照片中车牌号及行驶证照片清晰，便于审核"
                                             TextAlign:center];
        _descriptLabel.textColor = kRGBColor(103, 103, 103);
        _descriptLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
    }
    return _descriptLabel;
}
- (void)didSelectUpLoadPic:(LXAddVehicleCollectionViewPhotoUpLoadCellBlock)block
{
    _block = block;
}
- (void)setDrivingLicenseImg:(UIImage *)drivingLicenseImg{
    [self.drivingLicenseBtn setImage:drivingLicenseImg  forState:0];
}
- (void)setCarFrontViewImg:(UIImage *)carFrontViewImg{
     [self.carFrontViewBtn setImage:carFrontViewImg forState:0];
}
@end
