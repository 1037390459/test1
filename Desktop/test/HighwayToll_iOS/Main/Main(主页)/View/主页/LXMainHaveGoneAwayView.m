//
//  LXMainHaveGoneAwayView.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/4.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMainHaveGoneAwayView.h"
@interface LXMainHaveGoneAwayView()
@property (nonatomic,strong) UILabel *titleLabel;                      /**< 名称 */
@property (nonatomic,strong) UILabel *intoTheStationLabel;             /**< 入站口 */
@property (nonatomic,strong) UILabel *intoTheStation;                  /**< 入站口 */
@property (nonatomic,strong) UILabel *tollGate;                        /**< 收费口 */
@property (nonatomic,strong) UILabel *tollGateLabel;                   /**< 收费口 */
@property (nonatomic,strong) UIView  *topBackGroubndView;              /**< 背景图片 */
@property (nonatomic,strong) UIView  *bottomBackGroubndView;           /**< 背景图片 */
@property (nonatomic,strong) UIImageView *carImage;                    /**< 车辆图片 */
@property (nonatomic,strong) UILabel *carLabel;                        /**< 车辆 */
@property (nonatomic,strong) UIImageView *plateBGImage;                /**< 车牌号 */
@property (nonatomic,strong) UILabel *plateLabel;                      /**< 车牌 */
@property (nonatomic,strong) UILabel *drivingLabel;                    /**< 行驶中 */
@property (nonatomic,strong) UILabel *feeDeductionLabel;               /**< 扣分 */
@property (nonatomic,strong) UIButton *leftBtn;                        /**< 左边按钮 */
@property (nonatomic,strong) UIButton *rightBtn;                       /**< 右边按钮 */
@property (nonatomic,strong) UIButton *commitBtn;                      /**< 提交按钮 */
@end
@implementation LXMainHaveGoneAwayView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

/**
 配置UI
 */
