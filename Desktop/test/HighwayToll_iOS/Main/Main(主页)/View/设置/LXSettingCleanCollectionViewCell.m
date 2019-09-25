//
//  LXSettingCleanCollectionViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXSettingCleanCollectionViewCell.h"
@interface LXSettingCleanCollectionViewCell()
@property (nonatomic,strong) UILabel *titleLable;                  /**< 名称 */ 
@property (nonatomic,strong) UIImageView *rightImg;                /**< 右边logog */
@property (nonatomic,strong) UILabel  *descriptLabel;              /**< 描述 */
@end
@implementation LXSettingCleanCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI{
    [self.contentView addSubview:self.titleLable ];
    [self.contentView addSubview:self.rightImg ];
    [self.contentView addSubview:self.descriptLabel];
    //-------------------------------------------
    self.backgroundColor = [UIColor whiteColor];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.centerY.equalTo(self);
    }];
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15*k_width);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(17);
        make.height.mas_equalTo(20);
    }];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightImg.mas_left).offset(-6*k_width);
        make.centerY.equalTo(self);
    }];
}
#pragma mark 懒加载
- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable =  [LXView createLabelWithFrame:CGRectZero
                                               text:@"投诉于建议"
                                          TextAlign:center]; 
        _titleLable.font      = [UIFont systemFontOfSize:kfontValue(15)];
    }
    return _titleLable;
}
- (UIImageView *)rightImg{
    if (!_rightImg) {
        _rightImg =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"remove"
                                       isUIEnabled:YES];
    }
    return _rightImg;
}
- (UILabel *)descriptLabel{
    if (!_descriptLabel) {
        _descriptLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"10.4M"
                                             TextAlign:center];
        _descriptLabel.font      = [UIFont systemFontOfSize:kfontValue(15)];
    }
    return _descriptLabel;
}
- (void)setTitleStr:(NSString *)titleStr{
    self.titleLable.text = titleStr;
}
- (void)setContentStr:(NSString *)contentStr{
    self.descriptLabel.text = contentStr;
}
@end
