//
//  LXMailCollectionViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/27.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMailCollectionViewCell.h"
@interface LXMailCollectionViewCell()
@property (nonatomic,strong) UILabel *titleLabel; /**<  */
@property (nonatomic,strong) UILabel *timeLabel;  /**<  */
@property (nonatomic,strong) UILabel *contentLabel;  /**<  */
@end
@implementation LXMailCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.contentLabel];
    //---------------------------------------------
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.right.equalTo(self).offset(-15*k_width);
        make.top.equalTo(self).offset(20*k_height);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(6*k_height);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self).offset(-15*k_width);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(18*k_height);
    }];
    //---------------------------------------------
}
#pragma mark 懒加载
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel =  [LXView createLabelWithFrame:CGRectZero
                                              text:@"2017-11-02 13:20:56"
                                             TextAlign:left];
        _timeLabel.textColor = kRGBColor(199, 199, 199);
        _timeLabel.font = [UIFont systemFontOfSize:kfontValue(11)];
    }
    return _timeLabel;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =  [LXView createLabelWithFrame:CGRectZero
                                              text:@"车辆信息审核通知"
                                         TextAlign:left];
        _titleLabel.font = [UIFont systemFontOfSize:kfontValue(15)];
    }
    return _titleLabel;
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel =  [LXView createLabelWithFrame:CGRectZero
                                                 text:@"您于2017年11月1日 14:34:22 提交的车辆信息已经通过系统审核， 祝您您用车愉快！"
                                         TextAlign:left];
        _contentLabel.textColor = kRGBColor(135, 135, 135);
        _contentLabel.font = [UIFont systemFontOfSize:kfontValue(15)];
    }
    return _contentLabel;
}
- (void)setAddTimeStr:(NSString *)addTimeStr{
    self.timeLabel.text = kStringConvertNull(addTimeStr);
}
- (void)setContentStr:(NSString *)contentStr{
    self.contentLabel.text = contentStr;
}
- (void)setTitleStr:(NSString *)titleStr{
    self.titleLabel.text = titleStr;
}
@end
