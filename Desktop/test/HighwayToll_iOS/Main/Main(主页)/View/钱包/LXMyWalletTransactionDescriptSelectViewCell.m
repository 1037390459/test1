//
//  LXMyWalletTransactionDescriptSelectViewCell.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMyWalletTransactionDescriptSelectViewCell.h"
@interface LXMyWalletTransactionDescriptSelectViewCell()
@property (nonatomic,strong) UISegmentedControl *segmentcontrol;            /**< 选项卡 */
@end
@implementation LXMyWalletTransactionDescriptSelectViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

/**
    配置UI
 */
- (void)configUI{
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.segmentcontrol];
    [self.segmentcontrol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(kWidth*0.68);
        make.height.mas_equalTo(self.height*0.65);
    }];
}
//懒加载
- (UISegmentedControl *)segmentcontrol{
    if (!_segmentcontrol) {
        _segmentcontrol = [[UISegmentedControl alloc] initWithItems:@[@"充值明细",@"扣费明细"]];
        [_segmentcontrol setTintColor:kRGBColor(56, 158, 61)];
        [_segmentcontrol setBackgroundColor:[UIColor whiteColor]];
        [_segmentcontrol.layer setCornerRadius:kfontValue(23)];
        [_segmentcontrol.layer setMasksToBounds:YES];
        _segmentcontrol.borderWidth = 0.8;
        _segmentcontrol.borderColor = kRGBColor(56, 158, 61).CGColor;
        _segmentcontrol.selectedSegmentIndex = 0;
        UIFont *font = [UIFont boldSystemFontOfSize:kfontValue(14)];   // 设置字体大小
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        [_segmentcontrol setTitleTextAttributes:attributes  forState:UIControlStateNormal];
        [_segmentcontrol addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentcontrol;
}
- (void)valueChange:(UISegmentedControl *)sender{
    if (_block) {
        NSInteger index = sender.selectedSegmentIndex == 1?2:1;
        _block(index);
    }
}
- (void)didSelectClick:(LXMyWalletTransactionDescriptSelectViewCellBlock)block{
    _block = block;
}
@end
