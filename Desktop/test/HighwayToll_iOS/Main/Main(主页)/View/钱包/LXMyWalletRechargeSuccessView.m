//
//  LXMyWalletRechargeSuccessView.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyWalletRechargeSuccessView.h"
@interface LXMyWalletRechargeSuccessView()
@property (nonatomic,strong) UIImageView *logoView;         /**< 标志 */
@property (nonatomic,strong) UILabel *successLabel;         /**< 充值成功 */
@property (nonatomic,strong) UILabel *moneyDescriptLabel;   /**< 描述 */
@property (nonatomic,strong) UIButton *myWalletBtn;         /**< 我的钱包 */
@property (nonatomic,strong) UIButton *continueRecharge;    /**< 继续充值 */
@end
@implementation LXMyWalletRechargeSuccessView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
//配置UI
- (void)configUI{
    [self addSubview:self.logoView];
    [self addSubview:self.successLabel];
    [self addSubview:self.moneyDescriptLabel];
    [self addSubview:self.myWalletBtn];
    [self addSubview:self.continueRecharge];
    //------------------------------------
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(65*k_height);
        make.width.height.mas_equalTo(117*k_height);
    }];
    [self.successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoView.mas_bottom).offset(20*k_height);
        make.centerX.equalTo(self.logoView);
    }];
    [self.moneyDescriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.successLabel.mas_bottom).offset(22*k_height);
        make.centerX.equalTo(self);
    }];
    CGFloat width = (kWidth - (29*k_width)*2.5)/2;
    [self.myWalletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyDescriptLabel.mas_bottom).offset(50*k_height);
        make.left.equalTo(self).offset(29*k_width);
        make.height.mas_equalTo(kCellHeight);
        make.width.mas_equalTo(width);
    }];
    [self.continueRecharge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.myWalletBtn.mas_right).offset(15*k_width);
        make.top.height.width.equalTo(self.myWalletBtn);
    }];
}
#pragma mark 加载
- (UIImageView *)logoView{
    if (!_logoView) {
        _logoView =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"rechargeSuccess"
                                       isUIEnabled:YES];
    }
    return _logoView;
}
- (UILabel *)successLabel{
    if (!_successLabel) {
        _successLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"恭喜你，充值成功！"
                                             TextAlign:center];
        _successLabel.textColor = kRGBColor(56, 156, 81);
        _successLabel.font = [UIFont systemFontOfSize:kfontValue(23)];
    }
    return _successLabel;
}
- (UILabel *)moneyDescriptLabel{
    if (!_moneyDescriptLabel) {
        _moneyDescriptLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"钱包余额：200元"
                                             TextAlign:center];
        
    }
    return _moneyDescriptLabel;
}
- (UIButton *)myWalletBtn{
    if (!_myWalletBtn) {
        _myWalletBtn =     [LXView createButtonWithFrame:CGRectZero
                                                  title:@"我的钱包"
                                                bgColor:[UIColor clearColor]
                                                 radius:kfontValue(23)
                                                 target:self
                                                  action:@selector(click:)];
        [_myWalletBtn setTitleColor:kRGBColor(56, 156, 81) forState:0];
        _myWalletBtn.borderColor = kRGBColor(56, 156, 81).CGColor;
        _myWalletBtn.borderWidth = 0.8;
        _myWalletBtn.tag = 1;
    }
    return _myWalletBtn;
}
- (UIButton *)continueRecharge{
    if (!_continueRecharge) {
        _continueRecharge =     [LXView createButtonWithFrame:CGRectZero
                                                  title:@"继续充值"
                                                bgColor:kRGBColor(56, 156, 81)
                                                 radius:kfontValue(23)
                                                 target:self
                                                  action:@selector(click:)];
        [_continueRecharge setTitleColor:[UIColor whiteColor] forState:0];
        _continueRecharge.tag = 0;
    }
    return _continueRecharge;
}
- (void)click:(UIButton *)sender{
 
    if (_block) {
        _block(sender.tag);
    }
}
- (void)setMoneyStr:(NSString *)moneyStr{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"钱包余额：%@元",kStringConvertNull(moneyStr)]];
    [str addAttribute:NSForegroundColorAttributeName value:kRGBColor(56, 156, 81) range:[str.string rangeOfString:[NSString stringWithFormat:@"%@元",moneyStr]]];
    _moneyDescriptLabel.text = [NSString stringWithFormat:@"钱包余额：%@元",moneyStr];
    _moneyDescriptLabel.attributedText = str;
}

- (void)didSelectClick:(LXMyWalletRechargeSuccessBlock)block{
    _block = block;
}
@end
