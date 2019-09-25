//
//  LXBorrowTheCarHadTextCollectionViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/6.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXBorrowTheCarHadTextCollectionViewCell.h"
@interface LXBorrowTheCarHadTextCollectionViewCell()<UITextViewDelegate>

///新的借车申请
@property(nonatomic, strong)UILabel *carTitleLable;
///借车时间
@property(nonatomic, strong)UILabel *timeLable;
///手机号码
@property(nonatomic, strong)UILabel *phoneLable;
///用车时间
@property(nonatomic, strong)UILabel *carOutTimeLable;
///还车时间
@property(nonatomic, strong)UILabel *carInTimeLable;
///借车理由
@property(nonatomic, strong)UILabel *carBorrowLable;
///车牌号码
@property(nonatomic, strong)UILabel *carPaiTitleLable;
///车牌背景图
@property(nonatomic, strong)UIImageView *carPaiImageView;
///车牌名字
@property(nonatomic, strong)UILabel *carPaiLable;
///刷新按钮
@property(nonatomic, strong)UIButton *refreshButton;
///线条
@property(nonatomic, strong)UIView *LineView;
///拒绝理由
@property(nonatomic, strong)UILabel *rejectTitleLable;
//输入框的View
@property(nonatomic, strong)UIView *rejectView;
///拒绝理由输入框
@property(nonatomic, strong)UITextView *rejectTextView;
///拒绝理由的Lable;
@property(nonatomic, strong)UILabel *rejectLable;
///操作:
@property(nonatomic, strong)UILabel *operationLable;
///发送
@property(nonatomic, strong)UIButton *sendButton;
///取消
@property(nonatomic, strong)UIButton *cancelButton;
@property(nonatomic, strong)UIView   *backGroundView;

@end
@implementation LXBorrowTheCarHadTextCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI{
    [self setUserInteractionEnabled:YES];
    [self addSubview:self.backGroundView];
    [self addSubview:self.carTitleLable];
    [self addSubview:self.timeLable];
    [self addSubview:self.phoneLable];
    [self addSubview:self.carOutTimeLable];
    [self addSubview:self.carInTimeLable];
    [self addSubview:self.carBorrowLable];
    [self addSubview:self.carPaiTitleLable];
    [self addSubview:self.carPaiImageView];
    [self.carPaiImageView addSubview:self.carPaiLable];
    [self addSubview:self.refreshButton];
    [self addSubview:self.LineView];
    [self addSubview:self.rejectTitleLable];
    [self addSubview:self.rejectView];
    [self.rejectView addSubview:self.rejectTextView];
    [self.rejectTextView addSubview:self.rejectLable];
    [self addSubview:self.operationLable];
    [self addSubview:self.sendButton];
    [self addSubview:self.cancelButton];
    [self SetCellValue];
}
#pragma mark - 赋值
-(void)SetCellValue{
    
    self.backgroundColor = [UIColor whiteColor];
    //时间Lable
    self.timeLable.text = @"2017-11-02 13:20:56";
    //手机号码
    self.phoneLable.text = [NSString stringWithFormat:@"手机号码: %ld",138999920000];
    //用车时间
    self.carOutTimeLable.text = [NSString stringWithFormat:@"用车时间: %@",@"2017-11-11 13:20:22"];
    //还车时间
    self.carInTimeLable.text = [NSString stringWithFormat:@"还车时间: %@",@"2017-12-11 13:20:22"];
    //借车理由
    self.carBorrowLable.text = [NSString stringWithFormat:@"借车理由: %@",@"自驾游出去半个月,借用一下你的车"];
    //车牌号码
    self.carPaiLable.text = @"沪A 88888";
    
    [self layoutUI];
}


#pragma mark - 布局

