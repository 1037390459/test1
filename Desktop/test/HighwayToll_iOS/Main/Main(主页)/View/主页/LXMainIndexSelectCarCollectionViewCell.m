//
//  LXMainIndexSelectCarCollectionViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/4.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMainIndexSelectCarCollectionViewCell.h"
@interface LXMainIndexSelectCarCollectionViewCell()
@property (nonatomic,strong) UIImageView *plateImg;             /**< 车牌背景 */
@property (nonatomic,strong) UILabel *plateLabel;           /**< 车牌号 */
@property (nonatomic,strong) UILabel *descriptLabel;            /**< 描述 */
@property (nonatomic,strong) UIImageView *selectImg;            /**< 选择 */
@property (nonatomic,strong) UIView *bgView;                    /**< 背景图片 */
@end
@implementation LXMainIndexSelectCarCollectionViewCell
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
    
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.plateImg];
    [self.contentView addSubview:self.plateLabel];
    [self.contentView addSubview:self.descriptLabel];
    [self.contentView addSubview:self.selectImg];
    self.backgroundColor = [UIColor whiteColor];
    //----------------------开始----------------------
   [self.plateImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10*k_width);
        make.width.mas_equalTo(99*k_width);
        make.height.mas_equalTo(30*k_width);
    }];
    [self.plateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.plateImg);
    }];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.plateImg.mas_right).offset(5);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(6);
        make.bottom.equalTo(self).offset(-6);
        make.left.right.equalTo(self);
    }];
    [self.selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-12*k_width);
        make.width.height.mas_equalTo(21);
    }];
}
//-----------设置选中开始-----------
- (void)setIsSelect:(bool)isSelect{
    _isSelect = isSelect;
    //判断是不是从点击的选中类型
    if (self.isSelectType) {
        [self setSelect];
    }
}
- (void)setIsDefault:(bool)isDefault{
    
    self.descriptLabel.hidden = !isDefault;
    self.isSelect = isDefault;
    [self setSelect];
}
/**
    设置选中颜色
 */
- (void)setSelect{
    NSString *imageName = nil;
    if (self.isSelect) {
        imageName = @"Checked"; 
        _bgView.backgroundColor = kRGBColor(227, 247, 233);
        
    }else{
        imageName = @"Unchecked";
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    self.selectImg.image = [UIImage imageNamed:imageName];
}
//-----------设置选中结束-----------
- (UIImageView *)plateImg{
    if (!_plateImg) {
        _plateImg =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"platebg"
                                       isUIEnabled:YES];
    }
    return _plateImg;
}
- (UIImageView *)selectImg{
    if (!_selectImg) {
        _selectImg =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"Unchecked"
                                        isUIEnabled:YES];
    }
    return _selectImg;
}
- (UILabel *)descriptLabel{
    if (!_descriptLabel) {
        _descriptLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"默认"
                                             TextAlign:center];
        _descriptLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
        _descriptLabel.hidden = YES;
    }
    return _descriptLabel;
}
- (UILabel *)plateLabel{
    if (!_plateLabel) {
        _plateLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@" 沪A 88888 "
                                             TextAlign:center];
        _plateLabel.textColor = [UIColor whiteColor];
        _plateLabel.font = [UIFont systemFontOfSize:kfontValue(15) weight:0.3];
        _plateLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _plateLabel;
}
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [LXView createViewWithFrame:CGRectZero
                                      bgColor:[UIColor whiteColor]
                                       radius:-1];
    }
    return _bgView;
}
- (void)setPlateStr:(NSString *)plateStr{
    self.plateLabel.text = plateStr;
}
@end
