//
//  SLHelpType1Cell.m
//  智能锁
//
//  Created by million on 2019/4/10.
//  Copyright © 2019 million. All rights reserved.
//

#import "SLHelpType1Cell.h"

@interface SLHelpType1Cell()

@property (weak, nonatomic) IBOutlet UILabel *lbl;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end

@implementation SLHelpType1Cell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [UIView animateWithDuration:0.4 animations:^{
        self.imgV.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}

- (void)configureCellWithTitle:(NSString *)title {
    _lbl.text = title;
}


@end
