//
//  LXMainAddVehicleView.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/28.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMainAddVehicleView.h"

@implementation LXMainAddVehicleView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI{
    [self addSubview:self.logoImage];
    [self addSubview:self.descriptLabel];
    [self addSubview:self.addVehicleBtn];
    [self addSubview:self.borrowCarBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.startBtn];
    //------------我是分割线--------------
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(88*k_height);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(158*k_width);
        make.height.mas_equalTo(73*k_width);
    }];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.logoImage.mas_bottom).offset(6*k_height);
    }];
    [self.addVehicleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.descriptLabel.mas_bottom).offset(52*k_height);
        make.width.mas_equalTo(kWidth*0.8);
        make.height.mas_equalTo(kCellHeight);
    }];
    [self.borrowCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.addVehicleBtn.mas_bottom).offset(25*k_height);
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.borrowCarBtn.mas_right).offset(3);
        make.centerY.equalTo(self.borrowCarBtn);
        make.width.mas_equalTo(11);
        make.height.mas_equalTo(13);
    }];
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.mas_equalTo(-42*k_height);
        make.width.height.mas_equalTo(150*k_height);
    }];
    [self setStartbtn];
}
#pragma mark 懒加载
- (UILabel *)descriptLabel{
    if (!_descriptLabel) {
        _descriptLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"请添加您拥有的车辆"
                                             TextAlign:center];
        _descriptLabel.textColor = kRGBColor(211, 211, 211);
        _descriptLabel.font = [UIFont systemFontOfSize:kfontValue(15)];
    }
    return _descriptLabel;
}
- (UIImageView *)logoImage{
    if (!_logoImage) {
        _logoImage =   [LXView createImageViewFrame:CGRectZero
                                          imageName:@"myCar"
                                        isUIEnabled:YES];
    }
    return _logoImage;
}
- (UIButton *)addVehicleBtn{
    if (!_addVehicleBtn) {
        _addVehicleBtn =     [LXView createButtonWithFrame:CGRectZero
                                                     title:@"添加车辆"
                                                   bgColor:[UIColor clearColor]
                                                    radius:kfontValue(25)
                                                    target:self
                                                    action:@selector(click:)];
        [_addVehicleBtn setTitleColor:kRGBColor(63, 163, 89) forState:0];
        _addVehicleBtn.borderColor = kRGBColor(63, 163, 89).CGColor;
        _addVehicleBtn.borderWidth = 0.8;
        [_addVehicleBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(15)]];
        _addVehicleBtn.tag = LXAddVehicle;
    }
    return _addVehicleBtn;
}
- (UIButton *)borrowCarBtn{
    if (!_borrowCarBtn) {
        _borrowCarBtn =     [LXView createButtonWithFrame:CGRectZero
                                                    title:@"没有车，借呗"
                                                  bgColor:[UIColor clearColor]
                                                   radius:-1
                                                   target:self
                                                   action:@selector(click:)];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"没有车，借呗"];
        NSRange strRange = {0,[str length]};
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        [_borrowCarBtn setAttributedTitle:str forState:UIControlStateNormal];
        [[_borrowCarBtn titleLabel] setFont:[UIFont systemFontOfSize:kfontValue(13)]];
        _borrowCarBtn.tag = LXBorrowCar;
    }
    return _borrowCarBtn;
}
- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn =     [LXView createButtonWithFrame:CGRectZero
                                                title:@""
                                            imageName:nil
                                          bgImageName:@"right"
                                               radius:-1
                                               target:self
                                               action:@selector(click:)
                                                color:nil];
        _rightBtn.tag = LXBorrowCar;
        
    }
    return _rightBtn;
}
- (UIButton *)startBtn{
    if (!_startBtn) {
        _startBtn =     [LXView createButtonWithFrame:CGRectZero
                                                title:@""
                                              bgColor:[UIColor clearColor]
                                               radius:_startBtn.width
                                               target:self
                                               action:@selector(click:)];
        [_startBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(23)]];
        [_startBtn setBackgroundImage:[UIImage imageNamed:@"btnBackground"] forState:0];
        _startBtn.tag = LXStartBtn;
    }
    return _startBtn;
}

/**
 配置UI
 */
- (void)setStartbtn{
    [self layoutIfNeeded];
    [self.startBtn.layer setCornerRadius:self.startBtn.width/2];
    [self.startBtn.layer setShadowColor:kRGBColor(135, 135, 135).CGColor];
    [self.startBtn.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.startBtn.layer setShadowOpacity:1];
}
- (void)click:(UIButton *)sender{
    switch (sender.tag) {
        case LXAddVehicle: {
            if ([self.delegate respondsToSelector:@selector(didSelectAddVehicleClick)]) {
                [self.delegate didSelectAddVehicleClick];
            }else{
                DLog(@"未实现代理");
            }
        }
            break;
        case LXStartBtn:
        {
            if ([self.delegate respondsToSelector:@selector(didSelectStartBtnClick)]) {
                [self.delegate didSelectStartBtnClick];
            }else{
                DLog(@"未实现代理");
            }
        }
            break;
        default:{
            if ([self.delegate respondsToSelector:@selector(didSelectBorrowCarClick)]) {
                [self.delegate didSelectBorrowCarClick];
            }else{
                DLog(@"未实现代理");
            }
        }
            break;
    }
}
@end
