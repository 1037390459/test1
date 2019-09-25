//
//  LXMyWalletCollectionViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyWalletCollectionView.h"
@interface LXMyWalletCollectionView()
@property (nonatomic,strong) UIImageView *logoImage;                     /**< 标志 */
@property (nonatomic,strong) UILabel *descriptLabel;                     /**< 标志 */
@property (nonatomic,strong) UILabel *moneyLabel;                        /**< 金额 */
@property (nonatomic,strong) UIButton *transactionBtn;                   /**< 交易*/
@property (nonatomic,strong) UIButton *transactionDescriptBtn;           /**< 交易明细*/
@end
@implementation LXMyWalletCollectionView
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
    [self addSubview:self.moneyLabel];
    [self addSubview:self.transactionBtn];
    [self addSubview:self.transactionDescriptBtn];
    //-------------------------------------------------------------------
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
         make.width.mas_equalTo(125*k_width);
         make.height.mas_equalTo(95*k_width);
         make.centerX.equalTo(self);
         make.top.equalTo(self).offset(75*k_height);
    }];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.logoImage.mas_bottom).offset(12*k_height);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.descriptLabel.mas_bottom).offset(20*k_height);
    }];
    [self.transactionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kWidth*0.75);
        make.height.mas_equalTo(kCellHeight);
        make.centerX.equalTo(self);
        make.top.equalTo(self.moneyLabel.mas_bottom).offset(55*k_height);
    }];
    [self.transactionDescriptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerX.equalTo(self.transactionBtn);
        make.top.equalTo(self.transactionBtn.mas_bottom).offset(15*k_height);
    }];
}
#pragma mark 懒加载
- (UIImageView *)logoImage{
    if (!_logoImage) {
        _logoImage =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"wallet"
                                        isUIEnabled:YES];
    }
    return _logoImage;
}
- (UILabel *)descriptLabel{
    if (!_descriptLabel) {
        _descriptLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"余额（元）"
                                             TextAlign:center];
        _descriptLabel.textColor = kRGBColor(135, 135, 135);
        _descriptLabel.font = [UIFont systemFontOfSize:kfontValue(15)];
    }
    return _descriptLabel;
}
- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"1200.40"
                                             TextAlign:center];
        _moneyLabel.font = [UIFont systemFontOfSize:kfontValue(18)];
        
    }
    return _moneyLabel;
}
//---------- 按钮-------------
- (UIButton *)transactionBtn{
    if (!_transactionBtn) {
        _transactionBtn =     [LXView createButtonWithFrame:CGRectZero
                                                 title:@"充值"
                                               bgColor:kRGBColor(56, 158, 61)
                                                radius:kfontValue(25)
                                                target:self
                                                     action:@selector(commitBtnClick:)];
        [_transactionBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(18)]];
        _transactionBtn.titleLabel.textColor = [UIColor whiteColor];
        _transactionBtn.tag = 1;
    }
    return _transactionBtn;
}
- (UIButton *)transactionDescriptBtn{
    if (!_transactionDescriptBtn) {
        _transactionDescriptBtn =     [LXView createButtonWithFrame:CGRectZero
                                                      title:@"交易明细"
                                                    bgColor:kRGBColor(255, 255, 255)
                                                     radius:kfontValue(25)
                                                     target:self
                                                             action:@selector(commitBtnClick:)];
        [_transactionDescriptBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(18)]];
        [_transactionDescriptBtn setTitleColor:kRGBColor(56, 158, 61) forState:0];
        _transactionDescriptBtn.borderWidth = 0.8;
        _transactionDescriptBtn.borderColor = kRGBColor(56, 158, 61).CGColor;
       
    }
    return _transactionDescriptBtn;
}
- (void)commitBtnClick:(UIButton *)sender{
    if (_block) {
        _block(sender.tag);
    }
}
- (void)didSelectBtnofIndex:(LXMyWalletCollectionViewBlock)block{
    _block = block;
}
- (void)setMoneyStr:(NSString *)moneyStr{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:moneyStr];
    NSString *strLabel= [moneyStr substringWithRange:NSMakeRange([moneyStr rangeOfString:@"."].location, 3)];
    moneyStr = [moneyStr stringByReplacingOccurrencesOfString:strLabel withString:@""];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kfontValue(20) weight:0.6] range:[str.string rangeOfString:moneyStr]];
    _moneyLabel.text = self.moneyStr;
    _moneyLabel.attributedText = str;
}
@end
