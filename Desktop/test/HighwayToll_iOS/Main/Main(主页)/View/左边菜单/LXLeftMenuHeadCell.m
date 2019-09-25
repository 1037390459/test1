//
//  LXLeftMenuHeadCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXLeftMenuHeadCell.h"
@interface LXLeftMenuHeadCell ()
@property (nonatomic,strong) UIButton *leftBtn;                     /**< 左边按钮 */
@property (nonatomic,strong) UILabel *phoneLabel;                   /**< 电话号码 */
@property (nonatomic,strong) UILabel *line;                         /**< 线 */
@property (nonatomic,strong) UILabel *moneyLabel;                   /**< 钱包余额 */
@property (nonatomic,strong) UILabel *moneyNumberLabel;             /**< 钱包余额 */
@property (nonatomic,strong) UIImageView *bgimg;                    /**< 背景图片 */
@end
@implementation LXLeftMenuHeadCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
/**
  配置UI

 @return
 */
}
- (void)configUI{
    [self.contentView addSubview:self.bgimg];
    [self.contentView addSubview:self.leftBtn];
    [self.contentView addSubview:self.headPortraitBtn];
    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.leftBtn];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.moneyLabel];
    [self.contentView addSubview:self.moneyNumberLabel];
    [self setBackgroundColor:[UIColor whiteColor]];
    //-------------------------------------------------
    [self.bgimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(self.height *0.95);
    }];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(22*k_width);
        make.width.mas_equalTo(13);
        CGFloat height = IPHONE_X?20:20;
        make.top.equalTo(self).offset(20+height);
        make.height.mas_equalTo(height+18);
    }];
    [self.headPortraitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(40*k_width);
        make.top.equalTo(self).offset(100*k_height);
        make.width.height.mas_equalTo(95*k_height);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(self.headPortraitBtn);
        make.top.equalTo(self.headPortraitBtn.mas_bottom).offset(17*k_height);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.6);
        make.width.equalTo(self.phoneLabel);
        make.left.equalTo(self.phoneLabel);
        make.top.equalTo(self.phoneLabel.mas_bottom).offset(13*k_height);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom).offset(25*k_width);
        make.left.equalTo(self.line);
    }];
    [self.moneyNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line);
        make.top.equalTo(self.moneyLabel.mas_bottom).offset(10*k_height);
    }]; //0.55
}
#pragma mark 懒加载
- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn =     [LXView createButtonWithFrame:CGRectZero
                                               title:@""
                                           imageName:@"backwhite"
                                         bgImageName:nil
                                              radius:-1
                                              target:self
                                              action:@selector(click)
                                               color:nil];
        
    }
    return _leftBtn;
}
- (void)click{
    if (_block) {
        _block();
    }
}
- (void)didSelectBack:(LXLeftMenuHeadCellBlock)block{
    _block = block;
}
- (UIButton *)headPortraitBtn{
    if (!_headPortraitBtn) {
        _headPortraitBtn =     [LXView createButtonWithFrame:CGRectZero
                                                title:@""
                                            imageName:@""
                                          bgImageName:@"default"
                                               radius:-1
                                               target:self
                                               action:@selector(headPortRailClick)
                                                color:nil];
    }
    return _headPortraitBtn;
}
- (void)headPortRailClick{
    if (_headPortraitblock) {
        _headPortraitblock();
    }
}
- (void)didSelectHeadPortrailBack:(LXLeftMenuHeadPortraitCellBlock)block{
    _headPortraitblock = block;
}
- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"15888881299"
                                             TextAlign:center];
        _phoneLabel.textColor = [UIColor whiteColor];
        _phoneLabel.adjustsFontSizeToFitWidth = YES;
        _phoneLabel.numberOfLines = 1;
    }
    return _phoneLabel;
}
- (UIImageView *)bgimg{
    if (!_bgimg) {
        _bgimg =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"leftlogo"
                                    isUIEnabled:YES];
    }
    return _bgimg;
}
- (UILabel *)line{
    if (!_line) {
        _line =  [LXView createLabelWithFrame:CGRectZero
                                               text:@""
                                          TextAlign:center];
        [_line setBackgroundColor:kRGBColor(242, 242, 242)];
    }
    return _line;
}
- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel =  [LXView createLabelWithFrame:CGRectZero
                                               text:@"钱包余额"
                                          TextAlign:center];
        _moneyLabel.font = [UIFont systemFontOfSize:kfontValue(14)];
        _moneyLabel.textColor = [UIColor whiteColor];
    }
    return _moneyLabel;
}
- (UILabel *)moneyNumberLabel{
    if (!_moneyNumberLabel) {
        _moneyNumberLabel =  [LXView createLabelWithFrame:CGRectZero
                                               text:@"￥200.00"
                                                TextAlign:center];
        _moneyNumberLabel.textColor = [UIColor whiteColor];
        _moneyNumberLabel.font = [UIFont systemFontOfSize:kfontValue(11)];
        
    }
    return _moneyNumberLabel;
}
- (void)setMoneyStr:(NSString *)moneyStr{
    
    [self setMoneyAttr:[NSString stringWithFormat:@"￥%@",moneyStr] label:self.moneyNumberLabel money:moneyStr];
}
- (void)setMoneyAttr:(NSString *)contentStr label:(UILabel *)label money:(NSString *)money{
    label.text = contentStr;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSString *strLabel= [money substringWithRange:NSMakeRange([money rangeOfString:@"."].location, 3)];
    money = [money stringByReplacingOccurrencesOfString:strLabel withString:@""];
    [str addAttribute:NSFontAttributeName
                value:[UIFont systemFontOfSize:kfontValue(18) weight:0.3]
                range:[str.string rangeOfString:money]];
    label.attributedText = str;
}
- (void)setUserNameStr:(NSString *)userNameStr{
    self.phoneLabel.text = userNameStr;
}
@end
