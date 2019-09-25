//
//  LXBorrowTheCarHadTextCollectionViewCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/6.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^refreshBlock)(void);

typedef void(^sendeBlock)(NSString *);

typedef void(^cancelBlock)(void);

@interface LXBorrowTheCarHadTextCollectionViewCell : UIView

//点击刷新
@property(nonatomic, copy)refreshBlock refreshBlock;

//发送Block
@property(nonatomic, copy)sendeBlock sendeBlock;

//取消block
@property(nonatomic, copy)cancelBlock cancelBlock;

-(void)SetCellValue;

@end
