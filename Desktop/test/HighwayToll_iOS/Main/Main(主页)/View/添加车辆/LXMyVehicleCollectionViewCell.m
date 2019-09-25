//
//  LXMyVehicleCollectionViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/27.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyVehicleCollectionViewCell.h"

@implementation LXMyVehicleCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
//配置UI
- (void)configUI{
    [self.contentView addSubview:self.viewImage];
    [self.contentView addSubview:self.plateNumberLabel];
    [self.contentView addSubview:self.rightIcon];
    [self.contentView addSubview:self.borrowIcon];
    [self.contentView addSubview:self.owner];
    [self.contentView addSubview:self.carColor];
    [self.contentView addSubview:self.carType];
    [self setBackgroundColor:[UIColor whiteColor]];
    
    [self.viewImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.width*0.29);
        make.height.mas_equalTo(36);
        make.left.equalTo(self).offset(15*k_width);
        make.centerY.equalTo(self);
    }];
    [self.plateNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.width*0.29);
        make.height.mas_equalTo(36);
        make.left.equalTo(self).offset(15*k_width);
        make.centerY.equalTo(self);
    }];
    [self.owner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.plateNumberLabel.mas_right).offset(20*k_width);
        make.centerY.equalTo(self);
    }];
    [self.carColor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.owner.mas_right).offset(15*k_width);
        make.centerY.equalTo(self);
    }];
    [self.carType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.carColor.mas_right).offset(15*k_width);
        make.centerY.equalTo(self);
    }];
    [self.borrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.width.height.mas_equalTo(45*k_width);
    }];
    [self.rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15*k_width);
        make.width.height.mas_equalTo(30*k_width);
    }];
}
#pragma mark 懒加载

- (UIImageView *)borrowIcon{
    if (!_borrowIcon) {
        _borrowIcon =   [LXView createImageViewFrame:CGRectZero
                                                 imageName:@"borrow"
                                               isUIEnabled:YES];
    }
    return _borrowIcon;
}
- (UIButton *)rightIcon{
    if (!_rightIcon) {
        _rightIcon = [LXView createButtonWithFrame:CGRectZero
                                                            title:@""
                                                          bgColor:[UIColor clearColor]
                                                           radius:-1
                                                           target:self
                                            action:@selector(click)];
    }
    return _rightIcon;
}
- (UIImageView *)viewImage{
    if (!_viewImage) {
        _viewImage =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"platebg"
                                        isUIEnabled:YES];
    }
    return _viewImage;
}
- (UILabel *)plateNumberLabel{
    if (!_plateNumberLabel) {
        _plateNumberLabel =  [LXView createLabelWithFrame:CGRectZero
                                          text:@"沪A 88888"
                                     TextAlign:center];
        _plateNumberLabel.textColor = [UIColor whiteColor];
        _plateNumberLabel.font = [UIFont systemFontOfSize:kfontValue(18) weight:0.3];
        _plateNumberLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _plateNumberLabel;
}
- (UILabel *)owner{
    if (!_owner) {
        _owner =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"拥有人\n林育龄"
                                             TextAlign:center];
        _owner.font= [UIFont systemFontOfSize:kfontValue(11)];
        _owner.textColor = kRGBColor(135, 135, 135);
        
    }
    return _owner;
}
- (UILabel *)carColor{
    if (!_carColor) {
        _carColor =  [LXView createLabelWithFrame:CGRectZero
                                          text:@"车身颜色\n白色"
                                     TextAlign:center];
        _carColor.font= [UIFont systemFontOfSize:kfontValue(11)];
        _carColor.textColor = kRGBColor(135, 135, 135);
        
    }
    return _carColor;
}
- (UILabel *)carType{
    if (!_carType) {
        _carType =  [LXView createLabelWithFrame:CGRectZero
                                          text:@"车辆类型\n轿车"
                                     TextAlign:center];
        _carType.font= [UIFont systemFontOfSize:kfontValue(11)];
        _carType.textColor = kRGBColor(135, 135, 135);
        
       
    }
    return _carType;
}
- (void)setPlateNumberStr:(NSString *)plateNumberStr{
    self.plateNumberLabel.text = plateNumberStr;
}
- (void)setOwnerStr:(NSString *)ownerStr{
    //----------------------------------------------
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"拥有人\n%@",ownerStr]];
    _owner.text = [NSString stringWithFormat:@"拥有人\n%@",ownerStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [ [NSString stringWithFormat:@"拥有人\n%@",ownerStr] length])];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kfontValue(15)] range:[str.string rangeOfString:ownerStr] ];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str.string rangeOfString:ownerStr] ];
    _owner.attributedText = str;
    _owner.textAlignment = NSTextAlignmentCenter;
}
- (void)setCarColorStr:(NSString *)carColorStr{
    //----------------------------------------------
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"车身颜色\n%@",carColorStr]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [ [NSString stringWithFormat:@"车身颜色\n%@",carColorStr] length])];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kfontValue(15)] range:[str.string rangeOfString:carColorStr] ];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str.string rangeOfString:carColorStr] ];
    _carColor.text = [NSString stringWithFormat:@"车身颜色\n%@",carColorStr];
    _carColor.attributedText = str;
    _carColor.textAlignment = NSTextAlignmentCenter;
}
- (void)setCarTypeStr:(NSString *)carTypeStr{
    carTypeStr = kStringConvertNull(carTypeStr);
    //----------------------------------------------
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"车辆类型\n%@",carTypeStr]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [ [NSString stringWithFormat:@"车辆类型\n%@",carTypeStr] length])];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kfontValue(15)] range:[str.string rangeOfString:carTypeStr] ];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str.string rangeOfString:carTypeStr] ];
    _carType.text = [NSString stringWithFormat:@"车辆类型\n%@",carTypeStr];
    _carType.attributedText = str;
    _carType.textAlignment = NSTextAlignmentCenter;
}
- (void)didSelectClick:(LXMyVehicleCollectionViewCellBlock)block{
    _block = block;
}
- (void)click{
    
    if (_block) {
        if (_isShowRight) {
            _block();
        } 
    }
}
- (void) setIsShowRight:(bool)isShowRight{
    _isShowRight = isShowRight;
    if (isShowRight) {
        [_rightIcon setImage:[UIImage imageNamed:@"still"] forState:0];
        _rightIcon.contentMode =  UIViewContentModeScaleToFill;
    }else{
        [_rightIcon setImage:[UIImage imageNamed:@"right"] forState:0];
        _rightIcon.contentMode =  UIViewContentModeCenter;
    }
}
- (void)setIsBorrow:(bool)isBorrow{
    self.borrowIcon.hidden = !isBorrow;
}
@end
