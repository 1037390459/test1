//
//  LXMainBindPhoneView.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/28.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMainBindPhoneView.h"

@implementation LXMainBindPhoneView

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
    [self addSubview:self.bindPhoneBtn];
    [self addSubview:self.startBtn];
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(130*k_width*0.65);
        make.height.mas_equalTo(130*k_width);
        make.top.equalTo(self).offset(45*k_height);
        make.centerX.equalTo(self);
    }];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.logoImage.mas_bottom).offset(16*k_height);
    }];
    [self.bindPhoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(self.width*0.8);
        make.height.mas_equalTo(kCellHeight);
    }];
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.mas_equalTo(-42*k_height);
        make.width.height.mas_equalTo(150*k_height);
    }];
    //----------------重新布局-----------
    [self setStartbtn];
}
#pragma mark 懒加载
- (UIImageView *)logoImage{
    if (!_logoImage) {
        _logoImage =   [LXView createImageViewFrame:CGRectZero
                                          imageName:@"bindPhone"
                                        isUIEnabled:YES];
        [_logoImage setContentMode:UIViewContentModeScaleToFill]; 
    }
    return _logoImage;
}
- (UILabel *)descriptLabel{
    if (!_descriptLabel) {
        _descriptLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"“开始用车”前，请绑定手机号码"
                                             TextAlign:center]; 
        _descriptLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
    }
    return _descriptLabel;
}
- (UIButton *)bindPhoneBtn{
    if (!_bindPhoneBtn) {
        _bindPhoneBtn =     [LXView createButtonWithFrame:CGRectZero
                                                     title:@"绑定手机号码"
                                                   bgColor:[UIColor clearColor]
                                                    radius:kfontValue(25)
                                                    target:self
                                                   action:@selector(click:)];
        [_bindPhoneBtn setTitleColor:kRGBColor(63, 163, 89) forState:0];
        _bindPhoneBtn.borderColor = kRGBColor(63, 163, 89).CGColor;
        _bindPhoneBtn.borderWidth = 0.8;
        [_bindPhoneBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(15)]];
        _bindPhoneBtn.tag = LXBindPhoneenum;
    }
    return _bindPhoneBtn;
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
        _startBtn.tag = LXStartenum;
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
        case LXBindPhoneenum: {
            if ([self.delegate respondsToSelector:@selector(didSelectbindPhoneBtnClick)]) {
                [self.delegate didSelectbindPhoneBtnClick];
            }else{
                DLog(@"未实现代理");
            }
        }
            break;
        default:{
            if ([self.delegate respondsToSelector:@selector(didSelectStartBtnClick)]) {
                [self.delegate didSelectStartBtnClick];
            }else{
                DLog(@"未实现代理");
            }
        }
            break;
    }
}
@end
