//
//  LXMyMessageCollectionViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/28.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyMessageCollectionViewCell.h"
@interface LXMyMessageCollectionViewCell()
@property (nonatomic,strong) UIImageView *logoImage;         /**< logo图片 */
@property (nonatomic,strong) UILabel *titleLable;            /**< title标题 */
@property (nonatomic,strong) UILabel *line;                  /**< 线 */
@property (nonatomic,strong) UILabel *tipLabel;              /**< 提示 */
@property (nonatomic,strong) UILabel *descriptLabel;         /**< 描述 */
@property (nonatomic,strong) UILabel *timeLabel;             /**< 时间 */
@end
@implementation LXMyMessageCollectionViewCell
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
    [self.contentView addSubview:self.logoImage];
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.tipLabel];
    [self.contentView addSubview:self.descriptLabel];
    [self.contentView addSubview:self.timeLabel];
    //------------------frame开始------------------
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.left.equalTo(self).offset(15*k_width);
        make.centerY.equalTo(self);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoImage.mas_right).offset(15*k_width);
        make.width.mas_equalTo(0.8);
        make.height.mas_equalTo(self.height *0.6);
        make.centerY.equalTo(self);
    }];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line.mas_right).offset(15*k_width);
        make.top.equalTo(self.logoImage).offset(2*k_width);
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLable.mas_right).offset(1);
        make.top.equalTo(self.titleLable).offset(3);
        make.height.width.mas_equalTo(5);
    }];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line.mas_right).offset(15*k_width);
        make.top.equalTo(self.titleLable.mas_bottom).offset(5);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLable);
        make.right.equalTo(self).offset(-15*k_width);
    }];
    //------------------frame结束------------------
}
- (UIImageView *)logoImage{
    if (!_logoImage) {
        _logoImage =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"myMessage"
                                        isUIEnabled:YES];
    }
    return _logoImage;
}
- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"站内信"
                                             TextAlign:left];
        _titleLable.font = [UIFont systemFontOfSize:kfontValue(15)];
    }
    return _titleLable;
}
- (UILabel *)line{
    if (!_line) {
        _line =  [LXView createLabelWithFrame:CGRectZero
                                               text:@""
                                          TextAlign:left];
        _line.backgroundColor = kRGBColor(245, 245, 245);
    }
    return _line;
}
- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel =  [LXView createLabelWithFrame:CGRectMake(0, 0, 5, 5)
                                                  text:@""
                                             TextAlign:center];
        [_tipLabel setBackgroundColor:[UIColor redColor]];
        [_tipLabel.layer setCornerRadius:2.5];
        [_tipLabel.layer setMasksToBounds:YES];
    }
    return _tipLabel;
}
- (UILabel *)descriptLabel{
    if (!_descriptLabel) {
        _descriptLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"您的车辆已经通过审核!"
                                             TextAlign:left];
        _descriptLabel.textColor = kRGBColor(135, 135, 135);
        _descriptLabel.font = [UIFont systemFontOfSize:kfontValue(11)];
    }
    return _descriptLabel;
}
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel =  [LXView createLabelWithFrame:CGRectZero
                                              text:@"2017-11-02"
                                         TextAlign:right];
        _timeLabel.textColor = kRGBColor(135, 135, 135);
        _timeLabel.font = [UIFont systemFontOfSize:kfontValue(11)];
    }
    return _timeLabel;
}
- (void)setImageName:(NSString *)imageName{
    self.logoImage.image = [UIImage imageNamed:imageName];
}
- (void)setContentStr:(NSString *)contentStr{
    self.descriptLabel.text = contentStr;
}
- (void)setAddTimeStr:(NSString *)addTimeStr{
    self.timeLabel.text = kStringConvertNull(addTimeStr);
}
- (void)setIsRead:(bool)isRead{
    self.tipLabel.hidden = isRead;
}
- (void)setNumber:(NSInteger)number{
    BOOL flag = number >0?NO:YES;
    self.tipLabel.hidden = flag;
}
- (void)setTitleStr:(NSString *)titleStr{
    self.titleLable.text = titleStr;
}
@end
