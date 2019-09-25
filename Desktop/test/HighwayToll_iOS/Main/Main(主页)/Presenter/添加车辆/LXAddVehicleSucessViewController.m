//
//  LXAddVehicleSucessViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/27.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXAddVehicleSucessViewController.h"
#import "LXMyVehicleListViewController.h" //*<车辆列表*/
@interface LXAddVehicleSucessViewController ()
@property (nonatomic,strong) UIImageView *infoImage;        /**< 图片 */
@property (nonatomic,strong) UILabel *descriptLabel;        /**< 描述文字 */
@property (nonatomic,strong) UIButton *determineBtn;        /**< 确定按钮 */
@end

@implementation LXAddVehicleSucessViewController

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
    self.title = @"添加车辆";
    [self.view addSubview:self.infoImage];
    [self.view addSubview:self.determineBtn];
    [self.view addSubview:self.descriptLabel];
    //-------------配置UI-----------------
    [self.infoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(90*k_width);
        make.width.mas_equalTo(95*k_width);
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-130*k_height);
    }];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.infoImage.mas_bottom).offset(38*k_height);
    }];
    [self.determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descriptLabel.mas_bottom).offset(38*k_height);
        make.width.equalTo(self.descriptLabel).offset(-20);
        make.height.mas_equalTo(kCellHeight);
        make.centerX.equalTo(self.view);
    }];
}
#pragma mark 懒加载
- (UIImageView *)infoImage{
    if (!_infoImage) {
        _infoImage =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"success"
                                        isUIEnabled:YES];
    }
    return _infoImage;
}
- (UILabel *)descriptLabel{
    if (!_descriptLabel) {
        _descriptLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"信息提交成功，请等待审核!/n预计审核将在24小时内完成，请通过站内信查看审核结果。"
                                             TextAlign:center];
        _descriptLabel.numberOfLines = 0;
        _descriptLabel.font = [UIFont systemFontOfSize:kfontValue(12)];
        _descriptLabel.textColor = kRGBColor(135, 135, 135);
        //----------------------富文本-------------------
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"信息提交成功，请等待审核!\n预计审核将在24小时内完成，请通过站内信查看审核结果。"];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:[str.string rangeOfString:@"信息提交成功，请等待审核!"]];
        [str addAttribute:NSForegroundColorAttributeName value:kRGBColor(94, 176, 116) range:[str.string rangeOfString:@"信息提交成功，请等待审核!"]];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
        _descriptLabel.attributedText = str;
        //----------------------end---------------------
        _descriptLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _descriptLabel;
}
- (UIButton *)determineBtn{
    if (!_determineBtn) {
        _determineBtn =     [LXView createButtonWithFrame:CGRectZero
                                                title:@"完成"
                                              bgColor:kRGBColor(255, 255, 255)
                                               radius:kfontValue(23)
                                               target:self
                                               action:@selector(determineBtnClick)];
        [_determineBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(17)]];
        [_determineBtn setTitleColor:kRGBColor(94, 176, 116) forState:0];
        _determineBtn.borderWidth = 1;
        _determineBtn.borderColor = kRGBColor(94, 176, 116).CGColor;
    }
    return _determineBtn;
}
- (void)determineBtnClick{ 
    if (self.isFormMain) {
        [self backBtnClick];
    }else{
        UIViewController *viewCtl = self.navigationController.viewControllers[1];
        [self.navigationController popToViewController:viewCtl animated:YES];
    }
}
- (void)backBtnClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
