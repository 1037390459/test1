//
//  LXMyJourneyFinishViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/4.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyJourneyFinishViewCell.h"
@interface LXMyJourneyFinishViewCell ()
@property (nonatomic,strong) UIImageView *plateBgImg;                /**< 背景图片 */
@property (nonatomic,strong) UILabel *plateLabel;                    /**< 车牌号 */
@property (nonatomic,strong) UILabel *line;                          /**< 线 */
@property (nonatomic,strong) UILabel *titleLabel;                    /**< 名称 */
@property (nonatomic,strong) UILabel *driveIntoHighSpeed;            /**< 驶入高速 */
@property (nonatomic,strong) UILabel *driveIntoHighSpeedLabel;       /**< 驶入高速 */
@property (nonatomic,strong) UILabel *leaveIntoHighSpeedLabel;       /**< 离开高速 */
@property (nonatomic,strong) UILabel *leaveIntoHighSpeed;            /**< 离开高速 */
@property (nonatomic,strong) UILabel *moneyLabel;                    /**< 钱 */
@end
@implementation LXMyJourneyFinishViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self congifUI];
    }
    return self;
}
- (void)congifUI{
    [self.contentView addSubview:self.plateBgImg];
    [self.contentView addSubview:self.plateLabel];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.driveIntoHighSpeed];
    [self.contentView addSubview:self.driveIntoHighSpeedLabel];
    [self.contentView addSubview:self.leaveIntoHighSpeedLabel];
    [self.contentView addSubview:self.leaveIntoHighSpeed];
    [self.contentView addSubview:self.moneyLabel];
    [self.contentView setBackgroundColor:kRGBColor(242, 242, 242)];
    //--------------------------------------------------------
    [self.plateBgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.top.equalTo(self).offset(12*k_width);
        make.width.mas_equalTo(self.width*0.29);
        make.height.mas_equalTo(36);
    }];
    [self.plateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.plateBgImg);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.plateBgImg);
        make.right.equalTo(self).offset(-15*k_width);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.plateLabel);
        make.right.equalTo(self.titleLabel.mas_right);
        make.top.equalTo(self.plateLabel.mas_bottom).offset(9*k_height);
        make.height.mas_equalTo(0.8);
    }];
    [self.driveIntoHighSpeed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line);
        make.top.equalTo(self.line.mas_bottom).offset(15*k_height);
    }];
    [self.driveIntoHighSpeedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.driveIntoHighSpeed.mas_right).offset(6*k_width);
        make.centerY.equalTo(self.driveIntoHighSpeed);
    }];
    [self.leaveIntoHighSpeed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.driveIntoHighSpeed);
        make.top.equalTo(self.driveIntoHighSpeed.mas_bottom).offset(6);
    }];
    [self.leaveIntoHighSpeedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.driveIntoHighSpeedLabel);
        make.centerY.equalTo(self.leaveIntoHighSpeed);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom).offset(20);
        make.right.equalTo(self.titleLabel);
    }];
}
- (UIImageView *)plateBgImg{
    if (!_plateBgImg) {
        _plateBgImg =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"plateFinishStatus"
                                         isUIEnabled:YES];
    }
    return _plateBgImg;
}
- (UILabel *)plateLabel{
    if (!_plateLabel) {
        _plateLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@" 沪A 88888  "
                                             TextAlign:center];
        _plateLabel.textColor = [UIColor whiteColor];
        _plateLabel.font = [UIFont systemFontOfSize:15 weight:0.6];
        _plateLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _plateLabel;
}
- (UILabel *)line{
    if (!_line) {
        _line =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@""
                                             TextAlign:center];
        _line.backgroundColor = kRGBColor(225, 225, 225);
    }
    return _line;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"入站口-收费口 （46min）"
                                             TextAlign:right];
        _titleLabel.textColor = kRGBColor(135, 135, 135);
    }
    return _titleLabel;
}
- (UILabel *)driveIntoHighSpeed{
    if (!_driveIntoHighSpeed) {
        _driveIntoHighSpeed =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@" 驶入高速 "
                                             TextAlign:center];
        _driveIntoHighSpeed.textColor = kRGBColor(135, 135, 135);
        _driveIntoHighSpeed.layer.cornerRadius = 6;
        _driveIntoHighSpeed.layer.masksToBounds = YES;
        _driveIntoHighSpeed.borderColor = kRGBColor(135, 135, 135).CGColor;
        _driveIntoHighSpeed.borderWidth = 0.5;
        _driveIntoHighSpeed.font = [UIFont systemFontOfSize:kfontValue(12)];
    }
    return _driveIntoHighSpeed;
}
- (UILabel *)driveIntoHighSpeedLabel{
    if (!_driveIntoHighSpeedLabel) {
        _driveIntoHighSpeedLabel =  [LXView createLabelWithFrame:CGRectZero
                                                            text:@"2017-11-01  13:20:56"
                                                  TextAlign:center];
        _driveIntoHighSpeedLabel.textColor = kRGBColor(135, 135, 135);
        _driveIntoHighSpeedLabel.font = [UIFont systemFontOfSize:kfontValue(12)];
    }
    return _driveIntoHighSpeedLabel;
}
- (UILabel *)leaveIntoHighSpeed{
    if (!_leaveIntoHighSpeed) {
        _leaveIntoHighSpeed =  [LXView createLabelWithFrame:CGRectZero
                                                       text:@" 驶离高速 "
                                                  TextAlign:center];
        _leaveIntoHighSpeed.textColor = kRGBColor(135, 135, 135);
        _leaveIntoHighSpeed.layer.cornerRadius = 6;
        _leaveIntoHighSpeed.layer.masksToBounds = YES;
        _leaveIntoHighSpeed.borderColor = kRGBColor(135, 135, 135).CGColor;
        _leaveIntoHighSpeed.borderWidth = 0.5;
        _leaveIntoHighSpeed.font = [UIFont systemFontOfSize:kfontValue(12)];
        
    }
    return _leaveIntoHighSpeed;
}
- (UILabel *)leaveIntoHighSpeedLabel{
    if (!_leaveIntoHighSpeedLabel) {
        _leaveIntoHighSpeedLabel =  [LXView createLabelWithFrame:CGRectZero
                                                       text:@"2017-11-02  13:20:56"
                                                  TextAlign:center];
        _leaveIntoHighSpeedLabel.textColor = kRGBColor(135, 135, 135);
        _leaveIntoHighSpeedLabel.font = [UIFont systemFontOfSize:kfontValue(12)];
    }
    return _leaveIntoHighSpeedLabel;
}
- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"-200.00元"
                                             TextAlign:center];
        
    }
    return _moneyLabel;
}
- (void)setEnterTime:(NSString *)enterTime{
    _enterTime = enterTime;
    self.driveIntoHighSpeedLabel.text = kStringConvertNull(enterTime);
}
- (void)setExitTime:(NSString *)exitTime{
    _exitTime = exitTime;
    self.leaveIntoHighSpeedLabel.text = kStringConvertNull(exitTime);
}
- (void)setCostNumber:(NSString *)costNumber{
    _costNumber = kStringConvertNull(costNumber);
    
    _moneyLabel.font = [UIFont systemFontOfSize:kfontValue(11)];
    _moneyLabel.textColor = kRGBColor(135, 135, 135);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"-%@元",costNumber]];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kfontValue(23) weight:0.6] range:[str.string rangeOfString:[NSString stringWithFormat:@"-%@",costNumber]]];
    _moneyLabel.attributedText = str;
}
- (void)setPlateNumber:(NSString *)plateNumber{
    _plateNumber = kStringConvertNull(plateNumber);
    self.plateLabel.text = plateNumber;
}
- (void)setWhenLong:(NSString *)whenLong{
    _whenLong = whenLong;
    self.titleLabel.text = [NSString stringWithFormat:@"入站口-收费口 （%@min）",kStringConvertNull(whenLong)];
}
@end
