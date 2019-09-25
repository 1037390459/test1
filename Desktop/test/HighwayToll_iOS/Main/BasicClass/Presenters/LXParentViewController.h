//
//  LXParentViewController.h
//  PeacockShop
//
//  Created by Cheng on 17/10/17.
//  Copyright © 2017年 LX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXNavItemModel.h"

@interface LXParentViewController : UIViewController
@property (nonatomic, copy) NSString    *className;
typedef void(^selectorBlock)(UIButton *item, NSInteger index);

/**
 *  创建导航按钮(适用于单一按钮的导航)
 *
 *  @param title     按钮上得文字
 *  @param imageName 按钮上的图片
 *  @param selector  按钮的点击方法
 *  @param ret       左边按钮还是右边按钮
 */
- (UIButton *)createNavigationItemWithTitle:(NSString *)title
                                  imageName:(NSString *)imageName
                                     action:(SEL)selector
                                     isLeft:(BOOL)ret;


/**
 *  设置一组item对象
 *
 *  @param array item按钮数组（数组中存放的是 CWNavItemModel对象）
 *  @param block 点击按钮时的回调方法
 */
- (void)addBarButtonItemsWithArray:(NSArray<LXNavItemModel *> *)array
                     selectorBlock:(selectorBlock)block;

/**
 *  移除导航栏上所有button
 */
- (void)removeNavAllButtonItemWithLeft:(BOOL)isLeft;

#pragma mark - 屏幕截图
/**
 *  截取屏幕图片
 *
 *  @param flag 是否透明
 *
 *  @return 生成后的image
 */
- (UIImage *)getScreenImageWithIsAlpha:(BOOL)flag;

/**
 *  根据给定得图片，从其指定区域截取一张新得图片
 *
 *  @param frame    在大图上截取的区域
 *  @param bigImage 要截取的大图bigImage
 *
 *  @return 截取后的image
 */
- (UIImage *)getImageWithFrame:(CGRect)frame
                  fromBigImage:(UIImage *)bigImage;

#pragma mark - 隐藏TabBar
/**
 *  是否隐藏tabBar
 *
 *  @param hidden 是否隐藏
 */
- (void)hideTabBar:(BOOL)hidden;
/**
 *  返回按钮点击方法
 */
- (void)backBtnClick;

#pragma mark - 图片浏览器
/**
 *  图片浏览器
 *
 *  @param urls     图片urls
 *  @param captions 图片描述
 */
- (void)goPhotoBrowserWithImageUrls:(NSArray<NSString *> *)urls
                           captions:(NSArray<NSString *> *)captions
                      selectedIndex:(NSInteger)index;

/**
 弹框提示+取消回调+确认回调
 
 @param title 标题
 @param message 信息
 @param cancel 取消按钮名称
 @param sure 确认按钮名称
 @param cancelHandler 取消回调
 @param sureHandler 确认回调
 */
- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                    cancel:(NSString *)cancel
                      sure:(NSString *)sure
             cancelHandler:(void(^)(void))cancelHandler
               sureHandler:(void(^)(void))sureHandler;

/**
 弹框提示+确认回调
 
 @param title 提示框标题
 @param message 提示信息
 @param cancel 取消按钮
 @param sure 确认按钮
 @param sureHandler 确认回调
 */
- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                    cancel:(NSString *)cancel
                      sure:(NSString *)sure
               sureHandler:(void(^)(void))sureHandler;

/**
 弹窗提示+确认回调
 
 @param message 消息
 @param cancel 取消
 @param sure 确认
 @param sureHandler 确认回调
 */
- (void)showAlertWithmessage:(NSString *)message
                      cancel:(NSString *)cancel
                        sure:(NSString *)sure
                 sureHandler:(void(^)(void))sureHandler;

@end
