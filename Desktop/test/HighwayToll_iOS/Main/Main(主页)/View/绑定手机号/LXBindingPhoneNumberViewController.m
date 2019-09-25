//
//  LXBindingPhoneNumberViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/27.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXBindingPhoneNumberViewController.h"
#import "LXBindingPhoneNumberSuccessViewController.h"
@interface LXBindingPhoneNumberViewController ()
@property (nonatomic,strong) UITextField *lastText;                    /**< 上一个text */
@property (nonatomic,strong) UILabel *line1;                           /**< 线1 */
@property (nonatomic,strong) UILabel *line2;                           /**< 线2 */
@property (nonatomic,strong) UITextField *phoneText;                   /**< 电话文本框 */
@property (nonatomic,strong) UITextField *codeText;                    /**< 密码文本框 */
@property (nonatomic,strong) UIButton *getCodeBtn;                     /**< 获取验证码 */
@property (nonatomic,strong) UIButton *nextBtn;                        /**< 下一步 */
@end

@implementation LXBindingPhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

//配置UI
- (void)configUI{
    self.title = @"绑定手机号";
    NSArray *titleArray = @[@"请输入手机号码",@"请输入验证码"];
    for (int i = 0; i<titleArray.count; i++) {
        NSString *icon = @"";
        if (i == 0) {
            icon = @"phone";
        }else{icon = @"lock";}
        UITextField * text   =  [self createText:titleArray[i]
                                            icon:icon];
        text.tag = i;
        [self.view addSubview:text];
        UILabel    *label = [self createLabel];
        [self.view addSubview:label];
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44*k_height);
            //            make.width.mas_equalTo(kWidth*0.8);
            make.right.equalTo(self.view).offset(-35*k_width);
            make.left.equalTo(self.view).offset(35*k_width);
            make.centerX.equalTo(self.view);
            if (i == 0) {
                make.top.equalTo(self.view).offset(64+30*k_height);
            }else{
                make.top.equalTo(self.lastText.mas_bottom).offset(5);
            }
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.right.left.equalTo(text);
            make.height.mas_equalTo(0.5);
            make.top.equalTo(text.mas_bottom);
        }];
        self.lastText = text;
    }
    //---------------------------------------
    UITextField *text = [self.view viewWithTag:1];
    [self.view addSubview:self.getCodeBtn];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(text);
        make.right.equalTo(text);
    }];
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lastText.mas_bottom).offset(23*k_height);
        make.width.height.equalTo(self.lastText);
        make.centerX.equalTo(self.view);
    }];
    
}
//--------------------创建空间---------------------
- (UITextField *)createText:(NSString *)placeholder icon:(NSString *)icon{
    UITextField * text   =  [LXView createTextFieldWithFrame:CGRectZero
                                                 placeholder:placeholder
                                                 bgImageName:nil
                                                    leftView:[LXView createImageViewFrame:CGRectMake(3, 0, 20, 20)
                                                                                imageName:icon
                                                                              isUIEnabled:YES]
                                                   rightView:nil
                                                  isPassWord:NO
                                                    delegate:self];
    text.font = [UIFont systemFontOfSize:kfontValue(14)];
    text.borderStyle = UITextBorderStyleNone;;
    return text;
}
- (UIButton *)getCodeBtn{
    if (!_getCodeBtn) {
        _getCodeBtn =     [LXView createButtonWithFrame:CGRectZero
                                                  title:@"获取验证码"
                                                bgColor:[UIColor clearColor]
                                                 radius:-1
                                                 target:self
                                                 action:@selector(click:)];
        [_getCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(13)]];
        [_getCodeBtn setTitleColor:kRGBColor(86, 189, 106) forState:UIControlStateNormal];
    }
    return _getCodeBtn;
}
- (UILabel *)createLabel{
    UILabel *label =  [LXView createLabelWithFrame:CGRectZero
                                              text:@""
                                         TextAlign:center];
    label.backgroundColor = kRGBColor(212, 212, 212);
    return label;
}
- (void)click:(UIButton *)sender{
    [sender startWithTime:60
                    title:@"获取验证码"
           countDownTitle:@"重新获取"
                mainColor:kRGBColor(86, 189, 106)
               countColor:[UIColor clearColor]];
}
- (UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn =     [LXView createButtonWithFrame:CGRectZero
                                               title:@"立即绑定"
                                             bgColor:kRGBColor(56, 158, 61)
                                              radius:kfontValue(23)
                                              target:self
                                              action:@selector(loginClick)];
        [_nextBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(17)]];
        _nextBtn.titleLabel.textColor = [UIColor whiteColor];
    }
    return _nextBtn;
}
- (void)loginClick{
    LXBindingPhoneNumberSuccessViewController *VC = [LXBindingPhoneNumberSuccessViewController new];
    [self.navigationController pushViewController:VC animated:YES];
}
@end
