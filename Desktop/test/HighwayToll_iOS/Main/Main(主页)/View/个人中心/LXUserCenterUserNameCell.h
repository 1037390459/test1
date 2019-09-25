//
//  LXUserCenterUserNameCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/28.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LXUserCenterUserNameCellBlock)(void);
@interface LXUserCenterUserNameCell : UICollectionViewCell
@property (nonatomic,copy)   NSString *userName;                  /**< 昵称 */
@property (nonatomic,strong) UIButton *headImage;                 /**< 用户管理 */
@property (nonatomic,copy) LXUserCenterUserNameCellBlock  block;    /**<  */
- (void)UpLoadPic:(LXUserCenterUserNameCellBlock)block;                                                  /**< 上传图片 */
@end
