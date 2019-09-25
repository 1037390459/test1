//
//  LXMainBindPhoneView.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/28.
//  Copyright © 2017年 zheng. All rights reserved.
//
typedef enum : NSUInteger {
    LXBindPhoneenum = 0,
    LXStartenum,
} LXMainBindPhoneViewEnum;
#import <UIKit/UIKit.h>
@protocol LXMainBindPhoneViewDelegate <NSObject>
- (void) didSelectbindPhoneBtnClick;   /**<点击添加车辆*/
- (void) didSelectStartBtnClick;       /**<点击开始按钮*/
@end
@interface LXMainBindPhoneView : UIView
@property (nonatomic,strong) UIImageView *logoImage;                    /**< logo图标 */
@property (nonatomic,strong) UILabel *descriptLabel;                    /**< 绑定手机号 */
@property (nonatomic,strong) UIButton *bindPhoneBtn;                    /**< 绑定手机号按钮 */
@property (nonatomic,strong) UIButton *startBtn;                        /**< 开始 */
 @property (nonatomic,weak) id<LXMainBindPhoneViewDelegate> delegate;   /**< 代理*/
@end
