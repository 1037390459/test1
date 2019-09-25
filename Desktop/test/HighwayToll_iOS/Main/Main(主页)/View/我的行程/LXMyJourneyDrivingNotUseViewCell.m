//
//  LXMyJourneyDrivingNotUseViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/19.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyJourneyDrivingNotUseViewCell.h"

@interface LXMyJourneyDrivingNotUseViewCell()
@property (nonatomic,strong) UIImageView *plateBgView;             /**< 车牌背景 */
@property (nonatomic,strong) UILabel *textLabel;                   /**<  */
@property (nonatomic,strong) UILabel *contentLabel;                /**< 内容文本 */
@property (nonatomic,strong) UIButton *statusLabel;                /**< 不想用了 */
@end
@implementation LXMyJourneyDrivingNotUseViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI{
    [self.contentView addSubview:self.plateBgView];
    [self.contentView addSubview:self.textLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.statusLabel];
    self.backgroundColor =kRGBColor(224, 247, 233);
    //--------------------------------------------
    [self.plateBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.width.mas_equalTo(self.width*0.29);
        make.height.mas_equalTo(36);
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.plateBgView);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.plateBgView.mas_right).offset(10*k_width);
        make.centerY.equalTo(self);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-25*k_width);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(25);
    }];
}
- (UIImageView *)plateBgView{
    if (!_plateBgView) {
        _plateBgView =   [LXView createImageViewFrame:CGRectZero
                                            imageName:@"platebg"
                                          isUIEnabled:YES];
    }
    return _plateBgView;
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel =  [LXView createLabelWithFrame:CGRectZero
                                                 text:@"未驶入高速"
                                            TextAlign:left];
        _contentLabel.font = [UIFont systemFontOfSize:kfontValue(12)];
    }
    return _contentLabel;
}
- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel =  [LXView createLabelWithFrame:CGRectZero
                                              text:@" 沪A 88888 "
                                         TextAlign:center];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.font = [UIFont systemFontOfSize:kfontValue(15) weight:0.3];
        _textLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _textLabel;
}
- (UIButton *)statusLabel{
    if (!_statusLabel) {
        _statusLabel =  [LXView createButtonWithFrame:CGRectZero
                                                title:@"  不想用了 "
                                              bgColor:nil
                                               radius:3
                                               target:self
                                               action:@selector(click)];
        _statusLabel.borderColor = [UIColor redColor].CGColor;
        _statusLabel.borderWidth = 0.5;
        [_statusLabel setTitleColor:[UIColor redColor] forState: 0];
        [_statusLabel.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(13) weight:0.3]];
    }
    return _statusLabel;
}
- (void)click{
    if (_block) {
        _block();
    }
}
- (void)setPlateNumber:(NSString *)plateNumber{
    _plateNumber = plateNumber;
    self.textLabel.text = plateNumber;
}
- (void)didSelectClick:(LXMyJourneyDrivingNotUseViewBlock)block{
    _block = block;
}
@end
