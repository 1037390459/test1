//
//  LXMyMessageCollectionViewCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/28.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXMyMessageCollectionViewCell : UICollectionViewCell
@property (nonatomic,copy) NSString *imageName;     /**< 图片名称 */
@property (nonatomic,copy) NSString *contentStr;    /**< 内容文本 */
@property (nonatomic,copy) NSString *addTimeStr;    /**< 添加时间 */
@property (nonatomic,copy) NSString *titleStr;      /**< title */
@property (nonatomic,assign) NSInteger number;           /**< 读取*/
@end
