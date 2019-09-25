//
//  LXAddVehicleCollectionViewSecondCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/24.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXAddVehicleCollectionViewSecondCell.h"
@interface LXAddVehicleCollectionViewSecondCell()
@property (nonatomic,strong) UILabel *titleLabel;                /**< title */
@property (nonatomic,strong) UILabel *line;                      /**< 线 */
@property (nonatomic,strong) UITextField *contentField;          /**< 文本框 */
@end;
@implementation LXAddVehicleCollectionViewSecondCell
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
    [self.contentField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line.mas_right).offset(13*k_width);
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15*k_width);
    }];
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"拥有人"
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
- (UITextField *)contentField{
    if (!_contentField) {
        _contentField =  [LXView createTextFieldWithFrame:CGRectZero
                                           placeholder:@"请输入车架号/vin码"
                                           bgImageName:nil
                                              leftView:nil
                                             rightView:nil
                                            isPassWord:NO
                                              delegate:self];
        _contentField.borderStyle = UITextBorderStyleNone;
        _contentField.font = [UIFont systemFontOfSize:kfontValue(14)];
    }
    return _contentField;
}
- (void)setStrTitle:(NSString *)strTitle{
    self.titleLabel.text = strTitle;
}
- (void)setContentStr:(NSString *)contentStr{
    self.contentField.text = contentStr;
}
- (NSString *)contentStr{
    return self.contentField.text;
}
@end
