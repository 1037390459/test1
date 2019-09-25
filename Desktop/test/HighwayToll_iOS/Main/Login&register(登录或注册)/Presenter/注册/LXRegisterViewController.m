//
//  LXRegisterViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/23.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXRegisterViewController.h"
#import "LXRegisterFinishViewController.h"
#import "LXInterface+UserCenter.h"
@interface LXRegisterViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *lastText;         /**< 上一个text */
@property (nonatomic,strong) UIButton *getCodeBtn;          /**< 获取验证码按钮 */
@property (nonatomic,strong) UIButton *loginBtn;            /**< 提交按钮 */
@property (nonatomic,strong) UILabel *descriptLabel;        /**< 描述问题 */
@end

@implementation LXRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
   配置UI
 */
- (void)configUI{
    self.title = @"注册"; 
    NSArray *titleArray = @[@"请输入手机号码",@"请输入验证码",@"请输入密码",@"请确定密码"];
    for (int i = 0; i<4; i++) {
        NSString *icon = @"";
        if (i == 0) {
            icon = @"phone";
        }else{icon = @"lock";}
        UITextField * text   =  [self createText:titleArray[i]
                                                                     icon:icon];
        text.delegate = self;
        text.tag = i;
        [self.view addSubview:text];
        UILabel    *label = [self createLabel];
        [self.view addSubview:label];
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44*k_height);
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
   
    //--------------------start-----------------
   UITextField *text = [self.view viewWithTag:1];
   text.clearButtonMode = UITextFieldViewModeNever;
    [self.view addSubview:self.getCodeBtn];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(text);
        make.right.equalTo(text);
    }];
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lastText.mas_bottom).offset(23*k_height);
        make.width.height.equalTo(self.lastText);
        make.centerX.equalTo(self.view);
    }];
    [self.view addSubview:self.descriptLabel];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(25*k_height);
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
- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn =     [LXView createButtonWithFrame:CGRectZero
                                                title:@"登录"
                                              bgColor:kRGBColor(56, 158, 61)
                                               radius:kfontValue(23)
                                               target:self
                                               action:@selector(loginClick)];
        [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(17)]];
        _loginBtn.titleLabel.textColor = [UIColor whiteColor];
    }
    return _loginBtn;
}
- (void)loginClick{

    NSString *phone = ((UITextField *)[self.view viewWithTag:0]).text;
    NSString *vcode = ((UITextField *)[self.view viewWithTag:1]).text;
//    NSString *phone = @"18221765232";
//    NSString *vcode = @"123456";
    NSString *_old_Pwd = ((UITextField *)[self.view viewWithTag:2]).text;
    NSString *_newPwd  = ((UITextField *)[self.view viewWithTag:3]).text;
    if (phone.length == 0) {
        [LXMessage showInfoMessage:@"手机号码不能为空"];
        return;
    }if (vcode.length == 0) {
        [LXMessage showInfoMessage:@"验证码不能为空"];
        return;
    }
    if (_old_Pwd.length == 0) {
        [LXMessage showInfoMessage:@"密码不能为空"];
        return;
    }if (_newPwd.length == 0) {
        [LXMessage showInfoMessage:@"密码不能为空"];
        return;
    }
    if (_newPwd != _old_Pwd) {
        [LXMessage showInfoMessage:@"两次密码不一致"];
        return;
    }
    LXWeakSelf(self);
    [LXMessage showActiveViewOnView:self.view];
    [LXNetManager postWithParamDictionary:[LXInterface postUserCenterRegisterWithVCode:vcode
                                                                             LoginName:phone
                                                                         LoginPassword:vcode]
                                 finished:^(id responseObj) {
                                     [LXMessage hideActiveView];
                                     if ([[responseObj objectForKey:@"state"] integerValue] >= 0) {
                                             LXRegisterFinishViewController *VC = [LXRegisterFinishViewController new];
                                             VC.phoneStr = phone;
                                             [weakself.navigationController pushViewController:VC animated:YES];
                                     }else{
                                         [LXMessage showInfoMessage:[responseObj objectForKey:@"msg"]];
                                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                             [weakself.navigationController popViewControllerAnimated:YES];
                                         });
                                     }
                                 }
                                   failed:^(NSError *error) {
                                       [LXMessage hideActiveView];
                                        [LXMessage showInfoMessage:error.localizedDescription];
                                   }];
}
- (UILabel *)descriptLabel{
    if (!_descriptLabel) {
        _descriptLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"点击注册代表你已阅读及同意ATC应用服务条款"
                                             TextAlign:center];
        _descriptLabel.textColor = [UIColor lightGrayColor];
        _descriptLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"点击注册代表你已阅读及同意ATC应用服务条款"];
        [str addAttribute:NSForegroundColorAttributeName value:kRGBColor(56, 158, 61) range:[str.string rangeOfString:@"应用服务条款"] ];
        _descriptLabel.attributedText = str;
    }
    return _descriptLabel;
}
- (UILabel *)createLabel{
    UILabel *label =  [LXView createLabelWithFrame:CGRectZero
                                              text:@""
                                         TextAlign:center];
    label.backgroundColor = kRGBColor(212, 212, 212);
    return label;
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
- (void)click:(UIButton *)sender{
    NSString *phone = ((UITextField *)[self.view viewWithTag:0]).text;
    if (![LXCommon isValidateMobile:phone]) {
        [LXMessage showInfoMessage:@"手机号码格式不正确"];
        return;
    }
    if (phone.length == 0) {
        [LXMessage showInfoMessage:@"手机号码不能为空"];
        return;
    }
    [sender startWithTime:60
                    title:@"获取验证码"
           countDownTitle:@"重新获取"
                mainColor:kRGBColor(86, 189, 106)
               countColor:[UIColor clearColor]];
    [LXNetManager postRequestWithParamDictionary:[LXInterface postUserCenterRegisterMobile:phone]
                                        finished:^(id responseObj) {
                                            if ([[responseObj objectForKey:@"state"] integerValue] >= 0) {
                                                
                                            }else{
                                                 [LXMessage showInfoMessage:[responseObj objectForKey:@"msg"]];
                                            }
                                        }
                                          failed:^(NSError *error) {
                                              [LXMessage showInfoMessage:error.localizedDescription];
                                          }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 3) {
        [self loginClick];
        return YES;
    } 
    return NO;
}
@end
