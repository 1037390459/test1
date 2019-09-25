//
//  LXSettingComplaintProposalViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/1.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXSettingComplaintProposalViewController.h"
#import "HSDAutoSelectView.h"
#import "LXFeedbackTypeModel.h"
@interface LXSettingComplaintProposalViewController ()<UITextViewDelegate>
@property (nonatomic,strong) UIButton *titleBtn;                               /**< 主题 */
@property (nonatomic,strong) UIImageView *rightImg;                            /**< 左边按钮 */
@property (nonatomic,strong) UITextField *titleLabel;                          /**< 主题 */
@property (nonatomic,strong) UITextView *textView;                             /**< 主题 */
@property (nonatomic,strong) UILabel    *descriptLabel;                        /**< 主题 */
@property (nonatomic,strong) UILabel    *line1;                                /**<  */
@property (nonatomic,strong) UILabel    *line2;                                /**<  */
@property (nonatomic,strong) UIView *bgview;                                   /**<  */
@property (nonatomic,strong) UIButton *commitBtn;                              /**< 提交 */
@property (nonatomic,strong) LXFeedbackTypeListModel *model;                   /**< 数据模型 */
  @property (nonatomic,assign) NSInteger                                       index; /**< */
@end

@implementation LXSettingComplaintProposalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _index = -1;
    [self feedbackTypeList];
    [self configUI];
}

/**
   加载所有的投诉与建议
 */
