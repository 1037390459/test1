//
//  SLBaseTableController.m
//  智能锁
//
//  Created by million on 2019/4/3.
//  Copyright © 2019 million. All rights reserved.
//

#import "SLBaseTableController.h"

@interface SLBaseTableController ()

@end

@implementation SLBaseTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem.title = @"    ";
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me_bg.png"]];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}



@end
