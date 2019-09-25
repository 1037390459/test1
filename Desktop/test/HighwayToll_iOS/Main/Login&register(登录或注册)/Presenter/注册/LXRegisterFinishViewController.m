//
//  LXRegisterFinishViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/23.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXRegisterFinishViewController.h"

@interface LXRegisterFinishViewController ()
@property (nonatomic,strong) UIImageView *logoImageView;    /**< logo */
@property (nonatomic,strong) UILabel *finishTipLabel;       /**< 完成label */
@property (nonatomic,strong) UILabel *descriptLabel;        /**< 描述问题 */
@property (nonatomic,strong) UIButton *finishBtn;           /**< 完成按钮 */
@end

@implementation LXRegisterFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configUI{
    self.title = @"注册完成";
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.finishTipLabel];
    [self.view addSubview:self.finishBtn];
    [self.view addSubview:self.descriptLabel];
    //------------------start-------------------
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.width.mas_equalTo(kWidth *0.25);
        make.top.equalTo(self.view).offset(64+k_height*125);
    }];
    [self.finishTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView.mas_bottom).offset(38*k_height);
        make.centerX.equalTo(self.view);
    }];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.finishTipLabel.mas_bottom).offset(15*k_height);
        make.centerX.equalTo(self.view);
    }];
    [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descriptLabel.mas_bottom).offset(30*k_height);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(44*k_height);
        make.width.mas_equalTo(kWidth*0.8);
    }];
    //------------------end---------------------
    
}
#pragma mark 懒加载
- (UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView =   [LXView createImageViewFrame:CGRectZero
                                              imageName:@"successlogo"
                                            isUIEnabled:YES];
    }
    return _logoImageView;
}
- (UILabel *)finishTipLabel{
    if (!_finishTipLabel) {
        _finishTipLabel =  [LXView createLabelWithFrame:CGRectZero
                                          text:@"恭喜你，注册成功 ！"
                                     TextAlign:center];
        _finishTipLabel.font = [UIFont systemFontOfSize:kfontValue(22)];
        _finishTipLabel.textColor = kRGBColor(86, 189, 106);
    }
    return _finishTipLabel;
}
- (UILabel *)descriptLabel{
    if (!_descriptLabel) {
        _descriptLabel =  [LXView createLabelWithFrame:CGRectZero
                                          text:@"您的ATC登录账号为：15888888888"
                                     TextAlign:center];
        _descriptLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
    }
    return _descriptLabel;
}
- (UIButton *)finishBtn{
    if (!_finishBtn) {
        _finishBtn =     [LXView createButtonWithFrame:CGRectZero
                                                  title:@"完成"
                                                bgColor:[UIColor clearColor]
                                                 radius:kfontValue(23)
                                                 target:self
                                                 action:@selector(click:)];
        _finishBtn.borderWidth = 0.5;
        _finishBtn.borderColor = kRGBColor(86, 189, 106).CGColor;
        [_finishBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(17)]];
        [_finishBtn setTitleColor:kRGBColor(86, 189, 106) forState:UIControlStateNormal];
    }
    return _finishBtn;
}
- (void)click:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)setPhoneStr:(NSString *)phoneStr{
    _phoneStr = phoneStr;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"您的ATC登录账号为：%@",phoneStr]];
    [str addAttribute:NSForegroundColorAttributeName value:kRGBColor(56, 158, 61) range:[str.string rangeOfString:phoneStr] ];
    _descriptLabel.attributedText = str;
}
@end
