//
//  LXUserCenterUpdateUserNameController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/1.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXUserCenterUpdateUserNameController.h"

@interface LXUserCenterUpdateUserNameController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *contentText;   /**< 内容 */
@property (nonatomic,strong) UILabel *line;              /**< 线 */
@property (nonatomic,strong) UILabel *descriptLabel;     /**< 描述 */
@property (nonatomic,strong) UIButton *commitBtn;        /**< 提交 */
@property (nonatomic,strong) NSString *descriptStr;     /**< 描述 */
@end

@implementation LXUserCenterUpdateUserNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}
- (void)configUI{
    [self.view addSubview:self.contentText];
    [self.view addSubview:self.line];
    [self.view addSubview:self.descriptLabel];
    [self.view addSubview:self.commitBtn];
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.line);
                make.height.mas_equalTo(kCellHeight);
                make.centerX.equalTo(self.view);
                make.top.equalTo(self.line.mas_bottom).offset(26*k_height);
    }];
    
    if (self.userEnum != LXUserCenterEnumRealName) {
        [self.contentText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.line);
            make.height.mas_equalTo(30);
            make.left.equalTo(self.view).offset(28*k_width);
            CGFloat a  = kNavHeight;
            make.top.equalTo(self.view).offset(36*k_height+a);
        }];
    }else{
        [self.contentText mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kWidth*0.78);
            make.height.mas_equalTo(30);
            make.left.equalTo(self.view).offset(28*k_width);
            CGFloat a  = kNavHeight;
            make.top.equalTo(self.view).offset(36*k_height+a);
        }];
    }
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.8);
        make.left.equalTo(self.view).offset(28*k_width);
        make.right.equalTo(self.view).offset(-28*k_width);
        make.top.equalTo(self.contentText.mas_bottom).offset(13*k_height);
    }];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentText);
        make.right.equalTo(self.view).offset(-28*k_width);
        
    }];
    NSString *title = @"";
    switch (self.userEnum) {
        case  LXUserCenterEnumRealName:{
            title = @"修改姓名";
            self.descriptStr = @"姓名";
            self.descriptLabel.hidden = NO;
        }
            break;
        case LXUserCenterEnumEmail:{
            title = @"修改邮箱";
            self.descriptStr = @"邮箱";
            self.contentText.keyboardType = UIKeyboardTypeEmailAddress;
            
        }break;
        case LXUserCenterEnumPhone:{
            title = @"修改手机号";
            self.descriptStr = @"手机号";
            self.contentText.keyboardType = UIKeyboardTypePhonePad;
            
        }
            break;
        default:{
            title = @"修改驾驶证号";
            self.descriptStr = @"驾驶证号";
            self.contentText.keyboardType = UIKeyboardTypeNumberPad;
        }
            break;
    }
      self.title = title;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITextField *)contentText{
    if (!_contentText) {
        _contentText =  [LXView createTextFieldWithFrame:CGRectZero
                                             placeholder:@"#绅士的赌注"
                                           bgImageName:nil
                                              leftView:nil
                                             rightView:nil
                                            isPassWord:NO
                                              delegate:self];
        NSString *type        = @"";
        NSString *placeholder = @"";
        switch (self.userEnum) {
            case LXUserCenterEnumRealName:
                type = KUserDefault_Get(@"RealName");
                placeholder = @"请输入姓名";
                break;
            case LXUserCenterEnumEmail:
                type = KUserDefault_Get(@"Email");
                placeholder = @"请输入邮箱";
                break;
            case LXUserCenterEnumPhone:
                type = KUserDefault_Get(@"Phone");
                placeholder = @"请输入电话";
                break;
            default:
                type = KUserDefault_Get(@"DriversLicenseNumber");
                placeholder = @"请输入驾驶证";
                break;
        }
        _contentText.placeholder = placeholder;
        _contentText.text        = type;
        _contentText.borderStyle = UITextBorderStyleNone;
        
    }
    return _contentText;
}
- (UILabel *)line{
    if (!_line) {
        _line =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@""
                                             TextAlign:center];
        _line.backgroundColor = kRGBColor(135, 135, 135);
    }
    return _line;
}
- (UILabel *)descriptLabel{
    if (!_descriptLabel) {
        _descriptLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"6/8"
                                             TextAlign:right];
        _descriptLabel.textColor = kRGBColor(135, 135, 135);
        _descriptLabel.hidden = YES;
    }
    return _descriptLabel;
}
- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [LXView createButtonWithFrame:CGRectZero
                                             title:@"立即修改"
                                           bgColor:kRGBColor(56, 158, 61)
                                            radius:kfontValue(25)
                                            target:self
                                            action:@selector(commitBtnClick)];
        [_commitBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(18)]];
        _commitBtn.titleLabel.textColor = [UIColor whiteColor];
        _commitBtn.tag = 1;
    }
    return _commitBtn;
}
- (void)commitBtnClick{
    [self modifyUserCenter];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.userEnum == LXUserCenterEnumRealName) {
        if (textField.text.length == 8 && ![string  isEqual: @""]) {
            return NO;
        }
        if (string.length == 0) {
            self.descriptLabel.text = [NSString stringWithFormat:@"%lu/8",_contentText.text.length-1];
        }else{
            self.descriptLabel.text = [NSString stringWithFormat:@"%lu/8",_contentText.text.length+1];
        }
    }
    return YES;
}
/**
修改头像
*/
- (void)modifyUserCenter{
    NSString *str = _contentText.text;
    str =  [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str =  [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *type = @"";
    switch (self.userEnum) {
        case LXUserCenterEnumRealName:{
            type = @"RealName";
            if (str.length == 0) {
                [LXMessage showErrorMessage:@"姓名不能为空"];
                return;
            }
        }
            break;
        case LXUserCenterEnumEmail:{
            type = @"Email";
            if (str.length == 0) {
                [LXMessage showErrorMessage:@"邮箱不能为空"];
                return;
            }
            if (![LXCommon isValidateEmail:str]) {
                [LXMessage showErrorMessage:@"邮箱格式不正确"];
                return;
            }
        }
            break;
        case LXUserCenterEnumPhone:{
            type = @"Phone";
            if (str.length == 0) {
                [LXMessage showErrorMessage:@"手机号码不能为空"];
                return;
            }
            if (![LXCommon isValidateMobile:str]) {
                [LXMessage showErrorMessage:@"手机格式不正确"];
                return;
            }
        }
            break; 
        default:{
            type = @"DriversLicenseNumber";
            if (str.length == 0) {
                [LXMessage showErrorMessage:@"驾驶证不能为空"];
                return;
            }
        }
            break;
    }
    [LXNetManager postRequestWithUrlString:[NSString stringWithFormat:@"%@?field=%@&content=%@",kLXHttpPostUrl(@"api/DriverInfo/UpdateDrive"),type,str]
                                    params:@[]
                                  finished:^(id responseObj) {
                                      if (responseObj && [[responseObj objectForKey:@"state"] integerValue] >= 0) {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [LXMessage showInfoMessage:[NSString stringWithFormat:@"%@修改成功",self.descriptStr]];
                                          }); 
                                          KUserDefault_Set([str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding], type);
                                      }
                                  }
                                    failed:^(NSError *error) {
                                        [LXMessage showErrorMessage:error.localizedDescription];
                                    }];
}
@end
