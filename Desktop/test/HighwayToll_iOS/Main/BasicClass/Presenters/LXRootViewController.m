//
//  LXRootViewController.m
//  PeacockShop
//
//  Created by Cheng on 17/10/18.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "LXRootViewController.h"

@interface LXRootViewController ()

@end

@implementation LXRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KLabelColor_white;
    // Do any additional setup after loading the view.
}


#pragma mark - 创建UITableView的方法
- (void)configTableViewWithFrame:(CGRect)frame
{
    if([LXDeviceManager currentVersion] >=7.0){
        //ios7.0之后出现的属性
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //初始化  frame子类可以重新赋值
    _tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    [self setExtraCellLineHidden:_tableView];
}

#pragma mark - 创建UITableView的方法
- (void)configTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if([LXDeviceManager currentVersion] >=7.0){
        //ios7.0之后出现的属性
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //初始化  frame子类可以重新赋值
    _tableView = [[UITableView alloc]initWithFrame:frame style:style];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
#define modefied by lone 表格视图会增加空白头部view
    //    [self setExtraCellLineHidden:_tableView];
}

#pragma mark - 创建UICollectionView
- (void)configCollectionViewWithFrame:(CGRect)frame
                            LineSpace:(NSInteger)line
                               vSpace:(NSInteger)space
                     scrollDirecation:(UICollectionViewScrollDirection)direcation
                            isRefresh:(BOOL)refresh
{
    if([LXDeviceManager currentVersion] >= 7.0){
        //ios7.0 之后出现的属性
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //UICollectionViewFlowLayout 是系统提供的能够实现cell的网格布局
    _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _flowLayout.minimumInteritemSpacing = space;
    _flowLayout.minimumLineSpacing = line;
    [_flowLayout setScrollDirection:direcation];
    
    //利用布局对象 实现集合视图的初始化 frame子类可以重新赋值
    _collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:_flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    if (refresh) {
        [_collectionView mjrefreshData];
    }
    [self.view addSubview:_collectionView];
}

#pragma mark - 创建UICollectionView
- (UICollectionView *)createCollectionViewWithFrame:(CGRect)frame
                                          LineSpace:(NSInteger)line
                                             vSpace:(NSInteger)space
                                   scrollDirecation:(UICollectionViewScrollDirection)direcation
                                          isRefresh:(BOOL)refresh
{
    if([LXDeviceManager currentVersion] >= 7.0){
        //ios7.0 之后出现的属性
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //UICollectionViewFlowLayout 是系统提供的能够实现cell的网格布局
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.minimumInteritemSpacing = space;
    fl.minimumLineSpacing = line;
    [fl setScrollDirection:direcation];
    
    //利用布局对象 实现集合视图的初始化 frame子类可以重新赋值
    UICollectionView * cv = [[UICollectionView alloc]initWithFrame:frame
                                              collectionViewLayout:fl];
    cv.delegate = self;
    cv.dataSource = self;
    cv.backgroundColor = [UIColor whiteColor];
    if (refresh) {
        [cv mjrefreshData];
    }
    return cv;
}
#pragma mark - 去除tableView的多余的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}

#pragma mark - UITableView DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DLog(@"子类使用TableView必须重写此方法");
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"子类使用TableView必须重写此方法");
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews
{
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,15,0,0)];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0,15,0,0)];
    }
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"子类必须重写此方法");
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"子类必须重写此方法");
    return nil;
}

/** cell自动反选 */
- (void)unselectCurrentRow
{
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}

/** cell自动反选 */
- (void)unselectCurrentRowOfTableView:(UITableView *)tableView
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

- (void)showTipMessage:(NSString *)message
{
    [LXMessage show:message
             onView:kWindow
         autoHidden:YES];
}

#pragma mark - 页面消失，取消界面编辑
- (void)viewWillDisappear:(BOOL)animated{
    [self.view endEditing:YES];
    [super viewWillDisappear:animated];
}

@end
