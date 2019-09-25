//
//  LXAddVehicleEngineAndColorViewCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/30.
//  Copyright © 2017年 zheng. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface LXAddVehicleEngineAndColorViewCell : UICollectionViewCell  
@property (nonatomic,copy) NSString  *strTitle;                  /**< 字符串 */
@property (nonatomic,copy) NSString  *colorStr;                  /**< 车身颜色 */
@property (nonatomic,copy) NSString  *EngineNo;                  /**< 发动机号 */
@end
