//
//  LXMainIndexSelectCarCollectionViewCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/4.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXMainIndexSelectCarCollectionViewCell : UICollectionViewCell
@property (nonatomic,assign) bool isSelect;       /**< */
@property (nonatomic,assign) bool isSelectType;   /**< */
@property (nonatomic,assign) bool isDefault   ;   /**< */
@property (nonatomic,copy)   NSString *plateStr;  /**< 车牌号 */

@end
