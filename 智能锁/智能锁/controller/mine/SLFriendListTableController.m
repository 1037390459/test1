//
//  SLFriendListTableController.m
//  智能锁
//
//  Created by million on 2019/4/6.
//  Copyright © 2019 million. All rights reserved.
//

#import "SLFriendListTableController.h"
#import "UIUtils.h"

@interface SLFriendListTableController ()

@end

@implementation SLFriendListTableController

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
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg.png"]];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

- (void)add:(id)sender {
    //[self performSegueWithIdentifier:NSStringFromClass([SLUserProfileTableController class]) sender:nil];
}

#pragma mark tableview datasource&delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.textLabel.text = @"以梦为马";
    cell.textLabel.font = [Theme pc_fontWithSize:14];
    cell.textLabel.textColor = [Theme colorPrimaryDark];
    cell.detailTextLabel.text = @"18026439139";
    cell.detailTextLabel.font = [Theme pc_fontWithSize:11];
    cell.detailTextLabel.textColor = [Theme colorPrimaryLight];
    cell.imageView.image = [UIImage imageNamed:@"Authorization_icon_fingerprint_sel"];
    return cell;
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    editAction.backgroundColor = [Theme colorPrimary];
    
    UITableViewRowAction *delAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    return @[delAction,editAction];
}

@end
