//
//  LXRootViewController.h
//  PeacockShop
//
//  Created by Cheng on 17/10/18.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "LXParentViewController.h"

@interface LXRootViewController : LXParentViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
{
    UITableView                 *_tableView;
    UICollectionView            *_collectionView;
    UICollectionViewFlowLayout  *_flowLayout;
}

/** 创建UITableView的方法 */
- (void)configTableViewWithFrame:(CGRect)frame;

/** 创建UITableView的方法 */
- (void)configTableViewWithFrame:(CGRect)frame
                           style:(UITableViewStyle)style;

/** 去除tableView的多余的分割线 */
- (void)setExtraCellLineHidden: (UITableView *)tableView;

/** 创建UICollectionView */
//设置横纵向最小间隔和滚动方向
-(void)configCollectionViewWithFrame:(CGRect)frame
                           LineSpace:(NSInteger)line
                              vSpace:(NSInteger)space
                    scrollDirecation:(UICollectionViewScrollDirection)direcation
                           isRefresh:(BOOL)refresh;
/** 创建collectionView */
- (UICollectionView *)createCollectionViewWithFrame:(CGRect)frame
                                          LineSpace:(NSInteger)line
                                             vSpace:(NSInteger)space
                                   scrollDirecation:(UICollectionViewScrollDirection)direcation
                                          isRefresh:(BOOL)refresh;
/** cell自动反选 仅适用于继承的_tableView 其他tableview请用  unselectCurrentRowOfTableView: */
- (void)unselectCurrentRow;
/** cell自动反选 */
- (void)unselectCurrentRowOfTableView:(UITableView *)tableView;

/**
 *  显示消息提醒框
 */
- (void)showTipMessage:(NSString *)message;


@end
