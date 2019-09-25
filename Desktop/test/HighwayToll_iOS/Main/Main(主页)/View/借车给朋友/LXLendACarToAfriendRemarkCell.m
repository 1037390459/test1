//
//  LXLendACarToAfriendRemarkCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/27.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXLendACarToAfriendRemarkCell.h"

@implementation LXLendACarToAfriendRemarkCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI{
    [self.contentView addSubview:self.textView];
    [self setBackgroundColor: [UIColor whiteColor]];
    //-----------start-----------------
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.right.equalTo(self).offset(-15*k_width);
        make.top.equalTo(self).offset(12*k_width);
        make.bottom.equalTo(self).offset(-12*k_width);
    }];
    //-----------end-------------------
}
#pragma mark 配置UI
- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.layer.cornerRadius = 5;
        _textView.layer.masksToBounds = YES;
        _textView.delegate = self;
        [_textView setBackgroundColor:kRGBColor(242, 242, 242)];
        _textView.text = @"请填写借出的理由";
        _textView.textColor = kRGBColor(103, 103, 103);
    }
    return _textView;
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请填写借出的理由"]) {
        textView.text = @"";
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        textView.text = @"请填写借出的理由";
    }
}
@end
