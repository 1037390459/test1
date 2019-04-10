//
//  SLHelpTableController.m
//  智能锁
//
//  Created by million on 2019/4/3.
//  Copyright © 2019 million. All rights reserved.
//

#import "SLHelpTableController.h"
#import "SLHelpType1Cell.h"
#import "SLHelpType2Cell.h"
#import "SLHelpModel.h"

@interface SLHelpTableController ()

@property(nonatomic, strong) NSArray *mdata;
@property (strong, nonatomic) NSMutableArray *expandSections;

@end

@implementation SLHelpTableController

- (NSArray *)mdata {
    if (!_mdata) {
        _mdata = @[
                   @{@"header":@"关于充值的常见问题",
                     @"items":@[@"1、客户提供详细文案客户提供详细文案客户提供详细文案客户提供详细文案客户提供详细文案客户提供详细文案客户供详细文案客户提供详细文案",@"11、客户提供详细文案客户提供详细文案客户提供详细文案客户提供详细文案客户提供详细文案客户提供详细文案客户供详细文案客户提供详细文案"]},
                   @{@"header":@"关于充值的常见问题",
                     @"items":@[@"2、客户提供详细文案客户提供详细文案客户提供详细文案客户提供详细文案客户提供详细文案客户提供详细文案客户供详细文案客户提供详细文案"]},
                   ];
    }
    return _mdata;
}

- (NSMutableArray *)expandSections {
    if (!_expandSections) {
        _expandSections = [NSMutableArray array];
    }
    return _expandSections;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg.png"]];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SLHelpType1Cell class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SLHelpType1Cell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SLHelpType2Cell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SLHelpType2Cell class])];
}

#pragma mark tableview datasource & delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.mdata.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BOOL expand = [self.expandSections containsObject:@(section)];
    return expand ? [self.mdata[section][@"items"] count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title =  self.mdata[indexPath.section][@"items"][indexPath.row];
    SLHelpType2Cell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SLHelpType2Cell class])];
    [cell configureCellWithTitle:title];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SLHelpType1Cell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SLHelpType1Cell class])];
    NSString *title = self.mdata[section][@"header"];
    [cell configureCellWithTitle:title];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        cell.selected = !cell.isSelected;
        if (cell.isSelected) {
            [self.expandSections addObject:@(section)];
        }else{
            [self.expandSections removeObject:@(section)];
        }
        [self.tableView reloadSection:section withRowAnimation:UITableViewRowAnimationFade];
    }];
    [cell addGestureRecognizer:tap];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}


@end
