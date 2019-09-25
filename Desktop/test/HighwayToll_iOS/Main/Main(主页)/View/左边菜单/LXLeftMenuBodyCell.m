//
//  LXLeftMenuBodyCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXLeftMenuBodyCell.h"
@interface LXLeftMenuBodyCell ()
@property (nonatomic,strong) UIImageView *logoImage;            /**< 标志 */
@property (nonatomic,strong) UILabel *titleLabel;               /**< 名称 */
@end
@implementation LXLeftMenuBodyCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI{
    [self.contentView addSubview:self.logoImage];
    [self.contentView addSubview:self.titleLabel];
    //---------------------开始------------------
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(40*k_width);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(20*k_width);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoImage.mas_right).offset(15*k_width);
        make.centerY.equalTo(self);
    }];
}
#pragma mark 懒加载
- (UIImageView *)logoImage{
    if (!_logoImage) {
        _logoImage =   [LXView createImageViewFrame:CGRectZero
                                         imageName:@"myCar"
                                        isUIEnabled:YES];
    }
    return _logoImage;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =  [LXView createLabelWithFrame:CGRectZero
                                                  text:@"行程"
                                             TextAlign:left];
    }
    return _titleLabel;
}
- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    self.titleLabel.text = titleStr;
}
- (void)setImageNameStr:(NSString *)imageNameStr{
    _imageNameStr = imageNameStr;
    self.logoImage.image = [UIImage imageNamed:imageNameStr];
}
@end
