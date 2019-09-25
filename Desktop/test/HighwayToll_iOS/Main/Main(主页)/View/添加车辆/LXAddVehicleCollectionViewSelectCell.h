//
//  LXAddVehicleCollectionViewSelectCell.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/24.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LXAddVehicleCollectionViewSelectCellBlock)(void);
typedef void (^LXAddVehicleCollectionViewSwitchClickBlock)(bool flag);
@interface LXAddVehicleCollectionViewSelectCell : UICollectionViewCell
@property (nonatomic,assign) bool isDefault;                /**< 是不是默认 */ 
@property (nonatomic,copy)   NSString  *strTitle;           /**< 字符串 */
@property (nonatomic,strong) NSString  *contentStr;         /**< 内容文本 */ 
@property (nonatomic,strong)  UIButton *contentBtn;        /**< 内容文本框 */
@property (nonatomic,copy) LXAddVehicleCollectionViewSelectCellBlock block;        /**<  */
@property (nonatomic,copy) LXAddVehicleCollectionViewSwitchClickBlock switchBlock; /**<  */
- (void)didSelectTypeClick:(LXAddVehicleCollectionViewSelectCellBlock)block;
- (void)didSelectSwitchClick:(LXAddVehicleCollectionViewSwitchClickBlock)block;
@end
