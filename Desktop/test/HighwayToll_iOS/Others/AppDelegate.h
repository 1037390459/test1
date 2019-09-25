//
//  AppDelegate.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/23.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h> 
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
+ (AppDelegate *)shareInstance;
@property (nonatomic, strong) id rootViewController;
/**
 *  切换跟控制器
 *
 *  @param userLogin 是否登录
 */
- (void)enterRootViewController:(BOOL)userLogin;
@end

