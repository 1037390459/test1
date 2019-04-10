//
//  SLHelpTableController.m
//  智能锁
//
//  Created by million on 2019/4/3.
//  Copyright © 2019 million. All rights reserved.
//

#import "SLHelpTableController.h"
#import "SLSectionHeaderFooterView.h"
#import "SLHelpTypeCell.h"

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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SLSectionHeaderFooterView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SLSectionHeaderFooterView class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SLHelpTypeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SLHelpTypeCell class])];
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
    SLHelpTypeCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SLHelpTypeCell class])];
    [cell configureCellWithTitle:title];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SLSectionHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SLSectionHeaderFooterView class])];
    NSString *title = self.mdata[section][@"header"];
    header.titleLabel.text = title;
    header.titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    header.titleLabel.font = [Theme pc_fontWithSize:14];
    header.selected = [self.expandSections containsObject:@(section)];
    UIImageView *imageView = header.imageView;
    if (header.isSelected) {
        imageView.transform = CGAffineTransformRotate(imageView.transform, M_PI);
    }
    @weakify(header);
    header.onClickedListener = ^(id  _Nonnull sender) {
        @strongify(header);
        if (header.isSelected) {
            [self.expandSections removeObject:@(section)];
        }else{
             [self.expandSections addObject:@(section)];
        }
        [self.tableView reloadSection:section withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 59;
}

@end
