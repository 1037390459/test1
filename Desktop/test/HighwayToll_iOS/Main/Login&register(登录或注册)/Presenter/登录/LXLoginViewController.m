//
//  LXLoginViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/23.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXLoginViewController.h"
#import "LXRegisterViewController.h"                /**<注册控制器*/
#import "LXUserInfoModel.h"                         /**<用户模型*/
#import "LXPasswordRetrievalViewController.h"       /**<找回密码*/
#import "LXInterface+UserCenter.h"
#import "LXPasswordRetrievalViewController.h"
@interface LXLoginViewController ()<UITextFieldDelegate>
@property (nonatomic,assign) bool isPwdLogin;               /**< 是不是账号密码登录*/
@property (nonatomic,strong) UIImageView *logoImageView;    /**< logo */
@property (nonatomic,strong) UITextField *phoneText;        /**< 手机号码 */
@property (nonatomic,strong) UITextField *codeText;         /**< 验证码 */
@property (nonatomic,strong) UIButton *getCodeBtn;          /**< 获取验证码按钮 */
@property (nonatomic,strong) UIButton *loginBtn;            /**< 提交按钮 */
@property (nonatomic,strong) UIButton *accountLoginBtn;     /**< 账号或者密码登录 */
@property (nonatomic,strong) UILabel *descriptLabel;        /**< 描述问题 */
@property (nonatomic,strong) UIButton *weChatLogin;         /**< 微信登录 */
@property (nonatomic,strong) UILabel *line1;                /**< 线1 */
@property (nonatomic,strong) UILabel *line2;                /**< 线2 */
@property (nonatomic,strong) UIButton *forgetPWDBtn;        /**< 忘记密码 */
@property (nonatomic,strong) UIButton *rightBtn;            /**< 右边小按钮 */
@property (nonatomic,strong) UIButton *rightIcon;           /**<  */ 
@property (nonatomic,strong) NSString *vCode;                          /**< 验证码 */
@end

@implementation LXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self configUI];
    self.fd_prefersNavigationBarHidden = YES;
}
- (void)keyboardWillChange:(NSNotification *)note
{
    NSDictionary *userInfo = note.userInfo;
    CGFloat duration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];

    CGRect keyFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat moveY = keyFrame.origin.y - self.view.frame.size.height;//这个64是我减去的navigationbar加上状态栏20的高度,可以看自己的实际情况决定是否减去;

    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, moveY);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
