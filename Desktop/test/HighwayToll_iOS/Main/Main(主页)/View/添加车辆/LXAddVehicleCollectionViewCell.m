//
//  LXAddVehicleCollectionViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/24.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXAddVehicleCollectionViewCell.h"
@interface LXAddVehicleCollectionViewCell()
@property (nonatomic,strong) UILabel *line;                  /**< 线 */
@property (nonatomic,strong) UITextField *textField;         /**< 文本框 */
@property (nonatomic,strong)  UIImageView *logoImg;          /**< 内容文本框 */
@end;
@implementation LXAddVehicleCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

/**
   配置UI
 */
- (void)configUI{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.titleBtn];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.logoImg];
    //-----------------配置-------------------
    [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.width.mas_equalTo(kWidth *0.26);
        make.centerY.equalTo(self);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoImg.mas_right).offset(12*k_width);
        make.width.mas_equalTo(0.55);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(self.height*0.55);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line.mas_right).offset(15*k_width);
        make.right.equalTo(self).offset(-15*k_width);
        make.centerY.equalTo(self);
    }];
    [self.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleBtn);
        make.left.equalTo(self.titleBtn.mas_right).offset(-11*k_width);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(20);
    }];
}
#pragma mark 懒加载
- (UIButton *)titleBtn{
    if (!_titleBtn) {
        _titleBtn =     [LXView createButtonWithFrame:CGRectZero
                                                title:@"车牌号码   沪"
                                            imageName:nil
                                          bgImageName:nil
                                               radius:-1
                                               target:self
                                               action:@selector(click)
                                                color:nil];
        _titleBtn.titleLabel.font = [UIFont systemFontOfSize:kfontValue(14)];
        [_titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_titleBtn.titleLabel setAdjustsFontSizeToFitWidth:YES];
        _titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _titleBtn;
}
- (void)click{
    if (_block) {
        _block();
    }
}
- (UITextField *)textField{
    if (!_textField) {
        _textField =  [LXView createTextFieldWithFrame:CGRectZero
                                           placeholder:@"请输入车牌号码"
                                           bgImageName:nil
                                              leftView:nil
                                             rightView:nil
                                            isPassWord:NO
                                              delegate:self];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.font = [UIFont systemFontOfSize:kfontValue(15)];
    }
    return _textField;
}
- (UILabel *)line{
    if (!_line) {
        _line =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@""
                                             TextAlign:center];
        _line.backgroundColor = kRGBColor(135, 135, 135);
    }
    return _line;
}
- (void)setStrTitle:(NSString *)strTitle{
    [self.titleBtn setTitle:strTitle forState:UIControlStateNormal];
}
- (void)setContentStr:(NSString *)contentStr{
    self.textField.text = contentStr;
}
- (UIImageView *)logoImg{
    if (!_logoImg) {
        _logoImg =   [LXView createImageViewFrame:CGRectZero
                                        imageName:@"bottom"
                                      isUIEnabled:YES];
    }
    return _logoImg;
}
- (void)didSelectTypeClick:(LXAddVehicleCollectionViewCellBlock)block{
    _block = block;
}

- (NSString *)contentStr{
    return [NSString stringWithFormat:@"%@%@",[self.titleBtn.titleLabel.text stringByReplacingOccurrencesOfString:@"车牌号码   " withString:@""],self.textField.text];
}
@end
