//
//  LXMainIndexRechargeMoneyCollectionViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/4.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMainIndexRechargeMoneyCollectionViewCell.h"
@interface LXMainIndexRechargeMoneyCollectionViewCell()
@property (nonatomic,strong) UILabel *titleLabel;        /**< 标题 */
@property (nonatomic,strong) UIButton *rechargeBtn;       /**< 充值 */
@end
@implementation LXMainIndexRechargeMoneyCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.rechargeBtn];
    self.backgroundColor = [UIColor whiteColor];
    //----------------配置UI------------------
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10*k_width);
    }];
    [self.rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-12*k_width);
        make.width.mas_equalTo(72);
        make.height.mas_equalTo(28);
    }];
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"钱包余额￥200.00"
                                             TextAlign:center];
      
    }
    return _titleLabel;
}
- (UIButton *)rechargeBtn{
    if (!_rechargeBtn) {
        _rechargeBtn =     [LXView createButtonWithFrame:CGRectZero
                                                   title:nil
                                               imageName:nil
                                             bgImageName:@"recharge"
                                                  radius:-1
                                                  target:self
                                                  action:@selector(click)
                                                   color:nil];
        
    }
    return _rechargeBtn;
}
- (void)click{
    if (_block) {
        _block();
    }
}
- (void)didSelectCommitClick:(LXMainIndexRechargeMoneyCollectionViewCellBlock)block{
    _block = block;
}
- (void)setMoneyStr:(NSString *)moneyStr{
    
    [self setMoneyAttr:[NSString stringWithFormat:@"钱包余额￥ %@",moneyStr] label:self.titleLabel money:moneyStr];
}
- (void)setMoneyAttr:(NSString *)contentStr label:(UILabel *)label money:(NSString *)money{
    label.text = contentStr;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSString *strLabel= [money substringWithRange:NSMakeRange([money rangeOfString:@"."].location, 3)];
    money = [money stringByReplacingOccurrencesOfString:strLabel withString:@""];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kfontValue(28) weight:0.3] range:[str.string rangeOfString:money]];
    
    label.attributedText = str;
}
@end
