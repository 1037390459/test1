//
//  LXMyWalletRechargeView.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyWalletRechargeView.h"
@interface LXMyWalletRechargeView ()
@property (nonatomic,strong) UIButton *titleLabel;              /**< 标题 */
@property (nonatomic,strong) UILabel *dscriptLabel;             /**< 描述 */
@property (nonatomic,strong) UILabel *custerLabel;              /**< 自定义描述 */
@property (nonatomic,strong) UITextField *contentText;          /**<  */
@property (nonatomic,strong) UIButton *lastBtn;                 /**< 上一个btn */
@property (nonatomic,strong) UIButton *commitBtn;               /**< 提交 */
@property (nonatomic,strong) NSMutableArray *btnArray;          /**< 按钮数组 */
 @property (nonatomic,assign) NSInteger lastTag;                 /**< */
@end
@implementation LXMyWalletRechargeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
//配置UI
- (void)configUI{
    [self addSubview:self.titleLabel];
    [self addSubview:self.dscriptLabel];
    [self addSubview:self.custerLabel];
    [self addSubview:self.contentText];
    [self addSubview:self.commitBtn];
    self.lastTag = -1;
    //--------------------------------
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(32*k_height);
    }];
    [self.dscriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(45*k_width);
        make.left.equalTo(self).offset(20*k_width);
    }];
    NSArray *arr = [NSArray arrayWithObjects:@"100",@"200",@"500",@"1000", nil];
    self.btnArray = [[NSMutableArray alloc] init];
    CGFloat speing = 20*k_width;
    CGFloat width = (kWidth -speing*5)/4;
    for (int i = 0;  i<4; i++) {
        UIButton *btn =     [LXView createButtonWithFrame:CGRectZero
                                                    title:arr[i]
                                                  bgColor:[UIColor redColor]
                                                   radius:8
                                                   target:self
                                                   action:@selector(click:)];
        [self setSelectStatus:btn];
        btn.tag =  i+100;
        [self.btnArray addObject:btn];
        [self  addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.lastBtn) {
                make.left.equalTo(self.lastBtn.mas_right).offset(20*k_width);
            }else{
                make.left.equalTo(self).offset(20*k_width);
            }
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(width*0.69);
            make.top.equalTo(self.dscriptLabel.mas_bottom).offset(12*k_height);
        }];
        self.lastBtn = btn;
    }
    [self.custerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.top.equalTo(self.lastBtn.mas_bottom).offset(52*k_height);
    }];
    [self.contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.height.mas_equalTo(44);
        make.top.equalTo(self.custerLabel.mas_bottom).offset(3.6);
        make.right.equalTo(self).offset(-15*k_width);
    }];
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kWidth*0.75);
        make.height.mas_equalTo(kCellHeight);
        make.centerX.equalTo(self);
        make.top.equalTo(self.contentText.mas_bottom).offset(36*k_height);
    }];
    
}
- (void)setStatus:(UIButton *)sender{
    
    for (UIButton *btn in self.btnArray) {
        if (sender == btn) {
            [btn setTitleColor:[UIColor whiteColor] forState:0];
            [btn setBackgroundColor:kRGBColor(56, 158, 61)];
            btn.borderWidth = 0;
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:0];
            [btn setBackgroundColor:[UIColor whiteColor]];
            btn.borderColor = kRGBColor(245, 245, 245).CGColor;
            btn.borderWidth = 0.8;
        }
    }
    
//    UIButton *selectBtn = [self viewWithTag:sender.tag];
//    [self setSelectStatus:selectBtn];
//    if (self.lastTag != -1) {
//        UIButton *normaltBtn = [self viewWithTag:self.lastTag];
//        [self setNormalStatus:normaltBtn];
//    }
}
- (void)setSelectStatus:(UIButton *)sender{
    [sender setTitleColor:[UIColor blackColor] forState:0];
    [sender setBackgroundColor:[UIColor whiteColor]];
    sender.borderColor = kRGBColor(245, 245, 245).CGColor;
    sender.borderWidth = 0.8;
}
- (void)setNormalStatus:(UIButton *)sender{
    [sender setTitleColor:[UIColor whiteColor] forState:0];
    [sender setBackgroundColor:kRGBColor(56, 158, 61)];
    sender.borderWidth = 0;
}
- (void)click:(UIButton *)sender{
    //DLog(@"地址是--%p",sender);
     [self setStatus:sender];
//    self.lastTag = sender.tag;
    self.contentText.text = sender.titleLabel.text;
}
- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [LXView createButtonWithFrame:CGRectZero
                                                      title:@"立即充值"
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
    if (_block) {
        _block(self.contentText.text);
    }
}
- (void)didSelectClick:(LXMyWalletRechargeViewBlock)block{
    _block = block;
}
- (UIButton *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =     [LXView createButtonWithFrame:CGRectZero
                                                  title:@"微信支付"
                                              imageName:@"wechatPay"
                                            bgImageName:nil
                                                 radius:-1
                                                 target:self
                                                 action:@selector(payClickx)
                                                  color:nil];
        [_titleLabel horizontalCenterImageAndTitle];
        [_titleLabel setTitleColor:[UIColor blackColor] forState:0];
        
    }
    return _titleLabel;
}
- (void)payClickx{
   
}
- (UILabel *)dscriptLabel{
    if (!_dscriptLabel) {
        _dscriptLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"请选择充值金额(元)"
                                             TextAlign:center];
        _dscriptLabel.textColor = kRGBColor(135, 135, 135);
        _dscriptLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
        
    }
    return _dscriptLabel;
}
- (UILabel *)custerLabel{
    if (!_custerLabel) {
        _custerLabel =  [LXView createLabelWithFrame:CGRectZero
                                                 text:@"自定义金额(元)"
                                            TextAlign:center];
        _custerLabel.textColor = kRGBColor(135, 135, 135);
        _custerLabel.font = [UIFont systemFontOfSize:kfontValue(13)];
    }
    return _custerLabel;
}
- (UITextField *)contentText{
    if (!_contentText) {
        _contentText =  [LXView createTextFieldWithFrame:CGRectZero
                                           placeholder:@"请输入100的倍数"
                                           bgImageName:nil
                                              leftView:nil
                                             rightView:nil
                                            isPassWord:NO
                                              delegate:self];
        [_contentText.layer setCornerRadius:5];
        [_contentText.layer setMasksToBounds:YES];
        [_contentText setKeyboardType:UIKeyboardTypeNumberPad];
    }
    return _contentText;
}
 
@end
