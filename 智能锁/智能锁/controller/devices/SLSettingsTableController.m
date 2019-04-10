//
//  SLSettingsTableController.m
//  智能锁
//
//  Created by million on 2019/4/10.
//  Copyright © 2019 million. All rights reserved.
//

#import "SLSettingsTableController.h"

@interface SLSettingsTableController ()

@end

@implementation SLSettingsTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me_bg.png"]];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

@end
