//
//  LXUserCenterUserNameCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/28.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXUserCenterUserNameCell.h"
@interface LXUserCenterUserNameCell()
@property (nonatomic,strong) UIButton *userNameBtn;               /**< 用户管理 */
@property (nonatomic,strong) UIButton *updateBtn;                 /**< 修改按钮 */
@end
@implementation LXUserCenterUserNameCell
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
    //[self.contentView addSubview:self.userNameBtn];
    [self.contentView addSubview:self.headImage];
    //[self.contentView addSubview:self.updateBtn];
    
    //------------------开始--------------------
//    [self.userNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(15*k_width);
//        make.centerY.equalTo(self);
//    }];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self.height *0.8);
        make.right.equalTo(self).offset(-15*k_width);
        make.centerY.equalTo(self);
    }];
//    [self.updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.userNameBtn.mas_right).offset(3);
//        make.centerY.equalTo(self.userNameBtn).offset(2);
//        make.width.height.mas_equalTo(23);
//    }];
    //------------------结束--------------------
//    [self layoutIfNeeded];
//    [_userNameBtn horizontalCenterTitleAndImage:1];
}
#pragma mark 懒加载
- (UIButton *)userNameBtn{
    if (!_userNameBtn) {
        _userNameBtn =     [LXView createButtonWithFrame:CGRectZero
                                                  title:@""
                                              imageName:@""
                                            bgImageName:@""
                                                 radius:-1
                                                 target:self
                                                 action:@selector(click)
                                                  color:kRGBColor(2, 151, 62)];
        [_userNameBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(28)]];
        
    }
    return _userNameBtn;
}
- (UIButton *)updateBtn{
    if (!_updateBtn) {
        _updateBtn =     [LXView createButtonWithFrame:CGRectZero
                                                   title:@""
                                               imageName:@""
                                             bgImageName:@"update"
                                                  radius:-1
                                                  target:self
                                                  action:@selector(click)
                                                   color:kRGBColor(2, 151, 62)];
    }
    return _updateBtn;
}
- (void)click{
    
}
- (UIButton *)headImage{
    if (!_headImage) {
        _headImage =   [LXView createButtonWithFrame:CGRectZero
                                               title:nil
                                           imageName:nil
                                         bgImageName:@"default"
                                              radius:-1
                                              target:self
                                              action:@selector(uploadClick)
                                               color:nil];
    }
    return _headImage;
}
- (void)uploadClick{
    if (_block) {
        _block();
    }
}
- (void)setUserName:(NSString *)userName{
    if (userName.length == 0) {
        userName = @"昵称/微信昵称";
    }
    [self.userNameBtn setTitle:userName forState:0];
}
- (void)UpLoadPic:(LXUserCenterUserNameCellBlock)block{
    _block = block;
}
@end
