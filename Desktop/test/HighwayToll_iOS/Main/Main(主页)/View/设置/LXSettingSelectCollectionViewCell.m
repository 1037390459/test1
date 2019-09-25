//
//  LXSettingSelectCollectionViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXSettingSelectCollectionViewCell.h"
@interface LXSettingSelectCollectionViewCell()
@property (nonatomic,strong) UILabel *titleLabel;     /**< 名称 */
@property (nonatomic,strong) UISwitch *selectSwitch;  /**< 选择 */
@end
@implementation LXSettingSelectCollectionViewCell
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
    [self.contentView addSubview:self.selectSwitch];
    //----------------------------------------------
    self.backgroundColor = [UIColor whiteColor];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.centerY.equalTo(self);
    }];
    [self.selectSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15*k_width);
        make.centerY.equalTo(self); 
    }];
    //
    [self layoutIfNeeded];
    self.selectSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
}
#pragma mark 懒加载
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =  [LXView createLabelWithFrame:CGRectZero
                                               text:@"语音提示"
                                          TextAlign:center]; 
        _titleLabel.font      = [UIFont systemFontOfSize:kfontValue(15)];
    }
    return _titleLabel;
}
- (UISwitch *)selectSwitch{
    if (!_selectSwitch) {
        _selectSwitch =  [[UISwitch alloc] init];
        [_selectSwitch addTarget:self action:@selector(click:) forControlEvents:UIControlEventValueChanged];
    }
    return _selectSwitch;
}
- (void)click:(UISwitch *)sender{
    if (_block) {
        _block(sender.isOn);
    }
}
- (void)switchClick:(LXSettingSelectCollectionViewCellBlock)block{
    _block = block;
}
- (void)setTitleStr:(NSString *)titleStr{
    self.titleLabel.text = titleStr;
}
@end
