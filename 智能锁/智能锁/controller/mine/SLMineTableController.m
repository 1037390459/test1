//
//  SLMineTableController.m
//  智能锁
//
//  Created by million on 2019/4/3.
//  Copyright © 2019 million. All rights reserved.
//

#import "SLMineTableController.h"
#import "SLUserProfileTableController.h"
#import "UIUtils.h"

@interface SLMineTableController ()

@end

@implementation SLMineTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me_bg.png"]];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.titleLabel.font = [Theme pc_fontWithSize:9];
    [editButton setImage:[UIImage imageNamed:@"nav_icon_edit_nro"] forState:UIControlStateNormal];
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [UIUtils setButton:editButton ImagePosition:ETButtonImagePostionUp Padding:5];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:editButton];
}

- (void)edit:(id)sender {
    [self performSegueWithIdentifier:NSStringFromClass([SLUserProfileTableController class]) sender:nil];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(13, 0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = cell.bounds;
        maskLayer.path = maskPath.CGPath;
        cell.layer.mask = maskLayer;
    }
}

@end
