//
//  SLDevicesViewController.m
//  智能锁
//
//  Created by million on 2019/4/10.
//  Copyright © 2019 million. All rights reserved.
//

#import "SLDevicesViewController.h"
#import "UIUtils.h"
#import "SLSettingsTableController.h"

@interface SLDevicesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SLDevicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_icon_add_nor"] style:UIBarButtonItemStylePlain target:self action:@selector(settings:)];
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
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

- (void)settings:(id)sender {
    [self performSegueWithIdentifier:NSStringFromClass([SLSettingsTableController class]) sender:nil];
}

- (void)add:(id)sender {
    //[self performSegueWithIdentifier:NSStringFromClass([SLUserProfileTableController class]) sender:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