- (void)goRegister{
    DLog(@"点击我了");
}
#pragma mark 配置UI
- (void)configUI{
    self.isPwdLogin = NO;
    UIImageView *img =  [[UIImageView alloc] initWithFrame:self.view.frame];
    img.image = [UIImage imageNamed:@"background"];
    [self.view addSubview:img];
    [self.view addSubview:self.rightBtn];
    [self.view addSubview:self.rightIcon];
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.phoneText];
    [self.view addSubview:self.codeText];
    [self.view addSubview:self.getCodeBtn];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.accountLoginBtn];
    [self.view addSubview:self.descriptLabel];
    [self.view addSubview:self.weChatLogin];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.forgetPWDBtn];
    //---------------布局------------------
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-25);
        if (IPHONE_X) {
            make.top.equalTo(self.view).offset(45);
        }else{
            make.top.equalTo(self.view).offset(25);
        }
    }];
    [self.rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rightBtn);
        make.left.equalTo(self.rightBtn.mas_right);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(15);
    }];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(143.5*k_width);
        make.height.mas_equalTo(143.5/2*k_width);
        make.top.equalTo(self.view).offset(64+50*k_height);
    }];
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kWidth*0.8);
        make.height.mas_equalTo(44*k_height);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.logoImageView.mas_bottom).offset(100*k_height);
    }];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(self.phoneText);
        make.top.equalTo(self.phoneText.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(self.phoneText);
        make.top.equalTo(self.codeText.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    [self.codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerX.equalTo(self.phoneText);
        make.top.equalTo(self.phoneText.mas_bottom).offset(5);
    }];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.codeText);
        make.centerY.equalTo(self.codeText);
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeText.mas_bottom).offset(23*k_height);
        make.width.height.equalTo(self.codeText);
        make.centerX.equalTo(self.view);
    }];
    [self.accountLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(20*k_height);
        make.right.equalTo(self.loginBtn);
    }];
    [self.forgetPWDBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(20*k_height);
        make.left.equalTo(self.loginBtn);
    }];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountLoginBtn).offset(55*k_height);
        make.centerX.equalTo(self.view);
    }];
    [self.weChatLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.width.mas_equalTo(44);
        make.top.equalTo(self.descriptLabel.mas_bottom).offset(20*k_height);
    }];
    [self.view.layer setContents:(id _Nullable)[UIImage imageNamed:@"loginbackground"].CGImage];
    //---------------end------------------
    [self.rightBtn horizontalCenterTitleAndImage:1];
}
#pragma mark 懒加载
- (UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView =   [LXView createImageViewFrame:CGRectZero
                                              imageName:@"loginLogo"
                                            isUIEnabled:YES];
    }
    return _logoImageView;
}
- (UITextField *)phoneText{
    if (!_phoneText) {
        _phoneText =  [LXView createTextFieldWithFrame:CGRectZero
                                           placeholder:@"请输入手机号"
                                           bgImageName:nil
                                              leftView:[LXView createImageViewFrame:CGRectMake(3, 0, 20, 20)
                                                                          imageName:@"phone"
                                                                        isUIEnabled:YES]
                                             rightView:nil
                                            isPassWord:NO
                                              delegate:self];
        _phoneText.font = [UIFont systemFontOfSize:kfontValue(14)];
        _phoneText.borderStyle = UITextBorderStyleNone;
    }
    return _phoneText;
}
- (UITextField *)codeText{
    if (!_codeText) {
        _codeText =  [LXView createTextFieldWithFrame:CGRectZero
                                           placeholder:@"请输入验证码"
                                           bgImageName:nil
                                              leftView:[LXView createImageViewFrame:CGRectMake(3, 0, 20, 20)
                                                                         imageName:@"lock"
                                                                       isUIEnabled:YES]
                                             rightView:nil
                                            isPassWord:NO
                                              delegate:self];
        _codeText.font = [UIFont systemFontOfSize:kfontValue(14)];
        _codeText.borderStyle = UITextBorderStyleNone;
        _codeText.clearButtonMode = UITextFieldViewModeNever;
        _codeText.delegate = self;
    }
    return _codeText;
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
    LXWeakSelf(self);
    NSString *phoneText =  self.phoneText.text;
    if (phoneText.length == 0) {
        [LXMessage showErrorMessage:@"手机号码不能为空"];
        return;
    }
    if (![LXCommon isValidateMobile:phoneText]) {
        [LXMessage showErrorMessage:@"手机号码格式不正确"];
        return;
    }
    [LXNetManager postRequestWithParamDictionary:[LXInterface
                                                  postUserCenterVCode_Login:@"18221765232"]
                                        finished:^(id responseObj) {
                                            if ([[responseObj objectForKey:@"state"] integerValue] >= 0) {
                                                [sender startWithTime:60
                                                                title:@"获取验证码"
                                                       countDownTitle:@"重新获取"
                                                            mainColor:kRGBColor(86, 189, 106)
                                                           countColor:[UIColor clearColor]];
                                                [LXMessage showSuccessMessage:@"发送成功,请稍后"];
                                                weakself.vCode = [responseObj objectForKey:@"data"];
                                            }else{
                                                [LXMessage showSuccessMessage:@"发送失败"];
                                            }
                                        }
                                          failed:^(NSError *error) {
                                              [LXMessage showErrorMessage:error.localizedDescription];
                                          }];
    
//    [sender startWithTime:60
//                    title:@"获取验证码"
//           countDownTitle:@"重新获取"
//                mainColor:kRGBColor(86, 189, 106)
//               countColor:[UIColor clearColor]];
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
    NSString *phone = self.phoneText.text;
    NSString *vcode = self.codeText.text;
    if (phone.length == 0) {
        [LXMessage showSuccessMessage:@"手机号码不能为空"];
        return;
    }
    if (![LXCommon isValidateMobile:phone]) {
        [LXMessage showSuccessMessage:@"手机号码格式不正确"];
        return;
    }
    if (self.isPwdLogin) {
        
        if (vcode.length == 0) {
            [LXMessage showSuccessMessage:@"验证码不能为空"];
            return;
        }
        NSString *pwd = [vcode sha1Encode];
        NSString *encode = [NSString stringWithFormat:@"%@%@%@",phone,pwd,[LXDate getNowTimeTimestamp]];
        encode = [encode sha1Encode];
        [LXMessage showActiveViewOnView:self.view];
        [LXNetManager postRequestWithParamDictionary:[LXInterface postUserCenterLogin:phone
                                                                            timeStamp:[LXDate getNowTimeTimestamp]
                                                                                 sign:encode]
                                            finished:^(id responseObj) {
                                                [LXMessage hideActiveView];
                                                 [self successStatus:responseObj];
                                            }
                                              failed:^(NSError *error) {
                                                  [LXMessage hideActiveView];
                                                  [LXMessage showErrorMessage:error.localizedDescription];
                                              }];
    }else{
        if (vcode.length == 0) {
            [LXMessage showSuccessMessage:@"密码不能为空"];
            return;
        }
        [LXMessage showActiveViewOnView:self.view];
        [LXNetManager postRequestWithParamDictionary:[LXInterface postUserCenterLoginWithVCode:phone
                                                                                         vcode:vcode]
                                            finished:^(id responseObj) {
                                                [LXMessage hideActiveView];
                                                [self successStatus:responseObj];
                                            }
                                              failed:^(NSError *error) {
                                                  [LXMessage hideActiveView];
                                                  [LXMessage showErrorMessage:error.localizedDescription];
                                              }];
        
    }
}

