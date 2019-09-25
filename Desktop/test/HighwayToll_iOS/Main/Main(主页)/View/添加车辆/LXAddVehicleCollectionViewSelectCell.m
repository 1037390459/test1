//
//  LXAddVehicleCollectionViewSelectCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/24.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXAddVehicleCollectionViewSelectCell.h"
@interface LXAddVehicleCollectionViewSelectCell()
@property (nonatomic,strong)  UILabel *titleLabel;         /**< title名称 */
@property (nonatomic,strong)  UILabel *line;               /**< 线 */
@property (nonatomic,strong)  UILabel *line2;              /**< 线 */
@property (nonatomic,strong)  UILabel *setDefaultLabel;    /**< 设置UI */
@property (nonatomic,strong)  UIImageView *logoImg;        /**< 内容文本框 */
@property (nonatomic,strong) UISwitch *setDefaultswitch; /**<  */
@end
@implementation LXAddVehicleCollectionViewSelectCell
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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.line2];
    [self.contentView addSubview:self.contentBtn];
    [self.contentView addSubview:self.setDefaultLabel];
    [self.contentView addSubview:self.setDefaultswitch];
    [self.contentView addSubview:self.logoImg];
    //----------------end------------------------
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.centerY.equalTo(self);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidth*0.25);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(self.height*0.55);
        make.width.mas_equalTo(0.55);
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line.mas_right).offset(kWidth*0.25);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(self.height*0.55);
        make.width.mas_equalTo(0.55);
    }];
    [self.setDefaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line2).offset(18*k_width);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(kWidth*0.25);
    }];
    [self.setDefaultswitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15*k_width);
        make.centerY.equalTo(self);
    }];
    [self.contentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line.mas_right).offset(13*k_width);
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15*k_width);
    }];
    [self.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentBtn);
        make.right.equalTo(self.line2).offset(-15*k_width);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(20);
    }];
    //
    [self layoutIfNeeded];
    self.setDefaultswitch.transform = CGAffineTransformMakeScale(0.8, 0.8);
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =  [LXView createLabelWithFrame:CGRectZero
                                               text:@"拥有人"
                                          TextAlign:center];
        _titleLabel.font = [UIFont systemFontOfSize:kfontValue(14)];
    }
    return _titleLabel;
}
- (UILabel *)setDefaultLabel{
    if (!_setDefaultLabel) {
        _setDefaultLabel =  [LXView createLabelWithFrame:CGRectZero
                                               text:@"设为默认人"
                                          TextAlign:left];
        _setDefaultLabel.font = [UIFont systemFontOfSize:kfontValue(14)];
    }
    return _setDefaultLabel;
}
- (UIImageView *)logoImg{
    if (!_logoImg) {
        _logoImg =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"bottom"
                                      isUIEnabled:YES];
    }
    return _logoImg;
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
- (UILabel *)line2{
    if (!_line2) {
        _line2 =  [LXView createLabelWithFrame:CGRectZero
                                         text:@""
                                    TextAlign:center];
        _line2.backgroundColor = kRGBColor(135, 135, 135);
    }
    return _line2;
}
- (UISwitch *)setDefaultswitch{
    if (!_setDefaultswitch) {
        _setDefaultswitch =  [[UISwitch alloc] init];
        [_setDefaultswitch addTarget:self action:@selector(click:) forControlEvents:UIControlEventValueChanged];
    }
    return _setDefaultswitch;
}
- (void)click:(UISwitch *)sender{
    if (_switchBlock) {
        _switchBlock(sender.isOn);
    }
}
- (void)didSelectSwitchClick:(LXAddVehicleCollectionViewSwitchClickBlock)block{
    _switchBlock = block;
}
- (UIButton *)contentBtn{
    if (!_contentBtn) {
        _contentBtn =     [LXView createButtonWithFrame:CGRectZero
                                                title:@"轿车"
                                            imageName:nil
                                          bgImageName:nil
                                               radius:-1
                                               target:self
                                               action:@selector(click)
                                                color:nil]; 
        _contentBtn.titleLabel.font = [UIFont systemFontOfSize:kfontValue(14)];
        [_contentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _contentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _contentBtn;
}

- (void)click{
    if (_block) {
        _block();
    }
}
- (void)setStrTitle:(NSString *)strTitle{
    self.titleLabel.text = strTitle;
}
- (void)setContentStr:(NSString *)contentStr{
    [self.contentBtn setTitle:contentStr forState:UIControlStateNormal] ;
}
- (void)didSelectTypeClick:(LXAddVehicleCollectionViewSelectCellBlock)block{
    _block = block;
}
- (BOOL)isDefault{
    return self.setDefaultswitch.isOn;
}
- (void)setIsDefault:(bool)isDefault{
    self.setDefaultswitch.on = isDefault;
}
- (NSString *)contentStr{
    return self.contentBtn.titleLabel.text;
}
@end
