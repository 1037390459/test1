//
//  LXLendACarToAfriendSelectPlateCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/27.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXLendACarToAfriendSelectPlateCell.h"
@interface LXLendACarToAfriendSelectPlateCell()
@property (nonatomic,strong) UILabel *titleLabel;                /**< title文本 */
@property (nonatomic,strong) UILabel *line;                      /**< 线 */
@property (nonatomic,strong) UIImageView *plateBG;               /**<  */ 
@property (nonatomic,strong) UIImageView *rightImage;            /**< 右边图片 */
@end
@implementation LXLendACarToAfriendSelectPlateCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI{
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.plateBG];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.rightImage];
    //----------------start-------------------
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.centerY.equalTo(self);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.line.mas_right).offset(15*k_width);
        make.width.mas_equalTo(self.width*0.29);
        make.height.mas_equalTo(36);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth*0.235);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(self.height *0.75);
        make.width.mas_equalTo(0.8);
    }];
    [self.plateBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentLabel);
    }];
    [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15*k_width);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(20);
    }];
    //----------------end---------------------
}
#pragma mark 配置UI
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =  [LXView createLabelWithFrame:CGRectZero
                                               text:@"手机号码"
                                          TextAlign:left];
        _titleLabel.font = [UIFont systemFontOfSize:kfontValue(15)];
    }
    return _titleLabel;
}
- (UILabel *)line{
    if (!_line) {
        _line =  [LXView createLabelWithFrame:CGRectZero
                                         text:@""
                                    TextAlign:center];
        _line.backgroundColor = kRGBColor(235, 235, 235);
    }
    return _line;
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel =  [LXView createLabelWithFrame:CGRectZero
                                                 text:@"请选择车牌"
                                            TextAlign:center];
        _contentLabel.textColor = [UIColor whiteColor];
    }
    return _contentLabel;
}
- (UIImageView *)plateBG{
    if (!_plateBG) {
        _plateBG =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"platebg"
                                      isUIEnabled:YES];
    }
    return _plateBG;
}
- (UIImageView *)rightImage{
    if (!_rightImage) {
        _rightImage =   [LXView createImageViewFrame:CGRectZero
                                        imageName:@"bottom"
                                      isUIEnabled:YES];
    }
    return _rightImage;
}
- (void)setContentStr:(NSString *)contentStr{
    self.contentLabel.text = contentStr;
}
- (void)setTitleStr:(NSString *)titleStr{
    self.titleLabel.text = titleStr;
}
- (NSString *)contentStr{
    return self.contentLabel.text;
}
@end
