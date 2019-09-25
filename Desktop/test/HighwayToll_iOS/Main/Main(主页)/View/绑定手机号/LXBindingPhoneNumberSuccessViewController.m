//
//  LXBindingPhoneNumberSuccessViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/27.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXBindingPhoneNumberSuccessViewController.h"

@interface LXBindingPhoneNumberSuccessViewController ()
@property (nonatomic,strong) UIImageView *logoImage;             /**< logo */
@property (nonatomic,strong) UILabel *bingStatusLabel;                /**< 绑定成功信息 */
@property (nonatomic,strong) UILabel *descriptLabel;             /**< 描述 */
@property (nonatomic,strong) UIButton *commitBtn;                /**< 提交按钮 */
@end

@implementation LXBindingPhoneNumberSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

/**
    配置UI
 */
- (void)configUI{
    self.title = @"绑定手机号码";
    [self.view addSubview:self.logoImage];
    [self.view addSubview:self.bingStatusLabel];
    [self.view addSubview:self.descriptLabel];
    [self.view addSubview:self.commitBtn];
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(130*k_width*0.65);
        make.height.mas_equalTo(130*k_width);
        make.top.equalTo(self.view).offset((kNavHeight+45)*k_height);
        make.centerX.equalTo(self.view);
    }];
    [self.bingStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImage.mas_bottom).offset(22*k_height);
        make.centerX.equalTo(self.view);
    }];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bingStatusLabel);
        make.top.equalTo(self.bingStatusLabel.mas_bottom).offset(25*k_height);
    }];
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kCellHeight);
        make.width.mas_equalTo(self.view.width *0.8);
        make.top.equalTo(self.descriptLabel.mas_bottom).offset(44*k_height);
        make.centerX.equalTo(self.view);
    }];
}
#pragma mark 描述
- (UIImageView *)logoImage{
    if (!_logoImage) {
        _logoImage =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"bindPhone"
                                        isUIEnabled:YES];
        [_logoImage setContentMode:UIViewContentModeScaleToFill]; 
    }
    return _logoImage;
}
- (UILabel *)bingStatusLabel{
    if (!_bingStatusLabel) {
        _bingStatusLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"手机号码绑定成功！"
                                             TextAlign:center];
        _bingStatusLabel.textColor = kRGBColor(49, 156, 77);
        _bingStatusLabel.font = [UIFont systemFontOfSize:kfontValue(23)];
    }
    return _bingStatusLabel;
}
- (UILabel *)descriptLabel{
    if (!_descriptLabel) {
        _descriptLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"您的手机号码：15888888888\n手机号可用于登录及找回密码"
                                             TextAlign:center];
        _descriptLabel.textColor = kRGBColor(135, 135, 135);
        _descriptLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
        //----------------------富文本-------------------
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"您的手机号码：15888888888\n手机号可用于登录及找回密码"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str.string rangeOfString:@"您的手机号码："]];
        [str addAttribute:NSForegroundColorAttributeName value:kRGBColor(94, 176, 116) range:[str.string rangeOfString:@"15888888888"]];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
        _descriptLabel.attributedText = str;
        //----------------------end---------------------
    }
    return _descriptLabel;
}
- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn =     [LXView createButtonWithFrame:CGRectZero
                                                  title:@"完成"
                                                bgColor:[UIColor clearColor]
                                                 radius:kfontValue(23)
                                                 target:self
                                                 action:@selector(click)];
        [_commitBtn setTitleColor:kRGBColor(49, 156, 77) forState:0];
        _commitBtn.borderColor = kRGBColor(49, 156, 77).CGColor;
        _commitBtn.borderWidth = 1;
        
    }
    return _commitBtn;
}
- (void)click{
    
}
@end
