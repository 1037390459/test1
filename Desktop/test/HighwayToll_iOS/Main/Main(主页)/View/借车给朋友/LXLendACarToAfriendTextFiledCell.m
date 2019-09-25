//
//  LXLendACarToAfriendTextFiledCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/27.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXLendACarToAfriendTextFiledCell.h"
@interface LXLendACarToAfriendTextFiledCell()
@property (nonatomic,strong) UILabel *titleLabel;                /**< title文本 */
@property (nonatomic,strong) UILabel *line;                      /**< 线 */
@property (nonatomic,strong) UITextField *contentTextField;      /**< 内容文本 */
@end
@implementation LXLendACarToAfriendTextFiledCell
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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.contentTextField];
    //----------------start-------------------
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.centerY.equalTo(self);
    }];
    [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15*k_width);
        make.left.equalTo(self.line.mas_right).offset(15*k_width);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth*0.235);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(self.height *0.65);
        make.width.mas_equalTo(0.8);
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
                                             TextAlign:left];
        _line.backgroundColor = kRGBColor(235, 235, 235);
    }
    return _line;
}
- (UITextField *)contentTextField{
    if (!_contentTextField) {
        _contentTextField =  [LXView createTextFieldWithFrame:CGRectZero
                                           placeholder:@"请填写借车人的手机号码"
                                           bgImageName:nil
                                              leftView:nil
                                             rightView:nil
                                            isPassWord:NO
                                              delegate:self];
        _contentTextField.font = [UIFont systemFontOfSize:kfontValue(14)];
        _contentTextField.borderStyle = UITextBorderStyleNone;
        _contentTextField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _contentTextField;
}
- (void)setContentStr:(NSString *)contentStr{
    self.contentTextField.text = contentStr;
}
- (void)setTitleStr:(NSString *)titleStr{
    self.titleLabel.text = titleStr;
}
- (NSString *)contentStr{
    return self.contentTextField.text;
}
@end
