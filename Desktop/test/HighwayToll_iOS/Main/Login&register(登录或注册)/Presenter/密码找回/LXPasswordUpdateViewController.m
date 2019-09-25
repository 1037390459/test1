//
//  LXPasswordUpdateViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/23.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXPasswordUpdateViewController.h"
#import "LXInterface+UserCenter.h"
@interface LXPasswordUpdateViewController ()
@property (nonatomic,strong) UITextField *lastText;                    /**< 上一个text */
@property (nonatomic,strong) UIButton *nextBtn;                        /**< 下一步 */
@end

@implementation LXPasswordUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

//配置UI
- (void)configUI{
    self.title = @"修改密码";
    NSArray *titleArray = @[@"新密码",@"确认密码"];
    for (int i = 0; i<titleArray.count; i++) {
        NSString *icon = @"lock";
        UITextField * text   =  [self createText:titleArray[i]
                                            icon:icon];
        text.tag = i+1;
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
- (UILabel *)createLabel{
    UILabel *label =  [LXView createLabelWithFrame:CGRectZero
                                              text:@""
                                         TextAlign:center];
    label.backgroundColor = kRGBColor(212, 212, 212);
    return label;
}
- (UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn =     [LXView createButtonWithFrame:CGRectZero
                                               title:@"登录"
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
    NSString *_oldPwd = ((UITextField *)[self.view viewWithTag:1]).text;
    NSString *_newPWd = ((UITextField *)[self.view viewWithTag:1]).text;
    
    if (_oldPwd.length == 0) {
        [LXMessage showInfoMessage:@"密码不能为空"];
        return;
    } if (_newPWd.length == 0) {
        [LXMessage showInfoMessage:@"确认密码不能为空"];
        return;
    }if (_oldPwd != _newPWd) {
        [LXMessage showErrorMessage:@"两次密码不一致"];
        return;
    }
    LXWeakSelf(self);
    [LXNetManager postRequestWithParamDictionary:[LXInterface postUserCenterResetPasswordWithVCode:self.phoneStr
                                                                                             vcode:self.vCode
                                                                                            newPwd:_newPWd]
                                        finished:^(id responseObj) {
                                            if (responseObj && [[responseObj objectForKey:@"state"] integerValue] >= 0) {
                                                [LXMessage showSuccessMessage:@"找回成功"];
                                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                    [weakself.navigationController popToRootViewControllerAnimated:YES];
                                                });
                                            }
                                        }failed:^(NSError *error) {
                                            [LXMessage showSuccessMessage:error.localizedDescription];
                                        }];
}
@end
