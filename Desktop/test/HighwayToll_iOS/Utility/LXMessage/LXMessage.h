//
//  YFMessage.h
//
//  Created by Dandre on 16/3/22.
//  Copyright © 2016年 Dandre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXView.h"
#import "MBProgressHUD.h"

typedef void(^AlertButtonClickedBlock)(NSInteger buttonIndex);

/**< 消息提示 */
@interface LXMessage : NSObject <UIAlertViewDelegate>

@property (nonatomic, strong) MBProgressHUD *hudView;
@property (nonatomic, strong) UIView *noContentTipView;
@property (nonatomic, copy) AlertButtonClickedBlock block;

+ (LXMessage *)shareMessage;

/**
 *  提示框
 *
 *  @param massage 提示的内容
 */
+ (void)alert:(NSString *)massage;

/**
 *  提示框
 *
 *  @param message 提示的内容
 */
+ (void)show:(id)message;

/**
 *  提示框
 *
 *  @param massage 提示的内容
 *  @param title 标题
 */
+ (void)show:(NSString *)massage title:(NSString *)title;

/**
 *  提示框
 *
 *  @param message 提示的内容
 */
- (void)show:(id)message okTitle:(NSString *)title Clicked:(AlertButtonClickedBlock)block;

/**
 *  提示框
 *
 *  @param message 提示的内容
 */
- (void)show:(id)message tipTitle:(NSString *)tipTitle okTitle:(NSString *)okTitle Clicked:(AlertButtonClickedBlock)block;
- (void)show:(id)message tipTitle:(NSString *)tipTitle oneTitle:(NSString *)okTitle Clicked:(AlertButtonClickedBlock)block;

+ (void)show:(id)message tipTitle:(NSString *)tipTitle okTitle:(NSString *)okTitle cancel:(NSString *)cancelTitle Clicked:(AlertButtonClickedBlock)block;
/**
 *  提示框
 *
 *  @param message 提示的内容
 *  @param title  确定按钮现实的文字
 */
+ (void)show:(id)message okTitle:(NSString *)title Clicked:(AlertButtonClickedBlock)block;

/**
 *  提示框
 *
 *  @param tipTitle 提示的标题
 *  @param message  提示的内容
 *  @param okTitle  确定按钮现实的文字
 */
+ (void)show:(id)message
    tipTitle:(NSString *)tipTitle
     okTitle:(NSString *)okTitle
     Clicked:(AlertButtonClickedBlock)block;

/**
 *  可以自动隐藏的提示
 *
 *  @param message 提示的内容
 *  @param view    提示视图要显示在的视图
 *  @param flag    是否自动隐藏
 */
+ (void)show:(id)message onView:(UIView *)view autoHidden:(BOOL)flag;

/**
 *  创建并显示小菊花
 */
+ (void)showActiveViewOnView:(UIView *)view;
+ (void)showActiveViewWithTipString:(NSString *)tipString
                             onView:(UIView *)view;
/**
 *  小菊花-无超时限制
 */
+ (void)showActiveViewMessage:(NSString *)tipString
                onView:(UIView *)view;
/**
 *  隐藏小菊花
 */
+ (void)hideActiveView;
/**
 *  隐藏小菊花
 */
+ (void)hideActiveView:(UIView *)view;

/**
 *  显示无内容提示
 *
 *  @param message 提示的文字
 *  @param image   显示的图片
 *  @param view    显示所在的视图
 */
+ (UIView *)showNoContentTip:(NSString *)message
                   image:(NSString *)image
                  onView:(UIView *)view;



/**
 *  隐藏无内容提示视图
 */
+ (void)hideNoContentTipView;

/**
 *  显示HUD提示
 *
 *  @param message        提示的文字
 *  @param image          提示的image
 *  @param viewController delegate
 *  @param autoHidden     是否自动隐藏
 */
+ (void)show:(id)message
       image:(UIImage *)image
    delegate:(__kindof UIViewController *)viewController
  autoHidden:(BOOL)autoHidden;
 
/**
 *  提示框
 *
 *  @param message 提示的内容
 */
+ (void)show:(id)message
    tipTitle:(NSString *)tipTitle
     okTitle:(NSString *)okTitle
 cancelTitle:(NSString *)cancelTitle
   textAlign:(NSTextAlignment)textAlign
     Clicked:(AlertButtonClickedBlock)block;

/**
 *  成功提示框
 *
 *  @param Message 提示的内容
 */
+ (void)showSuccessMessage:(NSString *)Message;
/**
 *  错误提示框
 *
 *  @param Message 提示的内容
 */
+ (void)showErrorMessage:(NSString *)Message;
/**
 *  信息提示框
 *
 *  @param Message 提示的内容
 */
+ (void)showInfoMessage:(NSString *)Message;
/**
 *  警告提示框
 *
 *  @param Message 提示的内容
 */
+ (void)showWarnMessage:(NSString *)Message;
/**
   显示或者隐藏加载动画
 */
+ (void)showOrHideLoadAnimation;
- (void)show:(id)message
     okTitle:(NSString *)title
     Clicked:(AlertButtonClickedBlock)block
ViewController:(UIViewController *)VC;
@end