- (void)feedbackTypeList{
    [[LXNetManager shareManager] getRequestWithUrlString:[[LXInterface postFeedbackTypeList] objectForKey:@"url"]
                                                finished:^(id responseObj) {
                                                    [LXMessage hideActiveView];
                                                    [_collectionView.mj_header endRefreshing];
                                                    if ([responseObj objectForKey:@"state"] && responseObj) {
                                                        if (!self.model) {
                                                            self.model = [[LXFeedbackTypeListModel alloc] init];
                                                        }
                                                        [_model.dataArray removeAllObjects];
                                                        [_model.dataNameArray removeAllObjects];
                                                        [_model setValuesForKeysWithDictionary:responseObj];
                                                       
                                                    }
                                                }
                                                  failed:^(NSError *error) {
                                                      
                                                  }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configUI{
    self.title = @"投诉与建议";
    //----------------配置UI-------------------
    [self.view setBackgroundColor: kRGBColor(242, 242, 242)];
    [self.view addSubview:self.bgview];
    [self.view addSubview:self.titleBtn];
    [self.view addSubview:self.rightImg];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.descriptLabel];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.commitBtn];
    //----------------------------------------
    [self.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavHeight+5);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(325*k_height);
    }];
    [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgview).offset(13*k_height);
        make.left.equalTo(self.bgview).offset(15*k_width);
        make.right.equalTo(self.bgview).offset(-15*k_width);
    }];
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15*k_width);
        make.centerY.equalTo(self.titleBtn);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(21);
    }];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(self.titleBtn.mas_bottom).offset(13*k_width);
        make.height.mas_equalTo(0.8);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleBtn);
        make.top.equalTo(self.line1.mas_bottom).offset(15*k_height);
        make.width.mas_equalTo(kWidth *0.8);
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(13*k_width);
        make.height.mas_equalTo(1);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15*k_width);
        make.right.equalTo(self.view).offset(-15*k_width);
        make.top.equalTo(self.line2.mas_bottom).offset(15*k_width);
        make.height.mas_equalTo(130*k_height);
    }];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.textView);
        make.top.equalTo(self.textView.mas_bottom).offset(15*k_width);
    }];
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kCellHeight);
        make.width.mas_equalTo(self.view.width *0.8);
        make.top.equalTo(self.bgview.mas_bottom).offset(22*k_height);
        make.centerX.equalTo(self.view);
    }];
}
#pragma mark 懒加载
- (UIButton *)titleBtn{
    if (!_titleBtn) {
        _titleBtn =     [LXView createButtonWithFrame:CGRectZero
                                                  title:@"请选择"
                                                bgColor:[UIColor clearColor]
                                                 radius:-1
                                                 target:self
                                                 action:@selector(click)];
        [_titleBtn setTitleColor:kRGBColor(48, 162, 83) forState:0];
        _titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
    }
    return _titleBtn;
}
- (void)click{
    HSDAutoSelectView *selectView = [HSDAutoSelectView instanceView];
    selectView.selectIndex = 110;
    selectView.dataArray = self.model.dataNameArray;
    LXWeakSelf(self);
    [selectView showWithView:_titleBtn callBack:^(NSInteger selectedIndex, NSString *selectTitle) {
        [_titleBtn setTitle:selectTitle forState:0];
        _titleBtn.tag = 110;
        weakself.index = selectedIndex;
    }];
}
- (UITextField *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =  [LXView createTextFieldWithFrame:CGRectZero
                                           placeholder:@"请填写主题"
                                           bgImageName:nil
                                              leftView:nil
                                             rightView:nil
                                            isPassWord:NO
                                              delegate:self];
        _titleLabel.borderStyle =  UITextBorderStyleNone;
    }
    return _titleLabel;
}
- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = kRGBColor(245, 245, 245);
        [_textView.layer setCornerRadius:5];
        [_textView.layer setMasksToBounds:YES];
        [_textView setText:@"请填写详细描述"];
        _textView.delegate = self;
    }
    return _textView;
}
- (UILabel *)descriptLabel{
    if (!_descriptLabel) {
        _descriptLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"您的每一个投诉，我们都会非常认真的对待，积极的处理您的问题\n您的每一个意见，我们都会非常认真的评估，不断改善软件系统"
                                             TextAlign:center];
        _descriptLabel.textColor = kRGBColor(135, 135, 135);
        _descriptLabel.font = [UIFont systemFontOfSize:kfontValue(11)];
    }
    return _descriptLabel;
}
- (UILabel *)line1{
    if (!_line1) {
        _line1 =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@""
                                             TextAlign:center];
        _line1.backgroundColor = kRGBColor(235, 235, 235);
    }
    return _line1;
}
- (UILabel *)line2{
    if (!_line2) {
           _line2 =  [LXView createLabelWithFrame:CGRectZero
                                          text:@""
                                     TextAlign:center];
           _line2.backgroundColor = kRGBColor(235, 235, 235);
    }
    return _line2;
}
- (UIView *)bgview{
    if (!_bgview) {
        _bgview = [LXView createViewWithFrame:CGRectZero bgColor:[UIColor whiteColor] radius:-1];
        [_bgview setBackgroundColor:[UIColor whiteColor]];
    }
    return _bgview;
}
- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [LXView createButtonWithFrame:CGRectZero
                                             title:@"提交"
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
- (UIImageView *)rightImg{
    if (!_rightImg) {
        _rightImg =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"bottom"
                                       isUIEnabled:YES];
    }
    return _rightImg;
}
- (void)commitBtnClick{
    NSString *contentStr = self.titleLabel.text;
    NSString *remake     = self.textView.text;
    if (_index == -1) {
        [LXMessage show:@"请选择类型" onView:self.view autoHidden:YES];
        return;
    }
    if (contentStr.length == 0) {
        [LXMessage show:@"请填写主题" onView:self.view autoHidden:YES];
    }
    if ([remake isEqualToString:@"请填写详细描述"]) {
        remake = @"";
    }
    LXWeakSelf(self);
    NSString *fId = kStringByInt(((LXFeedbackTypeModel *)self.model.dataArray[_index]).FeedbackTypeId);
    [LXNetManager postWithParamDictionary:[LXInterface postFeedbackInfoPost:fId
                                                                     FeedbackTitle:contentStr
                                                                   FeedbackContent:remake]
                                        finished:^(id responseObj) {
                                            if (responseObj && [[responseObj objectForKey:@"state"] integerValue]>=1) {
                                                [LXMessage showSuccessMessage:@"操作成功"];
                                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                    [weakself.navigationController popViewControllerAnimated:YES];
                                                });
                                            }else{
                                                [LXMessage showErrorMessage:@"操作失败"];
                                            }
                                        }
                                          failed:^(NSError *error) {
                                              [LXMessage showErrorMessage:error.localizedDescription];
                                          }];
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请填写详细描述"]) {
        textView.text = @"";
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        textView.text = @"请填写详细描述";
    }
}
@end