- (void)configUI{
    [self.layer setContents:(id _Nullable) [UIImage imageNamed:@"goAwayBgView"].CGImage];
    [self addSubview:self.titleLabel];
    [self addSubview:self.intoTheStationLabel];
    [self addSubview:self.intoTheStation];
    [self addSubview:self.tollGate];
    [self addSubview:self.tollGateLabel];
    [self addSubview:self.topBackGroubndView];
    [self addSubview:self.bottomBackGroubndView];
    [self addSubview:self.carImage];
    [self addSubview:self.carLabel];
    [self addSubview:self.plateBGImage];
    [self addSubview:self.plateLabel];
    [self addSubview:self.drivingLabel];
    [self addSubview:self.feeDeductionLabel];
    [self addSubview:self.commitBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.leftBtn];
    //----------------------------------------
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(32*k_height);
        make.centerX.equalTo(self);
    }];
    [self.intoTheStation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(32*k_height);
        make.centerX.equalTo(self);
    }];
    [self.intoTheStationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.intoTheStation.mas_bottom).offset(13*k_height);
    }];
    [self.tollGate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.intoTheStationLabel.mas_bottom).offset(13*k_height);
    }];
    [self.tollGateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.tollGate.mas_bottom).offset(13*k_height);
    }];
    [self.topBackGroubndView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.right.equalTo(self).offset(-15*k_width);
        make.top.equalTo(self.tollGateLabel.mas_bottom).offset(80*k_width);
        make.height.mas_equalTo(55*k_height);
    }];
    [self.carImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topBackGroubndView.mas_left).offset(13*k_width);
        make.centerY.equalTo(self.topBackGroubndView);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(13);
    }];
    [self.carLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carImage.mas_right).offset(6*k_width);
        make.centerY.equalTo(self.topBackGroubndView);
    }];
    [self.plateBGImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topBackGroubndView);
        make.right.equalTo(self.topBackGroubndView).offset(-15*k_width);
        make.width.mas_equalTo(99*k_width);
        make.height.mas_equalTo(30*k_width);
    }];
    [self.plateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.plateBGImage);
    }];
    [self.bottomBackGroubndView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.right.equalTo(self.topBackGroubndView);
        make.top.equalTo(self.topBackGroubndView.mas_bottom).offset(2);
    }];
    [self.drivingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomBackGroubndView);
        make.left.equalTo(self.carImage);
    }];
    [self.feeDeductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topBackGroubndView).offset(-15*k_width);
        make.centerY.equalTo(self.bottomBackGroubndView);
    }];
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(150*k_width);
        make.centerX.equalTo(self);
        make.top.equalTo(self.bottomBackGroubndView.mas_bottom).offset(22*k_height);
    }];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.commitBtn);
        make.right.equalTo(self.commitBtn.mas_left).offset(-6);
        make.width.height.mas_equalTo(57*k_width);
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.commitBtn);
        make.left.equalTo(self.commitBtn.mas_right).offset(6);
        make.width.height.mas_equalTo(57*k_width);
    }];
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =  [LXView createLabelWithFrame:CGRectZero
                                               text:@"已驶离收费口"
                                          TextAlign:center];
        _titleLabel.font = [UIFont systemFontOfSize:kfontValue(28) weight:0.3];
        
    }
    return _titleLabel;
}- (UILabel *)intoTheStation{
    if (!_intoTheStation) {
        _intoTheStation =  [LXView createLabelWithFrame:CGRectZero
                                                   text:@"入站口"
                                              TextAlign:center];
        _intoTheStation.textColor = kRGBColor(135, 135, 135);
        _intoTheStation.font = [UIFont systemFontOfSize:kfontValue(14)];
    }
    return _intoTheStation;
}- (UILabel *)intoTheStationLabel{
    if (!_intoTheStationLabel) {
        _intoTheStationLabel =  [LXView createLabelWithFrame:CGRectZero
                                                        text:@"驶入高速公里  2017-11-13 11:30:45"
                                                   TextAlign:center];
        _intoTheStationLabel.textColor = kRGBColor(135, 135, 135);
        _intoTheStationLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
    }
    return _intoTheStationLabel;
}
- (UILabel *)tollGate{
    if (!_tollGate) {
        _tollGate =  [LXView createLabelWithFrame:CGRectZero
                                             text:@"收费口"
                                        TextAlign:center];
        _tollGate.textColor = kRGBColor(135, 135, 135);
        _tollGate.font = [UIFont systemFontOfSize:kfontValue(14)];
    }
    return _tollGate;
}
- (UILabel *)tollGateLabel{
    if (!_tollGateLabel) {
        _tollGateLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"驶离高速公里 2017-11-13 12:40:04"
                                             TextAlign:center];
        _tollGateLabel.textColor = kRGBColor(135, 135, 135);
        _tollGateLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
    }
    return _tollGateLabel;
}
- (UILabel *)carLabel{
    if (!_carLabel) {
        _carLabel =  [LXView createLabelWithFrame:CGRectZero
                                             text:@"使用车辆"
                                        TextAlign:center];
        _carLabel.textColor = kRGBColor(135, 135, 135);
        _carLabel.font = [UIFont systemFontOfSize:kfontValue(12)];
    }
    return _carLabel;
}
- (UILabel *)plateLabel{
    if (!_plateLabel) {
        _plateLabel =  [LXView createLabelWithFrame:CGRectZero
                                               text:@" 沪B 8B779 "
                                          TextAlign:center];
        _plateLabel.textColor = [UIColor whiteColor];
        _plateLabel.font = [UIFont systemFontOfSize:kfontValue(15) weight:0.4];
    }
    return _plateLabel;
}
- (UILabel *)drivingLabel{
    if (!_drivingLabel) {
        _drivingLabel =  [LXView createLabelWithFrame:CGRectZero
                                                 text:@"行驶时长56min"
                                            TextAlign:center];
        _drivingLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
        _drivingLabel.textColor = kRGBColor(135, 135, 135);
        
    }
    return _drivingLabel;
}
- (UILabel *)feeDeductionLabel{
    if (!_feeDeductionLabel) {
        _feeDeductionLabel =  [LXView createLabelWithFrame:CGRectZero
                                                      text:@"已扣费用433.40元"
                                                 TextAlign:center];
        _feeDeductionLabel.textColor = kRGBColor(135, 135, 135);
        _feeDeductionLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"已扣费用433.40元"];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kfontValue(18) weight:0.6] range:[str.string rangeOfString:@"433.40"]];
        [str addAttribute:NSForegroundColorAttributeName value:KLabelColor_greenColor range:[str.string rangeOfString:@"433.40"]];
    }
    return _feeDeductionLabel;
}
- (UIImageView *)plateBGImage{
    if (!_plateBGImage) {
        _plateBGImage =   [LXView createImageViewFrame:CGRectZero
                                             imageName:@"platebg"
                                           isUIEnabled:YES];
    }
    return _plateBGImage;
}
- (UIImageView *)carImage{
    if (!_carImage) {
        _carImage =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"bgcar"
                                       isUIEnabled:YES];
    }
    return _carImage;
}
- (UIView *)topBackGroubndView{
    if (!_topBackGroubndView) {
        _topBackGroubndView = [LXView createViewWithFrame:CGRectZero
                                                  bgColor:[UIColor whiteColor]
                                                   radius:3];
    }
    return _topBackGroubndView;
}
- (UIView *)bottomBackGroubndView{
    if (!_bottomBackGroubndView) {
        _bottomBackGroubndView = [LXView createViewWithFrame:CGRectZero
                                                     bgColor:[UIColor whiteColor]
                                                      radius:3];
    }
    return _bottomBackGroubndView;
}
- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn =     [LXView createButtonWithFrame:CGRectZero
                                               title:@""
                                           imageName:@""
                                         bgImageName:@"goAwayLeft"
                                              radius:-1
                                              target:self
                                              action:@selector(click:)
                                               color:nil];
        _leftBtn.tag = 0;
        
    }
    return _leftBtn;
}
- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn =     [LXView createButtonWithFrame:CGRectZero
                                               title:@""
                                           imageName:@""
                                         bgImageName:@"goAwayRight"
                                              radius:-1
                                              target:self
                                               action:@selector(click:)
                                               color:nil];
        _rightBtn.tag = 2;
        
    }
    return _rightBtn;
}
- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn =      [LXView createButtonWithFrame:CGRectZero
                                                  title:@""
                                              imageName:@""
                                            bgImageName:@"goAwayCenterBtn"
                                                 radius:-1
                                                 target:self
                                                 action:@selector(click:)
                                                  color:nil];
        _commitBtn.tag = 1;
    }
    return _commitBtn;
}
- (void)click:(UIButton *)sender{
    if (_block) {
        _block(sender.tag);
    }
}
- (void)didSelectCommitClick:(LXMainHaveGoneAwayViewCommitBlock)block{
    _block = block;
}
- (void)setTollGateStr:(NSString *)tollGateStr{
    _tollGateStr = tollGateStr;
    self.tollGate.text = [NSString stringWithFormat:@"驶离高速公路  %@",tollGateStr];
}
- (void)setIntoTheStationStr:(NSString *)intoTheStationStr{
    _intoTheStationStr = intoTheStationStr;
    self.intoTheStation.text = [NSString stringWithFormat:@"驶入高速公路  %@",intoTheStationStr];
    
}
- (void)setDrivingTime:(NSString *)time feeDeducationStr:(NSString *)str{
    [self setLabelColor:self.drivingLabel Str:time min:time];
    [self setLabelColor:self.feeDeductionLabel Str:str min:str];
}
- (void)setLabelColor:(UILabel *)sender Str:(NSString *)contentStr min:(NSString *)min{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:contentStr];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kfontValue(18) weight:0.6] range:[str.string rangeOfString:min]];
    [str addAttribute:NSForegroundColorAttributeName value:KLabelColor_greenColor range:[str.string rangeOfString:min]];
    sender.attributedText = str;
}
@end
