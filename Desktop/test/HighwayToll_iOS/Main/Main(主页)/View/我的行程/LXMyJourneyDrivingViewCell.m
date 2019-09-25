//
//  LXMyJourneyDrivingViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/4.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyJourneyDrivingViewCell.h"
@interface LXMyJourneyDrivingViewCell()
@property (nonatomic,strong) UIImageView *plateBgView;           /**< 车牌背景 */
@property (nonatomic,strong) UILabel *textLabel;                 /**<  */
@property (nonatomic,strong) UILabel *contentLabel;              /**< 内容文本 */
@property (nonatomic,strong) UILabel *statusLabel;               /**< 不想用了 */
@end
@implementation LXMyJourneyDrivingViewCell
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
                                                  text:@"驶入高速\n2017-11-02  13：20：56"
                                             TextAlign:left];
        
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
- (UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"行驶中"
                                             TextAlign:center];
        
        _statusLabel.textColor = kRGBColor(17, 151, 62);
        _statusLabel.font      = [UIFont systemFontOfSize:kfontValue(15) weight:0.3];
    
    }
    return _statusLabel;
} 
- (void)setPlateNumber:(NSString *)plateNumber{
    _plateNumber = plateNumber;
    self.textLabel.text = plateNumber;
}
- (void)setEnterTime:(NSString *)enterTime{
    _enterTime = kStringConvertNull(enterTime);
    self.contentLabel.text = [NSString stringWithFormat:@"驶入高速\n%@",enterTime];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"驶入高速\n%@",enterTime]];
    [str addAttribute:NSForegroundColorAttributeName value:kRGBColor(17, 151, 62) range:[str.string rangeOfString:@"驶入高速"]];
    _contentLabel.textColor = kRGBColor(135, 135, 135);
    _contentLabel.font = [UIFont systemFontOfSize:kfontValue(12)];
    _contentLabel.attributedText = str;
}
@end