/**
  成功调用
 */
- (void)successStatus:(id)responseObj{
    if ([[responseObj objectForKey:@"state"] intValue] >= 1) {
        [LXMessage showSuccessMessage:@"登录成功"];
        LXUserInfoModel *model = [[LXUserInfoModel shareUser] initWithDictionary:[responseObj objectForKey:@"data"]];
        model.isLogin = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[AppDelegate shareInstance] enterRootViewController:YES];
        });
    }else{
        [LXMessage showSuccessMessage:[responseObj objectForKey:@"msg"]];
    }
}
- (UIButton *)accountLoginBtn{
    if (!_accountLoginBtn) {
        _accountLoginBtn =     [LXView createButtonWithFrame:CGRectZero
                                                  title:@"账号密码输登录"
                                                bgColor:[UIColor clearColor]
                                                 radius:-1
                                                 target:self
                                                 action:@selector(accountLoginClick)];
        [_accountLoginBtn setTitleColor:kRGBColor(86, 189, 106) forState:UIControlStateNormal];
        [_accountLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(13)]];
        
    }
    return _accountLoginBtn;
}
- (UIButton *)forgetPWDBtn{
    if (!_forgetPWDBtn) {
        _forgetPWDBtn =     [LXView createButtonWithFrame:CGRectZero
                                                       title:@"忘记密码？"
                                                     bgColor:[UIColor clearColor]
                                                      radius:-1
                                                      target:self
                                                      action:@selector(forgetPWDClick)];
        [_forgetPWDBtn setTitleColor:kRGBColor(86, 189, 106) forState:UIControlStateNormal];
        [_forgetPWDBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(13)]];
        
    }
    return _forgetPWDBtn;
}
- (void)forgetPWDClick{
    LXPasswordRetrievalViewController *VC = [LXPasswordRetrievalViewController new ];
    [self.navigationController pushViewController:VC animated:YES];
}
- (void)accountLoginClick{
    self.isPwdLogin = !self.isPwdLogin;
    if (self.isPwdLogin) {
        self.getCodeBtn.hidden = YES;
        self.codeText.placeholder = @"请输入手机验证码";
        [self.accountLoginBtn setTitle:@"手机快捷输登录" forState:0];
    }else{
        self.getCodeBtn.hidden = NO;
        self.codeText.placeholder = @"请输入密码";
        [self.accountLoginBtn setTitle:@"账号密码输登录" forState:0];
    }
}
- (UILabel *)line1{
    if (!_line1) {
        _line1 =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@""
                                             TextAlign:center];
        _line1.backgroundColor = kRGBColor(135, 135, 135);
    }
    return _line1;
}
- (UILabel *)line2{
    if (!_line2) {
        _line2 =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@""
                                             TextAlign:center];
    }
    _line2.backgroundColor = kRGBColor(135, 135, 135);
    return _line2;
}
- (UILabel *)descriptLabel{
    if (!_descriptLabel) {
        _descriptLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"———————— 其他方式登录 ————————"
                                             TextAlign:center];
        _descriptLabel.textColor = [UIColor lightGrayColor];
        _descriptLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
    }
    return _descriptLabel;
}
- (UIButton *)weChatLogin{
    if (!_weChatLogin) {
        _weChatLogin =     [LXView createButtonWithFrame:CGRectZero
                                                   title:@""
                                               imageName:nil
                                             bgImageName:@"wechat"
                                                  radius:-1
                                                  target:self
                                                  action:@selector(weChatclick)
                                                   color:[UIColor whiteColor]];
        
    }
    return _weChatLogin;
}
- (void)weChatclick{ 
   [[AppDelegate shareInstance] enterRootViewController:YES];
}
- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn =     [LXView createButtonWithFrame:CGRectZero
                                                title:@"车主注册"
                                            imageName:nil
                                          bgImageName:nil
                                               radius:-1
                                               target:self
                                               action:@selector(rightClick)
                                                color:[UIColor lightGrayColor]];
        [_rightBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(14)]];
        [_rightBtn setAdjustsImageWhenHighlighted:NO];
    }
    return _rightBtn;
}
- (UIButton *)rightIcon{
    if (!_rightIcon) {
        _rightIcon =     [LXView createButtonWithFrame:CGRectZero
                                                title:nil
                                            imageName:nil
                                          bgImageName:@"right"
                                               radius:-1
                                               target:self
                                               action:@selector(rightClick)
                                                color:[UIColor lightGrayColor]];
        [_rightIcon setAdjustsImageWhenHighlighted:NO];
    }
    return _rightIcon;
}

- (void)rightClick{
    LXRegisterViewController *VC = [LXRegisterViewController new];
    [self.navigationController pushViewController:VC animated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self loginClick];
    return YES;
}
@end
