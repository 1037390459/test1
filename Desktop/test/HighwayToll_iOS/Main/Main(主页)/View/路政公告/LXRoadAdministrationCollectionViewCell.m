//
//  LXRoadAdministrationCollectionViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/5.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXRoadAdministrationCollectionViewCell.h"
@interface LXRoadAdministrationCollectionViewCell()
@property (nonatomic,strong) UILabel *titleLabel;                /**< 标题 */
@property (nonatomic,strong) UILabel *timeLabel;                 /**< 时间 */
@property (nonatomic,strong) UILabel *descriptLabel;             /**< 描述 */
@end
@implementation LXRoadAdministrationCollectionViewCell
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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.descriptLabel];
    self.backgroundColor = [UIColor whiteColor];
    //----------------------------------------------
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.top.equalTo(self).offset(15*k_width);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8*k_width);
        make.left.equalTo(self.titleLabel);
    }];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(15*k_width);
        make.right.equalTo(self).offset(-15*k_width);
        make.left.equalTo(self.titleLabel);
    }];
}
//懒加载
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"临西：轿车抛锚司机一筹莫展，民警推车下高速"
                                             TextAlign:center];
        _titleLabel.font = [UIFont systemFontOfSize:kfontValue(15)];
        _timeLabel.numberOfLines = 1;
    }
    return _titleLabel;
}
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel =  [LXView createLabelWithFrame:CGRectZero
                                              text:@"2017-11-10 16:27"
                                             TextAlign:center];
        _timeLabel.textColor = kRGBColor(223, 223, 223);
        _timeLabel.font = [UIFont systemFontOfSize:kfontValue(11)];
    }
    return _timeLabel;
}
- (UILabel *)descriptLabel{
    if (!_descriptLabel) {
        _descriptLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"交警同志，我的车坏了，就停在匝道那里，能帮忙想办法嘛？台湾发生大发阿道夫"
                                             TextAlign:left];
        _descriptLabel.textColor = kRGBColor(135, 135, 135);
        _descriptLabel.font = [UIFont systemFontOfSize:kfontValue(14)];
        _timeLabel.numberOfLines = 2;
    }
    return _descriptLabel;
}
- (void)setTimeStr:(NSString *)timeStr{
    self.timeLabel.text = kStringConvertNull(timeStr);
}
- (void)setTitleStr:(NSString *)titleStr{
    self.titleLabel.text = kStringConvertNull(titleStr);
}
- (void)setContentStr:(NSString *)contentStr{
    self.descriptLabel.text = kStringConvertNull(contentStr);
}
@end
