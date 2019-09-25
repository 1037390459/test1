//
//  LXMainAddVehicleView.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/28.
//  Copyright © 2017年 zheng. All rights reserved.
//
typedef enum : NSUInteger {
    LXAddVehicle = 0, 
    LXStartBtn,
    LXBorrowCar,
} LXMainAddVehicleEnum;
@protocol LXMainAddVehicleViewDelegate <NSObject>
- (void) didSelectAddVehicleClick;   /**<点击添加车辆*/
- (void) didSelectStartBtnClick;     /**<点击开始按钮*/
- (void) didSelectBorrowCarClick;    /**<点击借呗*/
@end
#import <UIKit/UIKit.h>
@interface LXMainAddVehicleView : UIView
@property (nonatomic,strong) UIImageView *logoImage;            /**< logo标注 */
@property (nonatomic,strong) UILabel *descriptLabel;            /**< 描述 */
@property (nonatomic,strong) UIButton *addVehicleBtn;           /**< 添加车辆 */
@property (nonatomic,strong) UIButton *borrowCarBtn;            /**< 借 */
@property (nonatomic,strong) UIButton *rightBtn;                /**< 右边 */
@property (nonatomic,strong) UIButton *startBtn;                /**< 开始 */
 @property (nonatomic,weak) id<LXMainAddVehicleViewDelegate> delegate;  /**< 代码*/
@end

