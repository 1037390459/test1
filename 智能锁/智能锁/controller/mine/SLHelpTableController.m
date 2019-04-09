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

@property(nonatomic, strong) NSMutableArray *mdata;

@end

@implementation SLHelpTableController

-(NSMutableArray *)mdata {
    if (!_mdata) {
        NSMutableArray *mArr = [NSMutableArray array];
        NSArray *dicArr = @[
                   @{@"title":@"关于充值的常见问题",
                     @"type":@(1)},
                   @{@"title":@"1、客户提供详细文案客户提供详细文案客户提供详细文案客户提供详细文案客户提供详细文案客户提供详细文案客户供详细文案客户提供详细文案",
                     @"type":@(2),
                     @"hidden":@(true)},
                   @{@"title":@"关于充值的常见问题",
                     @"type":@(1),},
                   @{@"title":@"2、客户提供详细文案客户提供详细文案客户提供详细文案客户提供详细文案客户提供详细文案客户提供详细文案客户供详细文案客户提供详细文案",
                     @"type":@(2),
                     @"hidden":@(true)},
                   @{@"title":@"关于充值的常见问题",
                     @"type":@(1),},
                   @{@"title":@"3、客户提供详细文案客户提供详细文案客户提供详细文案客户提供详细文案客户提供详细文案客户提供详细文案客户供详细文案客户提供详细文案",
                     @"type":@(2),
                     @"hidden":@(true)},
                   ];
        for (NSDictionary *dic in dicArr) {
            SLHelpModel *model = [[SLHelpModel alloc]initWithDic:dic];
            [mArr addObject:model];
        }
        _mdata = mArr;
    }
    return _mdata;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg.png"]];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SLHelpType1Cell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SLHelpType1Cell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SLHelpType2Cell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SLHelpType2Cell class])];
}

#pragma mark tableview datasource & delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SLHelpModel *model =  self.mdata[indexPath.row];
    if (model.type == 1) {
        SLHelpType1Cell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SLHelpType1Cell class])];
        [cell configureCellWithTitle:model.title];
        return cell;
    }
    if (model.type == 2) {
        SLHelpType2Cell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SLHelpType2Cell class])];
        [cell configureCellWithTitle:model.title];
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SLHelpModel *model =  self.mdata[indexPath.row];
    return model.hidden ? 0 : UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SLHelpModel *model =  self.mdata[indexPath.row];
    NSInteger cellType = model.type;
    if (cellType == 1){
        [tableView updateWithBlock:^(UITableView * _Nonnull tableView) {
            SLHelpModel *model2 =  self.mdata[indexPath.row+1];
            model2.hidden = !model2.hidden;
        }];
    }
}

@end