-(void)layoutUI{
    
    //布局
    [self.carTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.top.equalTo(self).with.offset(20);
    }];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-15);
        make.centerY.equalTo(self.carTitleLable);
    }];
    
    [self.phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carTitleLable);
        make.top.equalTo(self.carTitleLable.mas_bottom).with.offset(10);
    }];
    
    [self.carOutTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carTitleLable);
        make.top.equalTo(self.phoneLable.mas_bottom).with.offset(5);
    }];
    
    [self.carInTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carTitleLable);
        make.top.equalTo(self.carOutTimeLable.mas_bottom).with.offset(5);
    }];
    
    [self.carBorrowLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carTitleLable);
        make.top.equalTo(self.carInTimeLable.mas_bottom).with.offset(5);
    }];
    
    [self.carPaiTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carTitleLable);
        make.top.equalTo(self.carBorrowLable.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(70, 15));
    }];
    
    [self.carPaiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carPaiTitleLable.mas_right);
        make.width.mas_equalTo(self.width*0.29);
        make.height.mas_equalTo(36);
        make.centerY.equalTo(self.carPaiTitleLable);
    }];
    
    [self.carPaiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.carPaiImageView);
    }];
    
    [self.refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(self.carPaiImageView.mas_right).with.offset(10);
        make.centerY.equalTo(self.carPaiTitleLable);
    }];
    
    [self.LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carPaiTitleLable.mas_bottom).with.offset(30);
        make.height.equalTo(@1);
        make.left.right.equalTo(self);
    }];
    
    [self.rejectTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carTitleLable);
        make.top.equalTo(self.LineView.mas_bottom).with.offset(10);
    }];
    
    [self.rejectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rejectTitleLable.mas_bottom).with.offset(10);
        make.left.equalTo(self.carTitleLable);
        make.right.equalTo(self).with.offset(-15);
        make.height.equalTo(@115);
    }];
    
    [self.rejectTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rejectView.mas_top).with.offset(10);
        make.left.equalTo(self.rejectView.mas_left).with.offset(15);
        make.right.equalTo(self.rejectView.mas_right).with.offset(-15);
        make.bottom.equalTo(self.rejectView.mas_bottom).with.offset(-10);
    }];
    
    [self.rejectLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rejectTextView.mas_left).with.offset(5);
        make.top.equalTo(self.rejectTextView.mas_top).with.offset(8);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.rejectView.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(70, 27));
        make.bottom.equalTo(self).with.offset(-20);
    }];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.cancelButton.mas_left).with.offset(-14);
        make.size.centerY.equalTo(self.cancelButton);
    }];
    
    [self.operationLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carTitleLable);
        make.centerY.equalTo(self.cancelButton);
    }];
    
}


//刷新按钮
-(void)refreshClick:(UIButton *)sender{
    
    if (_refreshBlock) {
        _refreshBlock();
    }
    
}

//发送按钮
-(void)sendeClick:(UIButton *)sender{
    DLog(@"点击我了");
    if (_sendeBlock) {
        _sendeBlock(self.rejectTextView.text);
    }
}

-(void)canceClick:(UIButton *)sender{
    
    if (_cancelBlock) {
        _cancelBlock();
    }
}

//改变的方法
-(void)textViewDidChange:(UITextView *)textView
{
    self.rejectLable.hidden = (textView.text.length > 0);
}



#pragma mark - 懒加载控件

-(UILabel *)carTitleLable{
    if (!_carTitleLable) {
        _carTitleLable = [[UILabel alloc]init];
        _carTitleLable.textColor = [UIColor blackColor];
        _carTitleLable.font = [UIFont systemFontOfSize:14];
        _carTitleLable.text = @"新的借车申请";
    }
    return _carTitleLable;
}

-(UILabel *)timeLable{
    if (!_timeLable) {
        _timeLable = [[UILabel alloc]init];
        _timeLable.textColor = [UIColor grayColor];
        _timeLable.font = [UIFont systemFontOfSize:kfontValue(12)];
    }
    return _timeLable;
}

-(UILabel *)phoneLable{
    if (!_phoneLable) {
        _phoneLable = [[UILabel alloc]init];
        _phoneLable.textColor = [UIColor grayColor];
        _phoneLable.font = [UIFont systemFontOfSize:kfontValue(14)];
    }
    return _phoneLable;
}

-(UILabel *)carOutTimeLable{
    if (!_carOutTimeLable) {
        _carOutTimeLable = [[UILabel alloc]init];
        _carOutTimeLable.textColor = KLabelColor_greenColor;
        _carOutTimeLable.font = [UIFont systemFontOfSize:kfontValue(14)];
    }
    return _carOutTimeLable;
}

-(UILabel *)carInTimeLable{
    if (!_carInTimeLable) {
        _carInTimeLable = [[UILabel alloc]init];
        _carInTimeLable.textColor = KLabelColor_greenColor;
        _carInTimeLable.font = [UIFont systemFontOfSize:kfontValue(14)];
    }
    return _carInTimeLable;
}

-(UILabel *)carBorrowLable{
    if (!_carBorrowLable) {
        _carBorrowLable = [[UILabel alloc]init];
        _carBorrowLable.textColor = [UIColor grayColor];
        _carBorrowLable.font = [UIFont systemFontOfSize:kfontValue(14)];
    }
    return _carBorrowLable;
}

