//
//  AppDelegate.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/11/23.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "AppDelegate.h"
#import "LXLoginViewController.h"          // 登录界面
#import "LXMainIndexViewController.h"      // 主页面，
#import "LXLeftMenuListViewController.h"   // 我的车辆列表
#import "CoreNewFeatureVC.h"               // 新特性
#import "AppDelegate+LXPush.h"
#import <AlipaySDK/AlipaySDK.h>
#import "UMessage.h"
#import "MMDrawerVisualState.h" 
#import "MMExampleDrawerVisualStateManager.h"
@interface AppDelegate ()

@property (nonatomic,strong) MMDrawerController * drawerController;

@end

@implementation AppDelegate
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)enterRootViewController:(BOOL)userLogin{
    if (userLogin) {
        self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:self.rootViewController leftDrawerViewController:[LXLeftMenuListViewController new]];
        [self.drawerController setShowsShadow:NO];
        [self.drawerController setMaximumLeftDrawerWidth:kScreenWidth];
        [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        [self.drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
            
            MMDrawerControllerDrawerVisualStateBlock block;
            block = [[MMExampleDrawerVisualStateManager sharedManager]
                     drawerVisualStateBlockForDrawerSide:drawerSide];
            if(block){
                block(drawerController, drawerSide, percentVisible);
            }
            
        }];
        self.window.backgroundColor = [UIColor whiteColor];
        //侧滑效果
        self.window.rootViewController = self.drawerController;
    }else{
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[LXLoginViewController new]];
    }
   
    [self.window.layer transitionWithAnimType:TransitionAnimTypeRamdom
                                      subType:TransitionSubtypesFromRamdom
                                        curve:TransitionCurveRamdom
                                     duration:1.0f];
}
#pragma mark - 返回单例
+ (AppDelegate *)shareInstance {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
} 
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [self.window setBackgroundColor:KLabelColor_white];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[LXLoginViewController new]];
    self.rootViewController = [[UINavigationController alloc] initWithRootViewController:[LXMainIndexViewController new]];
  
    //判断是否需要显示：（内部已经考虑版本及本地版本缓存）
    BOOL canShow = [CoreNewFeatureVC canShowNewFeature]; 
    //测试代码，正式版本应该删除
    
    if(canShow){
        
        NewFeatureModel *m1 = [NewFeatureModel model:[UIImage imageNamed:@"f1"]];
        
        NewFeatureModel *m2 = [NewFeatureModel model:[UIImage imageNamed:@"f2"]];
        
        NewFeatureModel *m3 = [NewFeatureModel model:[UIImage imageNamed:@"f3"]];
        
        self.window.rootViewController = [CoreNewFeatureVC newFeatureVCWithModels:@[m1,m2,m3] enterBlock:^{
            
            NSLog(@"进入主页面");
            [self  enterRootViewController:[LXUserInfoModel shareUser].isLogin];
        }];
    }else{
        
        [self  enterRootViewController:[LXUserInfoModel shareUser].isLogin];
    }
    
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES; // 控制整个功能是否启用。
    manager.shouldResignOnTouchOutside =YES; // 控制点击背景是否收起键盘
    manager.shouldToolbarUsesTextFieldTintColor =YES; 
    //[[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarByPosition];
    /********************************配置推送*******************************/
    //初始化方法,也可以使用(void)startWithAppkey:(NSString *)appKey launchOptions:(NSDictionary * )launchOptions httpsenable:(BOOL)value;这个方法，方便设置https请求。
    [UMessage startWithAppkey:kPushMAppKey launchOptions:launchOptions];
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];
    
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];
     /********************************配置end*******************************/
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//----------------------------------------支付宝回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url
                                         standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}

@end
