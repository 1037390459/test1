//
//  LXUserCenterLabelCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/29.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXUserCenterLabelCell : UICollectionViewCell
@property (nonatomic,copy) NSString  *titleStr;               /**<  */
@property (nonatomic,copy) NSString  *contentStr;             /**<  */
@property (nonatomic,assign) bool  isShowWechat;              /**<  */
@end