-(UILabel *)carPaiTitleLable {
    if (!_carPaiTitleLable) {
        _carPaiTitleLable = [[UILabel alloc]init];
        _carPaiTitleLable.textColor = [UIColor grayColor];
        _carPaiTitleLable.font = [UIFont systemFontOfSize:kfontValue(14)];
        _carPaiTitleLable.text = @"车牌号码:";
    }
    return _carPaiTitleLable;
}

-(UIImageView *)carPaiImageView{
    if (!_carPaiImageView) {
        _carPaiImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"platebg"]];
        _carPaiImageView.contentMode = UIViewContentModeScaleAspectFill;
        _carPaiImageView.backgroundColor = [UIColor clearColor];
    }
    return _carPaiImageView;
}

-(UILabel *)carPaiLable{
    if (!_carPaiLable) {
        _carPaiLable = [[UILabel alloc]init];
        _carPaiLable.textColor = [UIColor whiteColor];
        _carPaiLable.font =[UIFont fontWithName:@"Helvetica-Bold" size:15];
        _carPaiLable.textAlignment = NSTextAlignmentCenter;
    }
    return _carPaiLable;
}

-(UIButton *)refreshButton{
    if (!_refreshButton) {
        _refreshButton = [[UIButton alloc]init];
        [_refreshButton setBackgroundImage:[UIImage imageNamed:@"refresh"] forState:0];
        [_refreshButton addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshButton;
}
-(UIView *)LineView{
    if (!_LineView) {
        _LineView = [[UIView alloc]init];
        _LineView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    }
    return _LineView;
}

-(UILabel *)rejectTitleLable{
    if (!_rejectTitleLable) {
        _rejectTitleLable = [[UILabel alloc]init];
        _rejectTitleLable.textColor = [UIColor grayColor];
        _rejectTitleLable.font = [UIFont systemFontOfSize:14];
        _rejectTitleLable.text = @"拒绝理由:";
    }
    return _rejectTitleLable;
}

-(UIView *)rejectView{
    if (!_rejectView) {
        _rejectView = [[UIView alloc]init];
        _rejectView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
        _rejectView.layer.cornerRadius = 5;
        _rejectView.layer.masksToBounds = YES;
    }
    return _rejectView;
}

-(UITextView *)rejectTextView{
    if (!_rejectTextView) {
        _rejectTextView = [[UITextView alloc]init];
        _rejectTextView.backgroundColor =  [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
        _rejectTextView.font =[UIFont systemFontOfSize:14];
        _rejectTextView.scrollEnabled = YES;
        _rejectTextView.clipsToBounds = YES;
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        
        paragraphStyle.lineSpacing = 4;// 字体的行间距
        
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:14],
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
        _rejectTextView.typingAttributes = attributes;
        _rejectTextView.contentOffset = CGPointMake(10, 15);
        _rejectTextView.delegate = self;
        _rejectTextView.textColor = [UIColor grayColor];
    }
    return _rejectTextView;
}

-(UILabel *)rejectLable {
    if (!_rejectLable) {
        _rejectLable = [[UILabel alloc]init];
        _rejectLable.textColor = [UIColor grayColor];
        _rejectLable.font= [UIFont systemFontOfSize:14];
        _rejectLable.text = @"请填写拒绝借车理由";
    }
    return _rejectLable;
}

-(UILabel *)operationLable{
    if (!_operationLable) {
        _operationLable = [[UILabel alloc]init];
        _operationLable.text = @"操作:";
        _operationLable.textColor = [UIColor grayColor]; 
    }
    return _operationLable;
}

-(UIButton *)sendButton{
    if (!_sendButton) {
        _sendButton = [[UIButton alloc]init];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _sendButton.layer.masksToBounds = YES;
        _sendButton.layer.cornerRadius = 13.5;
        _sendButton.backgroundColor = [UIColor colorWithRed:43/255.0 green:145/255.0 blue:61/255.0 alpha:1];
    }
    return _sendButton;
}

-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc]init];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _cancelButton.backgroundColor = [UIColor grayColor];
        _cancelButton.layer.cornerRadius = 13.5;
        _cancelButton.layer.masksToBounds = YES;
    }
    return _cancelButton;
}
- (UIView *)backGroundView{
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc] initWithFrame:self.frame];
         _backGroundView.backgroundColor = [UIColor whiteColor];
//        _backGroundView.alpha =0.6;
    }
    return _backGroundView;
}
@end
