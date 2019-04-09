//
//  SLUserProfileTableController.m
//  智能锁
//
//  Created by million on 2019/4/3.
//  Copyright © 2019 million. All rights reserved.
//

#import "SLUserProfileTableController.h"

@interface SLUserProfileTableController ()

@end

@implementation SLUserProfileTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg.png"]];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

@end
