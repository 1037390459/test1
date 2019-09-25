//
//  LXMainIndexCarTitleCollectionViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/4.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMainIndexCarTitleCollectionViewCell.h"
@interface LXMainIndexCarTitleCollectionViewCell()
@property (nonatomic,strong) UIImageView *carImage;      /**< 车辆 */
@property (nonatomic,strong) UILabel *titleLabel;        /**< 标题 */
@property (nonatomic,strong) UILabel *rightLabel;        /**< 我要借车 */
@property (nonatomic,strong) UIImageView *rightImg;      /**< right */
@end
@implementation LXMainIndexCarTitleCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI{
    [self.contentView addSubview:self.carImage];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.rightLabel];
    [self.contentView addSubview:self.rightImg];
    self.backgroundColor = [UIColor whiteColor];
    [self.carImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(13*k_width);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(13);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carImage.mas_right).offset(5);
        make.centerY.equalTo(self);
    }];
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15*k_width);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(15);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightImg.mas_left).offset(-3*k_width);
        make.centerY.equalTo(self);
    }];
}
- (UIImageView *)carImage{
    if (!_carImage) {
        _carImage =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"bgcar"
                                       isUIEnabled:YES];
    }
    return _carImage;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"当前可使用的车辆"
                                             TextAlign:center];
        _titleLabel.textColor = kRGBColor(135, 135, 135);
        _titleLabel.font = [UIFont systemFontOfSize:kfontValue(14)];
    }
    return _titleLabel;
}
- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"我要借车"
                                             TextAlign:center];
        _rightLabel.font = [UIFont systemFontOfSize:kfontValue(14)];
        _rightLabel.textColor = KLabelColor_greenColor;
    }
    return _rightLabel;
}
- (UIImageView *)rightImg{
    if (!_rightImg) {
        _rightImg =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"greenBack"
                                       isUIEnabled:YES];
    }
    return _rightImg;
}
@end
