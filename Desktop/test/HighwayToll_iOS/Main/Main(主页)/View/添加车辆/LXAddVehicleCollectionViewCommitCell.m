//
//  LXAddVehicleCollectionViewCommitCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/24.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXAddVehicleCollectionViewCommitCell.h"

@implementation LXAddVehicleCollectionViewCommitCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI{
    [self.contentView addSubview:self.loginBtn];
    [self.contentView addSubview:self.descriptLabel];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10*k_height);
        make.width.mas_equalTo(kWidth*0.8);
        make.height.mas_equalTo(44*k_height);
        make.centerX.equalTo(self);
    }];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.loginBtn);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(14*k_width);
    }];
}
#pragma mark 懒加载
- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn =     [LXView createButtonWithFrame:CGRectZero
                                                title:@"确定提交"
                                              bgColor:kRGBColor(56, 158, 61)
                                               radius:kfontValue(23)
                                               target:self
                                               action:@selector(loginClick)];
        [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(17)]];
        _loginBtn.titleLabel.textColor = [UIColor whiteColor];
    }
    return _loginBtn;
}
- (void)loginClick{
    if (_block) {
        _block();
    }
}
- (UILabel *)descriptLabel{
    if (!_descriptLabel) {
        _descriptLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"为确保您的资金及信息安全，请务必正确填写车辆信息\n您的信息仅用于高速费用支付，将会严格保密放心填写"
                                             TextAlign:center];
        _descriptLabel.numberOfLines = 0;
        [_descriptLabel setFont:[UIFont systemFontOfSize:kfontValue(13)]];
        _descriptLabel.textColor = kRGBColor(103, 103, 103);
    }
    return _descriptLabel;
}
- (void)didSelectClick:(LXAddVehicleCollectionViewCommitCellBlock )block{
    _block = block;
}
@end
