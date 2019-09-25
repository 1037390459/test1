//
//  LXSettingCommitCollectionViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXSettingCommitCollectionViewCell.h"
@interface LXSettingCommitCollectionViewCell()
@property (nonatomic,strong) UIButton *commitBtn;     /**< 提交按钮 */
@end
@implementation LXSettingCommitCollectionViewCell
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
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kWidth*0.75);
        make.height.mas_equalTo(kCellHeight);
        make.center.equalTo(self);
    }];
}
//---------- 按钮-------------
- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn =     [LXView createButtonWithFrame:CGRectZero
                                                 title:@"退出登录"
                                               bgColor:kRGBColor(56, 158, 61)
                                                radius:kfontValue(25)
                                                target:self
                                                action:@selector(commitBtnClick)];
        [_commitBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(18)]];
        _commitBtn.titleLabel.textColor = [UIColor whiteColor];
    }
    return _commitBtn;
}
- (void)commitBtnClick{
    if (_block) {
        _block();
    }
}
- (void)didSelectClick:(LXSettingCommitCollectionViewCellBlock)block{
    _block = block;
}
@end
