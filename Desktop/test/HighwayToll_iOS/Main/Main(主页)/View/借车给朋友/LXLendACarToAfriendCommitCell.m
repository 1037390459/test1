//
//  LXLendACarToAfriendCommitCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/27.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXLendACarToAfriendCommitCell.h"
@interface LXLendACarToAfriendCommitCell()
@property (nonatomic,strong) UIButton *commitBtn;                           /**< 提交按钮 */
@property (nonatomic,strong) UILabel *descriptLabel;                        /**< 描述 */
@end
@implementation LXLendACarToAfriendCommitCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI{
    [self.contentView addSubview:self.commitBtn];
    [self.contentView addSubview:self.descriptLabel];
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(16*k_height);
        make.width.mas_equalTo(kWidth*0.8);
        make.height.mas_equalTo(44*k_height);
        make.centerX.equalTo(self);
    }];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.commitBtn);
        make.top.equalTo(self.commitBtn.mas_bottom).offset(16*k_width);
    }];
}
#pragma mark 懒加载
- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn =     [LXView createButtonWithFrame:CGRectZero
                                                title:@"确定借出"
                                              bgColor:kRGBColor(56, 158, 61)
                                               radius:kfontValue(23)
                                               target:self
                                               action:@selector(loginClick)];
        [_commitBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(17)]];
        _commitBtn.titleLabel.textColor = [UIColor whiteColor];
    }
    return _commitBtn;
}
- (void)loginClick{ 
    if (_block) {
        _block();
    }
}
- (UILabel *)descriptLabel{
    if (!_descriptLabel) {
        _descriptLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"请确保正确填写借车人的手机号码，否则会操作失败"
                                             TextAlign:center];
        _descriptLabel.numberOfLines = 0;
        [_descriptLabel setFont:[UIFont systemFontOfSize:kfontValue(13)]];
        _descriptLabel.textColor = kRGBColor(103, 103, 103);
    }
    return _descriptLabel;
}
- (void)didSelectClick:(LXLendACarToAfriendCommitCellBlock )block{
    _block = block;
}
- (void)setDescrioptStr:(NSString *)descrioptStr{
    _descrioptStr = descrioptStr;
    _descriptLabel.text = descrioptStr;
}
@end
