//
//  SLSectionHeaderFooterView.m
//  智能锁
//
//  Created by million on 2019/4/10.
//  Copyright © 2019 million. All rights reserved.
//

#import "SLSectionHeaderFooterView.h"

@interface SLSectionHeaderFooterView()

@end

@implementation SLSectionHeaderFooterView

//- (instancetype)init {
//    if (self = [super init]) {
//        
//    }
//    return self;
//}
//
//- (void)setUp {
//    
//}
//
//-(void)layoutSubviews {
//    [super layoutSubviews];
//    self.textLabel.center = CGSizeMake(<#CGFloat width#>, <#CGFloat height#>)
//}

-(void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        if (self.onClickedListener) self.onClickedListener(sender);
    }];
    [self addGestureRecognizer:tap];
}

@end
