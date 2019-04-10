//
//  SLAdminTableController.m
//  智能锁
//
//  Created by million on 2019/4/11.
//  Copyright © 2019 million. All rights reserved.
//

#import "SLAdminTableController.h"
#import "UIUtils.h"
#import "SLUserNickPickViewController.h"

@interface SLAdminTableController ()

@end

@implementation SLAdminTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.titleLabel.font = [Theme pc_fontWithSize:9];
    [addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [UIUtils setButton:addButton ImagePosition:ETButtonImagePostionUp Padding:5];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addButton];
    [self initTableView];
}

- (void)initTableView {
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me_bg.png"]];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

- (void)add:(id)sender {
    [self performSegueWithIdentifier:NSStringFromClass([SLUserNickPickViewController class]) sender:nil];
}


@end
