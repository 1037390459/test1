//
//  SLHelpType2Cell.m
//  智能锁
//
//  Created by million on 2019/4/10.
//  Copyright © 2019 million. All rights reserved.
//

#import "SLHelpTypeCell.h"

@interface SLHelpTypeCell ()

@property (weak, nonatomic) IBOutlet UILabel *lbl;

@end

@implementation SLHelpTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellWithTitle:(NSString *)title {
    _lbl.text = title;
}

@end
