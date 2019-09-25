//
//  LXMainIndexCommitCollectionViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/4.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMainIndexCommitCollectionViewCell.h"
@interface LXMainIndexCommitCollectionViewCell()
@property (nonatomic,strong) UIButton *leftBtn;                        /**< 左边按钮 */
@property (nonatomic,strong) UIButton *rightBtn;                       /**< 右边按钮 */
@property (nonatomic,strong) UIButton *commitBtn;                      /**< 提交按钮 */
@end
@implementation LXMainIndexCommitCollectionViewCell
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
    [self addSubview:self.commitBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.leftBtn]; 
    //----------------------------------------
   
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(150*k_width);
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(35*k_height);
    }];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.commitBtn);
        make.right.equalTo(self.commitBtn.mas_left).offset(-6);
        make.width.height.mas_equalTo(57*k_width);
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.commitBtn);
        make.left.equalTo(self.commitBtn.mas_right).offset(6);
        make.width.height.mas_equalTo(57*k_width);
    }];
}
- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn =     [LXView createButtonWithFrame:CGRectZero
                                               title:@""
                                           imageName:@""
                                         bgImageName:@"goAwayLeft"
                                              radius:-1
                                              target:self
                                              action:@selector(click:)
                                               color:nil];
        _leftBtn.tag = 0;
        
    }
    return _leftBtn;
}
- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn =     [LXView createButtonWithFrame:CGRectZero
                                                title:@""
                                            imageName:@""
                                          bgImageName:@"goAwayRight"
                                               radius:-1
                                               target:self
                                               action:@selector(click:)
                                                color:nil];
        _rightBtn.tag = 2;
        
    }
    return _rightBtn;
}
- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn =      [LXView createButtonWithFrame:CGRectZero
                                                  title:@""
                                              imageName:@""
                                            bgImageName:@"goAwayCenterBtn"
                                                 radius:-1
                                                 target:self
                                                 action:@selector(click:)
                                                  color:nil];
        _commitBtn.tag = 1;
    }
    return _commitBtn;
}
- (void)click:(UIButton *)sender{
   
    if (_block) {
        _block(sender.tag);
    }
}
- (void)didSelectCommitClick:(LXMainIndexCommitCollectionViewCellBlock)block{
    _block = block;
}
@end
