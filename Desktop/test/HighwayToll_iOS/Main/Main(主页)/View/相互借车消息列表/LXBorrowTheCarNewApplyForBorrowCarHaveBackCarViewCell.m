//
//  LXBorrowTheCarNewApplyForBorrowCarHaveBackCarViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/22.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXBorrowTheCarNewApplyForBorrowCarHaveBackCarViewCell.h"
@interface LXBorrowTheCarNewApplyForBorrowCarHaveBackCarViewCell()
@property (nonatomic,strong) UILabel *titleLabel;                   /**< 标题 */
@property (nonatomic,strong) UILabel *timeLabel;                    /**< 时间 */
@property (nonatomic,strong) UILabel *statusLabel;                  /**< 状态 */
@property (nonatomic,strong) UILabel *telLabel;                     /**< 手机号码 */
@property (nonatomic,strong) UILabel *carTimeLabel;                 /**< 用车时间 */
@property (nonatomic,strong) UILabel *stillCarTimeLabel;            /**< 还车时间 */
@property (nonatomic,strong) UILabel *borrowCarReasonLabel;         /**< 借车理由 */
@property (nonatomic,strong) UILabel *plate;                        /**< 车牌号码 */
@property (nonatomic,strong) UILabel *platelabel;                   /**< 车牌号码 */
@property (nonatomic,strong) UIImageView *plateImg;                 /**< 车牌背景图 */
@property (nonatomic,strong) UILabel *line;                         /**< 线 */
@property (nonatomic,strong) UIButton *agreeBtn;                    /**< 同意 */
@property (nonatomic,strong) UIView *bgView;                        /**<  */
@end
@implementation LXBorrowTheCarNewApplyForBorrowCarHaveBackCarViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.statusLabel];
    [self.contentView addSubview:self.telLabel];
    [self.contentView addSubview:self.carTimeLabel];
    [self.contentView addSubview:self.stillCarTimeLabel];
    [self.contentView addSubview:self.borrowCarReasonLabel];
    [self.contentView addSubview:self.plate];
    [self.contentView addSubview:self.plateImg];
    [self.contentView addSubview:self.platelabel];
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.agreeBtn];
    self.backgroundColor = [UIColor whiteColor];
    //----------------------开始--------------------------
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(20*k_width);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15*k_width);
        make.centerY.equalTo(self.titleLabel);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.telLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15*k_height);
    }];
    [self.telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.statusLabel.mas_bottom).offset(8*k_height);
    }];
    [self.stillCarTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.telLabel.mas_bottom).offset(8*k_height);
    }];
    [self.carTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.telLabel);
        make.top.equalTo(self.stillCarTimeLabel.mas_bottom).offset(8*k_height);
    }];
    [self.borrowCarReasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.carTimeLabel.mas_bottom).offset(8*k_height);
    }];
    [self.plate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.borrowCarReasonLabel);
        make.top.equalTo(self.borrowCarReasonLabel.mas_bottom).offset(15*k_height);
    }];
    [self.plateImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.plate.mas_right);
        make.centerY.equalTo(self.plate);
        make.width.mas_equalTo(94*k_width);
        make.height.mas_equalTo(28*k_width);
    }];
    [self.platelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.plateImg);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.platelabel.mas_bottom).offset(12*k_height);
        make.height.mas_equalTo(0.8);
        make.left.right.equalTo(self);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self);
        make.top.equalTo(self.line.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.right.equalTo(self).offset(-15*k_width);
        make.width.mas_equalTo(72*k_width);
        make.height.mas_equalTo(26*k_width);
    }];
}
//懒加载
- (UIImageView *)plateImg{
    if (!_plateImg) {
        _plateImg =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"platebg"
                                       isUIEnabled:YES];
    }
    return _plateImg;
}- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =  [LXView createLabelWithFrame:CGRectZero
                                               text:@"借车成功！"
                                          TextAlign:center];
    }
    return _titleLabel;
}
- (UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel =  [LXView createLabelWithFrame:CGRectZero
                                                text:@"状态：已同意"
                                           TextAlign:center];
        _statusLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"状态：已同意"];
        [str addAttribute:NSForegroundColorAttributeName value:KLabelColor_greenColor range:[str.string rangeOfString:@"已同意"]];
        _statusLabel.attributedText = str;
    }
    return _statusLabel;
}
- (UILabel *)telLabel{
    if (!_telLabel) {
        _telLabel =  [LXView createLabelWithFrame:CGRectZero
                                             text:@"手机号码：13802000002"
                                        TextAlign:center];
        _telLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
    }
    return _telLabel;
}
- (UILabel *)carTimeLabel{
    if (!_carTimeLabel) {
        _carTimeLabel =  [LXView createLabelWithFrame:CGRectZero
                                                 text:@"用车时间：2017-11-11 12:30:22"
                                            TextAlign:center];
        _carTimeLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
        _carTimeLabel.textColor = KLabelColor_greenColor;
    }
    return _carTimeLabel;
}
- (UILabel *)stillCarTimeLabel{
    if (!_stillCarTimeLabel) {
        _stillCarTimeLabel =  [LXView createLabelWithFrame:CGRectZero
                                                      text:@"用车时间：2017-11-11 12:30:22"
                                                 TextAlign:center];
        _stillCarTimeLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
        _stillCarTimeLabel.textColor = KLabelColor_greenColor;
    }
    return _stillCarTimeLabel;
}
- (UILabel *)borrowCarReasonLabel{
    if (!_borrowCarReasonLabel) {
        _borrowCarReasonLabel =  [LXView createLabelWithFrame:CGRectZero
                                                         text:@"借车理由：自驾游出去半个月，借用一下你的车！"
                                                    TextAlign:center];
        _borrowCarReasonLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
    }
    return _borrowCarReasonLabel;
}- (UILabel *)plate{
    if (!_plate) {
        _plate =  [LXView createLabelWithFrame:CGRectZero
                                          text:@"车牌号码："
                                     TextAlign:center];
        _plate.font = [UIFont systemFontOfSize:kfontValue(13)];
    }
    return _plate;
}- (UILabel *)platelabel{
    if (!_platelabel) {
        _platelabel =  [LXView createLabelWithFrame:CGRectZero
                                               text:@"沪A 88888"
                                          TextAlign:center];
        _platelabel.font = [UIFont systemFontOfSize:kfontValue(13) weight:0.3];
        _platelabel.textColor = [UIColor whiteColor];
    }
    return _platelabel;
}
- (UILabel *)line{
    if (!_line) {
        _line =  [LXView createLabelWithFrame:CGRectZero
                                         text:@""
                                    TextAlign:center];
        _line.backgroundColor = kRGBColor(242, 242, 242);
    }
    return _line;
}
- (UIButton *)agreeBtn{
    if (!_agreeBtn) {
        _agreeBtn =     [LXView createButtonWithFrame:CGRectZero
                                                title:@"还车"
                                              bgColor:KLabelColor_greenColor
                                               radius:kfontValue(12)
                                               target:self
                                               action:@selector(click)];
        [_agreeBtn setTitleColor:[UIColor whiteColor] forState:0];
        [_agreeBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(15)]];
    }
    return _agreeBtn;
}
- (void)click{
    if (_block) {
        _block();
    }
}
- (void)didSelect:(LXBorrowTheCarNewApplyForBorrowCarHaveBackCarViewCellBlock)block{
    _block = block;
}
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [LXView createViewWithFrame:CGRectZero bgColor:[UIColor whiteColor] radius:-1];
    }
    return _bgView;
}
@end
