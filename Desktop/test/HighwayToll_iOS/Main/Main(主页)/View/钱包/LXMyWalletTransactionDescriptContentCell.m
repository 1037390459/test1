//
//  LXMyWalletTransactionDescriptContentCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyWalletTransactionDescriptContentCell.h"
@interface LXMyWalletTransactionDescriptContentCell()
@property (nonatomic,strong) UILabel *titleLabel;               /**< 标题名称 */
@property (nonatomic,strong) UILabel *timeLabel;                /**< 时间 */
@property (nonatomic,strong) UILabel *billLabel;                /**< 账单 */
@end
@implementation LXMyWalletTransactionDescriptContentCell

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
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.billLabel];
    //------------------添加--------------------
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.top.equalTo(self).offset(12*k_width);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8*k_width);
    }];
    [self.billLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15*k_width);
    }];
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"微信充值200.00元"
                                             TextAlign:center];
        _titleLabel.font = [UIFont systemFontOfSize:kfontValue(15)];
    }
    return _titleLabel;
}
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel =  [LXView createLabelWithFrame:CGRectZero
                                              text:@"2017-11-02 13:20:56"
                                             TextAlign:center];
        _timeLabel.textColor = kRGBColor(135, 135, 135);
        _timeLabel.font = [UIFont systemFontOfSize:kfontValue(11)];
    }
    return _timeLabel;
}
- (UILabel *)billLabel{
    if (!_billLabel) {
        _billLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"+200.00元"
                                             TextAlign:center];
        
    }
    return _billLabel;
}
- (void)setTitleStr:(NSString *)titleStr{
    self.titleLabel.text = kStringConvertNull(titleStr);
}
- (void)setAddTimeStr:(NSString *)addTimeStr{
    self.timeLabel.text = kStringConvertNull(addTimeStr);
}
- (void)setMoneyStr:(NSString *)moneyStr{
    NSString *contentStr = nil;
    if (self.index == 1) {
        _billLabel.textColor = kRGBColor(51, 155, 78);
        contentStr = [NSString stringWithFormat:@"+ %@元",moneyStr];
    }else{
        _billLabel.textColor = [UIColor redColor];
        contentStr =  [NSString stringWithFormat:@"- %@元",moneyStr];
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:contentStr];
    _billLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
    [str addAttribute:NSFontAttributeName
                value:[UIFont systemFontOfSize:kfontValue(20) weight:0.3]
                range:[str.string rangeOfString:moneyStr]];
   
    _billLabel.attributedText = str;
} 
@end
