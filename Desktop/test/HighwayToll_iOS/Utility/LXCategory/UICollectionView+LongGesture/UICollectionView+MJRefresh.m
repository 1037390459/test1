//
//  UICollectionView+MJRefresh.m
//  PeacockShop
//
//  Created by Cheng on 17/11/2.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "UICollectionView+MJRefresh.h"
@implementation UICollectionView (MJRefresh)
//添加刷新
- (void)mjrefreshData{
    //-------------所有------------------
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self,@"collection", nil];
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    
        [[NSNotificationCenter defaultCenter] postNotificationName:KLXNOTIFICATION_onBottomRefreshNotice object:self userInfo:dic];
    }];

    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:KLXNOTIFICATION_onHeadRefreshNotice object:nil userInfo:dic];
    }];
}


@end
