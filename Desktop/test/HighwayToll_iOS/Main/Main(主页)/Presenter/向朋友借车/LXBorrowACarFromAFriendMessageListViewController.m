//
//  LXBorrowACarFromAFriendMessageListViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/28.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXBorrowACarFromAFriendMessageListViewController.h"
#import "LXBorrowACarFromAFriendMessageListSuccessCell.h"
#import "LXBorrowACarFromAFriendMessageListFailCell.h"
@interface LXBorrowACarFromAFriendMessageListViewController ()
@property (nonatomic,strong) UIButton *rightBtn; /**<  */
@end
static NSString*const KLXBorrowACarFromAFriendMessageListFailCell_dis = @"LXBorrowACarFromAFriendMessageListFailCell_dis";
static NSString*const KLXBorrowACarFromAFriendMessageListSuccessCell_dis = @"LXBorrowACarFromAFriendMessageListSuccessCell_dis";
@implementation LXBorrowACarFromAFriendMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

- (void)configUI{
    self.title = @"向朋友借车";
    //--------------------------------------------start---------------------------------
    UIButton *rightBtn =  [self createNavigationItemWithTitle:@"清空列表"
                                                    imageName:nil
                                                       action:@selector(removeAllClick)
                                                       isLeft:NO];
    [rightBtn setTitleColor:[UIColor blackColor] forState:0];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:kfontValue(13)]];
    //--------------------------------------------end-----------------------------------
    CGFloat hight =  kNavHeight;
    [self configCollectionViewWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight - hight )
                              LineSpace:5
                                 vSpace:1
                       scrollDirecation:UICollectionViewScrollDirectionVertical
                              isRefresh:NO];
    [_collectionView setBackgroundColor:kRGBColor(245, 245, 245)];
    [_collectionView registerClass:[LXBorrowACarFromAFriendMessageListFailCell class]
        forCellWithReuseIdentifier:KLXBorrowACarFromAFriendMessageListFailCell_dis];
    [_collectionView registerClass:[LXBorrowACarFromAFriendMessageListSuccessCell class]
        forCellWithReuseIdentifier:KLXBorrowACarFromAFriendMessageListSuccessCell_dis];
}
- (void)removeAllClick{
    [LXMessage showInfoMessage:@"清除成功"];
}
#pragma mark collectionCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = nil;
    if (indexPath.item == 1) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXBorrowACarFromAFriendMessageListFailCell_dis
                                                         forIndexPath:indexPath];
    }else{
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXBorrowACarFromAFriendMessageListSuccessCell_dis
                                                         forIndexPath:indexPath];
    }
    return cell;
}
-  (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0) {
             return CGSizeMake(kWidth, 215);
    }  return CGSizeMake(kWidth, 128);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return  UIEdgeInsetsMake(5, 0, 0, 0);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

@end
