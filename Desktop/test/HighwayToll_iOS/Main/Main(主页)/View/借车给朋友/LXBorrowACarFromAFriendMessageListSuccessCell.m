//
//  LXBorrowACarFromAFriendMessageListSuccessCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/28.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXBorrowACarFromAFriendMessageListSuccessCell.h"
@interface LXBorrowACarFromAFriendMessageListSuccessCell()
@property (nonatomic,strong) UILabel *titleLabel;          /**< 标题 */
@property (nonatomic,strong) UILabel *contentLable;        /**< 内容文本 */
@property (nonatomic,strong) UILabel *timeLabel;           /**< 时间 */

@end
@implementation LXBorrowACarFromAFriendMessageListSuccessCell
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
    [self.contentView addSubview:self.contentLable];
    //-----------------配置开始-------------------------
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15*k_width);
        make.left.equalTo(self).offset(15*k_width);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(self).offset(-15*k_width);
    }];
    [self.contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(32*k_width);
        make.left.equalTo(self).offset(15*k_width);
    }];
    //-----------------配置结束-------------------------
}
#pragma mark 懒加载
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"借车申请成功！"
                                             TextAlign:left];
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
        _timeLabel.font = [UIFont systemFontOfSize:kfontValue(12)];
    }
    return _timeLabel;
}
- (UILabel *)contentLable{
    if (!_contentLable) {
        _contentLable =  [LXView createLabelWithFrame:CGRectZero
                                                 text:@"您的借车请求已经通过;"
                                             TextAlign:center];
        _contentLable.font = [UIFont systemFontOfSize:kfontValue(15)];
        _contentLable.textColor = kRGBColor(135, 135, 135);
    }
    return _contentLable;
}
@end
