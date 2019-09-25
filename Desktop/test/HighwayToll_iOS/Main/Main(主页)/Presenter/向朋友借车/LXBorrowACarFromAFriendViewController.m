//
//  LXBorrowACarFromAFriendViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/27.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXBorrowACarFromAFriendViewController.h"
#import "LXLendACarToAfriendTextFiledCell.h"
#import "LXLendACarToAfriendSelectCell.h"
#import "LXLendACarToAfriendRemarkCell.h"
#import "LXLendACarToAfriendCommitCell.h"
#import "WSDatePickerView.h"
@interface LXBorrowACarFromAFriendViewController ()
@property (nonatomic,strong) NSMutableArray *titleArray; /**<  */
@property (nonatomic,strong) NSMutableArray *cellArray;  /**<  */
@end
static NSString*const KLXLendACarToAfriendTextFiledCell_dis   = @"KLXLendACarToAfriendTextFiledCell_dis";
static NSString*const KLXLendACarToAfriendSelectCell_dis      = @"LXLendACarToAfriendSelectCell_dis";
static NSString*const KLXLendACarToAfriendRemarkCell_dis      = @"LXLendACarToAfriendRemarkCell_dis";
static NSString*const KLXLendACarToAfriendCommitCell_dis      = @"KLXLendACarToAfriendCommitCell_dis";
@implementation LXBorrowACarFromAFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

/**
 配置UI
 */
- (void)configUI{
    self.title = @"向朋友借车";
    self.titleArray = [NSMutableArray arrayWithObjects:@"手机号",@"用车时间",@"还车时间",@"",@"", nil];
    CGFloat hight =  kNavHeight;
    [self configCollectionViewWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight - hight )
                              LineSpace:5
                                 vSpace:1
                       scrollDirecation:UICollectionViewScrollDirectionVertical
                              isRefresh:NO];
    [_collectionView registerClass:[LXLendACarToAfriendTextFiledCell class]
        forCellWithReuseIdentifier:KLXLendACarToAfriendTextFiledCell_dis];
    [_collectionView registerClass:[LXLendACarToAfriendSelectCell class]
        forCellWithReuseIdentifier:KLXLendACarToAfriendSelectCell_dis];
    [_collectionView registerClass:[LXLendACarToAfriendRemarkCell class]
        forCellWithReuseIdentifier:KLXLendACarToAfriendRemarkCell_dis];
    [_collectionView registerClass:[LXLendACarToAfriendCommitCell class]
        forCellWithReuseIdentifier:KLXLendACarToAfriendCommitCell_dis];
    [_collectionView setBackgroundColor:kRGBColor(242, 242, 242)];
}
- (void)commit{
    NSString *phone = ((LXLendACarToAfriendTextFiledCell *)self.cellArray[0]).contentStr;
    NSString *carTime = ((LXLendACarToAfriendSelectCell *)self.cellArray[1]).contentStr;
    NSString *theCarTime = ((LXLendACarToAfriendSelectCell *)self.cellArray[2]).contentStr;
    NSString *remake = ((LXLendACarToAfriendRemarkCell *)self.cellArray[3]).textView.text;
    if (phone.length  == 0) {
        [LXMessage showErrorMessage:@"手机号码不能为空"];
        return;
    }if (![LXCommon isValidateMobile:phone]) {
        [LXMessage showErrorMessage:@"手机号码格式不正确"];
        return;
    }
    if ([carTime isEqualToString:@"请选择"]) {
        [LXMessage showErrorMessage:@"用车时间不能为空"];
        return;
    }
    if ([theCarTime isEqualToString:@"请选择"]) {
        [LXMessage showErrorMessage:@"还车时间不能为空"];
        return;
    }
    if ([LXDate compareDate:carTime withDate:theCarTime]) {
        [LXMessage showErrorMessage:@"还车时间不能小于用车时间"];
        return;
    }
    if ([remake isEqualToString:@"请填写借出的理由"]) {
        remake = @"";
    }
    [LXMessage showActiveViewOnView:self.view];
    [LXNetManager postWithParamDictionary:[LXInterface postRel_Car_BorrowRequestCarWithPhone:phone
                                                                                     UseTime:carTime
                                                                                  ReturnTime:theCarTime
                                                                                      Remark:remake]
                                                                        finished:^(id responseObj) {
                                                                        [LXMessage hideActiveView];
                                                                            
                                                                            if (responseObj &&
                                                                                [[responseObj objectForKey:@"state"]
                                                                                 integerValue] >= 1) {
                                                                                    [LXMessage showSuccessMessage:@"操作成功"];
                                                                                }else{
                                                                                    [LXMessage showSuccessMessage:@"操作失败，请重试"];
                                                                                }
                                                                        }
                                                                    failed:^(NSError *error) {
                                                                        [LXMessage hideActiveView];
                                                                        [LXMessage showErrorMessage:error.localizedDescription];
                                                                    }];
}
#pragma mark collectionCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXLendACarToAfriendTextFiledCell_dis forIndexPath:indexPath];
        LXLendACarToAfriendTextFiledCell * vCell = (LXLendACarToAfriendTextFiledCell *)cell;
        vCell.titleStr = self.titleArray[indexPath.section];
    }else if (indexPath.section == 3){
        cell =  [collectionView dequeueReusableCellWithReuseIdentifier:KLXLendACarToAfriendRemarkCell_dis forIndexPath:indexPath];
    }else if (indexPath.section == 4){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXLendACarToAfriendCommitCell_dis forIndexPath:indexPath];
        LXLendACarToAfriendCommitCell * vCell = (LXLendACarToAfriendCommitCell *)cell;
        vCell.descrioptStr = @"请确保正确填写对方的手机号码，否则会操作失败";
        LXWeakSelf(self);
        [vCell didSelectClick:^{
            [weakself commit];
        }];
     }else{
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLXLendACarToAfriendSelectCell_dis forIndexPath:indexPath];
        LXLendACarToAfriendSelectCell * vCell = (LXLendACarToAfriendSelectCell *)cell;
        vCell.titleStr = self.titleArray[indexPath.section];
    }cell.tag = indexPath.section;
    [self.cellArray addObject:cell];
    return cell;
}
-  (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return CGSizeMake(kWidth, 165);
    }else if (indexPath.section == 4) {
        return CGSizeMake(kWidth, 100);
    }
    return CGSizeMake(kWidth, kCellHeight);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if(section == 0 )return UIEdgeInsetsMake(5, 0, 1, 0);
    return  UIEdgeInsetsMake(0, 0, 1, 0);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.titleArray.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 ||
        indexPath.section == 2) {
        LXLendACarToAfriendSelectCell *cell = (LXLendACarToAfriendSelectCell *)[collectionView cellForItemAtIndexPath:indexPath];
        LXWeakSelf(cell)
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
            weakcell.contentStr = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
            
        }];
        datepicker.dateLabelColor = [UIColor orangeColor];//年-月-日-时-分 颜色
        datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
        datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
        [datepicker show];
    } 
}
- (NSMutableArray *)cellArray{
    if (!_cellArray) {
        _cellArray = [[NSMutableArray alloc] init];
    }
    return _cellArray;
}
@end
