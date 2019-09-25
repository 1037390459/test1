//
//  LXBorrowACarFromAFriendMessageListFailCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/28.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXBorrowACarFromAFriendMessageListFailCell.h"
@interface LXBorrowACarFromAFriendMessageListFailCell()
@property (nonatomic,strong) UILabel *titleLabel;    /**< 标题 */
@property (nonatomic,strong) UILabel *timeLabel;     /**< 时间 */
@property (nonatomic,strong) UILabel *contentLabel;  /**< 内容文本 */
@property (nonatomic,strong) UILabel *reasonLabel;   /**< 原因 */
@end
@implementation LXBorrowACarFromAFriendMessageListFailCell
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
    [self.contentView addSubview:self.reasonLabel];
    //-------------------开始----------------------
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.top.equalTo(self).offset(18*k_width);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(21);
    }];
    [self.reasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(5);
    }];
    //-------------------结束----------------------
}
#pragma mark 懒加载
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"借车失败"
                                             TextAlign:left];
        _titleLabel.font = [UIFont systemFontOfSize:kfontValue(15)];
    }
    return _titleLabel;
}
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel =  [LXView createLabelWithFrame:CGRectZero
                                              text:@"2017-11-02 13:20:56"
                                             TextAlign:left];
        _timeLabel.textColor = kRGBColor(135, 135, 135);
        _timeLabel.font = [UIFont systemFontOfSize:kfontValue(11)];
    }
    return _timeLabel;
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"您的借车请求被15833298660拒绝"
                                             TextAlign:left];
        _contentLabel.textColor = kRGBColor(135, 135, 135);
        _contentLabel.font = [UIFont systemFontOfSize:kfontValue(14)];
    }
    return _contentLabel;
}
- (UILabel *)reasonLabel{
    if (!_reasonLabel) {
        _reasonLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"拒绝理由：这几天我自己要用车，不能出借！"
                                             TextAlign:center];
        _reasonLabel.font = [UIFont systemFontOfSize:kfontValue(14)];
        _reasonLabel.textColor = [UIColor redColor];
    }
    return _reasonLabel;
}
@end
