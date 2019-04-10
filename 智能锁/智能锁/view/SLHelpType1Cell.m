//
//  SLHelpType1Cell.m
//  智能锁
//
//  Created by million on 2019/4/10.
//  Copyright © 2019 million. All rights reserved.
//

#import "SLHelpType1Cell.h"

@interface SLHelpType1Cell()

@property (strong, nonatomic)  UILabel *lbl;
@property (strong, nonatomic)  UIImageView *imgV;

@end

@implementation SLHelpType1Cell

-(instancetype)init {
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.lbl = [[UILabel alloc]init];
    self.imgV = [[UIImageView alloc]init];
}

-(void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [UIView animateWithDuration:0.4 animations:^{
        self.imgV.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}

- (void)configureCellWithTitle:(NSString *)title {
    _lbl.text = title;
}


@end
