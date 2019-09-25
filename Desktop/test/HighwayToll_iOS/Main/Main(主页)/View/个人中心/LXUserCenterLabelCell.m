//
//  LXUserCenterLabelCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/29.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXUserCenterLabelCell.h"
@interface LXUserCenterLabelCell()
@property (nonatomic,strong) UILabel *titleLabel;           /**< 标题 */
@property (nonatomic,strong) UILabel *line;                 /**< 线 */
@property (nonatomic,strong) UILabel *bottomline;           /**< 线 */
@property (nonatomic,strong) UILabel *contentLabel;         /**< 内容 */
@property (nonatomic,strong) UIButton *rightBtn;            /**< 内容 */
@property (nonatomic,strong) UIImageView *wechatLogo;       /**< 微信logo */
@end
@implementation LXUserCenterLabelCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
#pragma mark 懒加载
- (void)configUI{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.rightBtn];
    [self.contentView addSubview:self.bottomline];
    [self.contentView addSubview:self.wechatLogo];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_equalTo(kWidth *0.25);
        make.width.mas_equalTo(0.8);
        make.height.mas_equalTo(self.height*0.65);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.line.mas_left).offset(-12*k_width);
        make.centerY.equalTo(self);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line.mas_right).offset(12*k_width);
        make.centerY.equalTo(self);
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20*k_width);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(12);
    }];
    [self.bottomline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.height.mas_equalTo(0.3);
        make.bottom.equalTo(self);
    }];
    [self.wechatLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLabel.mas_left).offset(-3);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(22);
        make.centerY.equalTo(self);
    }];
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"姓名"
                                             TextAlign:right];
        _titleLabel.textColor = kRGBColor(135, 135, 135);
        [_titleLabel setFont:[UIFont systemFontOfSize:kfontValue(15)]];
    }
    return _titleLabel;
}
- (UILabel *)line{
    if (!_line) {
        _line =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@""
                                             TextAlign:center];
        _line.backgroundColor = kRGBColor(135, 135, 135);
    }
    return _line;
}
- (UILabel *)bottomline{
    if (!_bottomline) {
        _bottomline =  [LXView createLabelWithFrame:CGRectZero
                                         text:@""
                                    TextAlign:center];
        _bottomline.backgroundColor = kRGBColor(135, 135, 135);
    }
    return _bottomline;
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"吧啦啦啦啦"
                                             TextAlign:center];
        [_contentLabel setFont:[UIFont systemFontOfSize:kfontValue(15)]];
    }
    return _contentLabel;
}
- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn =     [LXView createButtonWithFrame:CGRectZero
                                                title:@""
                                            imageName:@"right"
                                          bgImageName:@""
                                               radius:-1
                                               target:self
                                               action:@selector(click)
                                                color:nil];
        
    }
    return _rightBtn;
}
- (void)click{
    
}
- (UIImageView *)wechatLogo{
    if (!_wechatLogo) {
        _wechatLogo =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"CN_tencent wechat"
                                         isUIEnabled:YES];
        _wechatLogo.hidden = YES;
    }
    return _wechatLogo;
}
- (void)setTitleStr:(NSString *)titleStr{
    self.titleLabel.text = titleStr;
}
- (void)setContentStr:(NSString *)contentStr{
    self.contentLabel.text = contentStr;
}
- (void)setIsShowWechat:(bool)isShowWechat{
    self.wechatLogo.hidden = !isShowWechat;
}
@end
