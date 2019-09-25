

//
//  LXSettingtTextCollectionViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXSettingtTextCollectionViewCell.h"
@interface LXSettingtTextCollectionViewCell()
@property (nonatomic,strong) UILabel  *titleLable;                 /**< 名称 */
@property (nonatomic,strong) UIImageView *rightImg;                /**< 右边logog */
@end
@implementation LXSettingtTextCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI{
    [self.contentView addSubview:self.titleLable ];
    [self.contentView addSubview:self.rightImg ]; 
    //-------------------------------------------
    self.backgroundColor = [UIColor whiteColor];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*k_width);
        make.centerY.equalTo(self);
    }];
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15*k_width);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(15);
    }];
}
#pragma mark 懒加载
- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"投诉于建议"
                                             TextAlign:center]; 
        _titleLable.font      = [UIFont systemFontOfSize:kfontValue(15)];
    }
    return _titleLable;
}
- (UIImageView *)rightImg{
    if (!_rightImg) {
        _rightImg =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"right"
                                       isUIEnabled:YES];
    }
    return _rightImg;
}
- (void)setTitleStr:(NSString *)titleStr{
    self.titleLable.text = titleStr;
}
@end
