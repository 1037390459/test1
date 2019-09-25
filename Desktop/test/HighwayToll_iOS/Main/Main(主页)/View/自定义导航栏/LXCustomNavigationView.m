//
//  LXCustomNavigationView.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/5.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXCustomNavigationView.h"
@interface LXCustomNavigationView()
@property (nonatomic,strong) UIButton *backBtn;   /**<  */
@property (nonatomic,strong) UILabel  *titleLable; /**<  */
@property (nonatomic,strong) UIButton *gonlu; /**<  */
@property (nonatomic,strong) UIImageView *img; /**<  */
@end
@implementation LXCustomNavigationView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI{
    self.backgroundColor = kRGBColor(30, 52, 124);
    UIButton *backBtn = [LXView createButtonWithFrame:CGRectZero
                                                title:@""
                                            imageName:@""
                                          bgImageName:@""
                                               radius:-1
                                               target:self
                                               action:@selector(click)
                                                color:nil];
    [self addSubview:self.img];
    [self addSubview:backBtn];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(self.mas_bottom).offset(-13);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(21);
    }];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(self.mas_bottom).offset(-13);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLable.text = @"路政公告";
    titleLable.font = [UIFont systemFontOfSize:kfontValue(18)];
    titleLable.textColor = [UIColor whiteColor];
    [self addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.img.mas_top).offset(-1);
    }];
    UIButton *gonlu = [LXView createButtonWithFrame:CGRectZero title:@"" imageName:@"" bgImageName:@"gonglu" radius:-1 target:self action:nil color:nil] ; [self addSubview:gonlu];
    [gonlu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(19);
        make.height.mas_equalTo(25);
        make.right.equalTo(self).offset(-15*k_width);
        make.centerY.equalTo(self.img);
    }];
}
- (UIImageView *)img{
    if (!_img) {
        _img =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"backwhite"
                                  isUIEnabled:YES];
    }
    return _img;
}
- (void)click{
    if(_block){
        _block();
    }
}
- (void)didSelectClick:(LXCustomNavigationViewBlock)block{
    _block = block;
}
@end
