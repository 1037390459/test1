//
//  LXAddVehicleEngineAndColorViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXAddVehicleEngineAndColorViewCell.h"

@interface LXAddVehicleEngineAndColorViewCell ()
@property (nonatomic,strong) UILabel *titleLabel;                 /**< title */
@property (nonatomic,strong) UILabel *line;                       /**< 线 */
@property (nonatomic,strong) UILabel *line2;                      /**< 线 */
@property (nonatomic,strong) UILabel *line3;                      /**< 线 */
@property (nonatomic,strong) UITextField *carColorField;              /**< 车身颜色 */
@property (nonatomic,strong) UILabel *textColorDescript;          /**< 车身颜色描述 */
@property (nonatomic,strong) UITextField *contentField;           /**< 文本框 */
@end

@implementation LXAddVehicleEngineAndColorViewCell

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
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.line2];
    [self.contentView addSubview:self.line3];
    [self.contentView addSubview:self.textColorDescript];
    [self.contentView addSubview:self.carColorField];
    [self.contentView addSubview:self.contentField];
    //----------------end------------------------
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.centerY.equalTo(self);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidth*0.25);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(self.height*0.55);
        make.width.mas_equalTo(0.55);
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line.mas_right).offset(kWidth*0.25);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(self.height*0.55);
        make.width.mas_equalTo(0.55);
    }];
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line2.mas_right).offset(kWidth*0.25);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(self.height*0.55);
        make.width.mas_equalTo(0.55);
    }];
    [self.textColorDescript mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.line2);
        make.right.equalTo(self.line3);
    }];
    [self.carColorField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.line3).offset(12*k_width);
        make.right.equalTo(self).offset(-6*k_width);
    }];
    [self.contentField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line.mas_right).offset(12*k_width);
        make.centerY.equalTo(self);
        make.right.equalTo(self.line2).offset(-2*k_width);
    }];
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =  [LXView createLabelWithFrame:CGRectZero
                                               text:@"发动机号"
                                          TextAlign:center];
        _titleLabel.font = [UIFont systemFontOfSize:kfontValue(14)];
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
- (UILabel *)line2{
    if (!_line2) {
        _line2 =  [LXView createLabelWithFrame:CGRectZero
                                         text:@""
                                    TextAlign:center];
        _line2.backgroundColor = kRGBColor(135, 135, 135);
    }
    return _line2;
}
- (UILabel *)line3{
    if (!_line3) {
        _line3 =  [LXView createLabelWithFrame:CGRectZero
                                         text:@""
                                    TextAlign:center];
        _line3.backgroundColor = kRGBColor(135, 135, 135);
    }
    return _line3;
}
- (UITextField *)carColorField{
    if (!_carColorField) {
        _carColorField =  [LXView createTextFieldWithFrame:CGRectZero
                                              placeholder:@"请输入颜色"
                                              bgImageName:nil
                                                 leftView:nil
                                                rightView:nil
                                               isPassWord:NO
                                                 delegate:self];
        _carColorField.borderStyle = UITextBorderStyleNone;
        _carColorField.font = [UIFont systemFontOfSize:kfontValue(11)];
        _carColorField.adjustsFontSizeToFitWidth = YES;
        _carColorField.clearButtonMode = UITextFieldViewModeNever;
    }
    return _carColorField;
}
- (UILabel *)textColorDescript{
    if (!_textColorDescript) {
        _textColorDescript =  [LXView createLabelWithFrame:CGRectZero
                                          text:@"车身颜色"
                                     TextAlign:center];
        _textColorDescript.font = [UIFont systemFontOfSize:kfontValue(14)];
    }
    return _textColorDescript;
}
- (UITextField *)contentField{
    if (!_contentField) {
        _contentField =  [LXView createTextFieldWithFrame:CGRectZero
                                              placeholder:@"请输入发动机号"
                                              bgImageName:nil
                                                 leftView:nil
                                                rightView:nil
                                               isPassWord:NO
                                                 delegate:self];
        _contentField.borderStyle = UITextBorderStyleNone;
        _contentField.font = [UIFont systemFontOfSize:kfontValue(11)];
        _contentField.adjustsFontSizeToFitWidth = YES;
        _contentField.clearButtonMode = UITextFieldViewModeNever;
    }
    return _contentField;
}
- (void)setStrTitle:(NSString *)strTitle{
    self.titleLabel.text = strTitle;
}
- (void)setColorStr:(NSString *)colorStr{
    self.carColorField.text = colorStr;
}
- (void)setEngineNo:(NSString *)EngineNo{
     self.contentField.text = EngineNo;
}
- (NSString *)colorStr{
    return self.carColorField.text;
}
- (NSString *)EngineNo{
    return self.contentField.text;
}
@end
