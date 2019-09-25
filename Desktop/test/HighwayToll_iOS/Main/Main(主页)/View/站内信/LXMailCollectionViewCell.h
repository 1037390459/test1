//
//  LXMailCollectionViewCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/27.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXMailCollectionViewCell : UICollectionViewCell
@property (nonatomic,copy) NSString *contentStr;    /**< 内容文本 */
@property (nonatomic,copy) NSString *addTimeStr;    /**< 添加时间 */
@property (nonatomic,copy) NSString *titleStr;      /**< 标题文本 */
@end
