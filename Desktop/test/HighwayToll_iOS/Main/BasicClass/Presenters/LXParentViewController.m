//
//  LXParentViewController.m
//  PeacockShop
//
//  Created by Cheng on 17/10/17.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "LXParentViewController.h"
#import "IQKeyboardManager.h"
#import "AppDelegate.h"
#define kBackTipKey [NSString stringWithFormat:@"backtip-%@",[LXDeviceManager currentAppVersion]]
#define SYSTEM_VERSION [[UIDevice currentDevice].systemVersion floatValue]
@interface LXParentViewController ()<MWPhotoBrowserDelegate>
{
    selectorBlock               _selectorBlock;
}
@property (nonatomic, copy) void(^alertSureHandler)(void);
@property (nonatomic, copy) void(^alertCancelHandler)(void);

@property (nonatomic, strong) NSMutableArray    *photos;
@property (nonatomic, strong) NSMutableArray    *thumbs;
@property (nonatomic, strong) NSMutableArray    *titles;
@end

@implementation LXParentViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[SDImageCache sharedImageCache] setShouldDecompressImages:NO];
    [[SDWebImageDownloader sharedDownloader] setShouldDecompressImages:NO];
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [[SDImageCache sharedImageCache] clearMemory];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //[self hideTabBar:YES];
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self removeNavAllButtonItemWithLeft:NO];
    self.className = [NSString stringWithUTF8String:object_getClassName(self)];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([LXDeviceManager currentVersion]>=7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    // 修改导航栏颜色 kRGBColor(209, 49, 53)
    [self.navigationController.navigationBar setBarTintColor:kRGBColor(255, 255, 255)];
    //    self.navigationController.navigationBar.translucent = NO;
    
    // 修改导航栏字体
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:IS_IPAD?[UIFont boldSystemFontOfSize:20]:[UIFont systemFontOfSize:17],
                                                                       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    // 开启侧滑返回
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    [self createNavigationItemWithTitle:nil
                              imageName:@"back"
                                 action:@selector(backBtnClick)
                                 isLeft:YES];
}


/**
 *  根据给定得图片，从其指定区域截取一张新得图片
 *
 *  @param frame    在大图上截取的区域
 *  @param bigImage 要截取的大图bigImage
 *
 *  @return 截取后的image
 */
- (UIImage *)getImageWithFrame:(CGRect)frame fromBigImage:(UIImage *)bigImage
{
    CGImageRef imageRef = bigImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, frame);
    CGSize size;
    size.width = 150;
    size.height = 150;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, frame, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    return smallImage;
}


#pragma mark - 跳转到指定的controller
- (void)jumpToViewController:(id)viewcontroller isPush:(BOOL)isPush
{
    if (isPush) {
        [self.navigationController pushViewController:viewcontroller animated:YES];
    }else{
        [self presentViewController:viewcontroller animated:YES completion:nil];
    }
}

#pragma mark - 隐藏TabBar
- (void)hideTabBar:(BOOL)hidden{
    if (hidden ) {
        if (self.tabBarController.tabBar.hidden == YES) {
            return;
        }
        UIView *contentView;
        if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
            contentView = [self.tabBarController.view.subviews objectAtIndex:1];
        else
            contentView = [self.tabBarController.view.subviews objectAtIndex:0];
        contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  kWidth, kHeight + self.tabBarController.tabBar.frame.size.height);
        self.tabBarController.tabBar.hidden = YES;
    }else{
        if (self.tabBarController.tabBar.hidden == NO)
        {
            return;
        }
        UIView *contentView;
        if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
            contentView = [self.tabBarController.view.subviews objectAtIndex:1];
        
        else
            
            contentView = [self.tabBarController.view.subviews objectAtIndex:0];
        contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  kWidth, kHeight - self.tabBarController.tabBar.frame.size.height);
        self.tabBarController.tabBar.hidden = NO;
        
       
    }
 
}
 

- (void)removeAppFunctionGuidePage:(UIButton *)btn
{
    btn.hidden = YES;
    [btn removeFromSuperview];
}

#pragma mark - 图片浏览器
- (void)goPhotoBrowserWithImageUrls:(NSArray<NSString *> *)urls
                           captions:(NSArray<NSString *> *)captions
                      selectedIndex:(NSInteger)index
{
    // Browser
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    NSMutableArray *thumbs = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    MWPhoto *photo;
    MWPhoto *photo2;
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = YES;
    BOOL enableGrid = YES;
    BOOL startOnGrid = NO;
    
    for (NSInteger i = 0; i< urls.count; i++) {
        NSString *url = urls[i];
        photo = [MWPhoto photoWithURL:[NSURL URLWithString:url]];
        photo2 = [MWPhoto photoWithURL:[NSURL URLWithString:url]];
        if (captions && captions.count>i) {
            photo.caption = @"车辆图片";
            photo2.caption = @"车辆图片";
            [titles addObject:captions[i]];
        }
        [photos addObject:photo];
        [thumbs addObject:photo2];
    }
    
    // Options
    self.photos = photos;
    self.thumbs = thumbs;
    self.titles = titles;
    
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;//分享按钮,默认是
    browser.displayNavArrows = displayNavArrows;//左右分页切换,默认否
    browser.displaySelectionButtons = displaySelectionButtons;//是否显示选择按钮在图片上,默认否
    browser.alwaysShowControls = displaySelectionButtons;//控制条件控件 是否显示,默认否
    browser.zoomPhotosToFill = YES;//是否全屏,默认是
    browser.autoPlayOnAppear = YES;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    browser.wantsFullScreenLayout = YES;//是否全屏
#endif
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
#endif
    browser.enableGrid = enableGrid;//是否允许用网格查看所有图片,默认是
    browser.startOnGrid = startOnGrid;//是否第一张,默认否
    browser.enableSwipeToDismiss = YES;
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    [browser setCurrentPhotoIndex:index];
    [self.navigationController pushViewController:browser animated:YES];
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id )photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index
{
    if (index < self.thumbs.count) {
        return [self.thumbs objectAtIndex:index];
    }
    return nil;
}


#pragma mark - 获取当前类名
- (NSString *)className
{
    return [NSString stringWithUTF8String:object_getClassName(self)];
}

#pragma mark - 创建导航按钮
- (UIButton *)createNavigationItemWithTitle:(NSString *)title
                                  imageName:(NSString *)imageName
                                     action:(SEL)selector
                                     isLeft:(BOOL)ret
{
    UIButton *button = [LXView createButtonWithFrame:CGRectMake(0, 20, 34, 44)
                                               title:title
                                           imageName:imageName
                                         bgImageName:nil
                                              radius:0
                                              target:self
                                              action:selector
                                                color:nil];
    button.userInteractionEnabled = YES;
    [button setTitleColor:KLabelColor_white forState:UIControlStateNormal];
    
    if (ret) {
       // button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button]; 
    }else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.titleLabel.minimumScaleFactor = 6;
    
    if (imageName == nil) {
        button.width = 80;
        [button.titleLabel sizeToFit];
    }
    
    return button;
}

#pragma mark - 设置一组item对象
- (void)addBarButtonItemsWithArray:(NSArray<LXNavItemModel *> *)array
                     selectorBlock:(selectorBlock)block
{
    NSMutableArray *leftItems = [[NSMutableArray alloc] init];
    NSMutableArray *rightItems = [[NSMutableArray alloc] init];
    
    for (NSInteger i=0; i<array.count; i++) {
        LXNavItemModel *model = array[i];
        //利用数据模型进行后续设置
        UIButton *button = [LXView createButtonWithFrame:CGRectMake(0, 0, 34, 44)
                                                   title:model.title
                                               imageName:model.imageName
                                             bgImageName:nil
                                                  radius:0
                                                  target:self
                                                  action:@selector(itemButtonClicked:)
                                                    color:nil];
        button.tag = 100 + i;
        [button setTitleColor:KLabelColor_white forState:UIControlStateNormal];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        if (model.isLeft) {
            [leftItems addObject:item];
        }else{
            [rightItems addObject:item];
        }
        
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.titleLabel.minimumScaleFactor = 6;
        
        if (model.imageName == nil || model.imageName.length == 0) {
            button.width = [LXCommon getWidthForString:model.title fontSize:16 viewHeight:44];
        }
        
        [button.titleLabel sizeToFit];
    }
    
    self.navigationItem.leftBarButtonItems = leftItems;
    self.navigationItem.rightBarButtonItems = rightItems;
    
    if(!_selectorBlock){
        _selectorBlock = block;
    }
}

/**
 *  导航按钮点击的方法
 *
 *  @param sender 按钮
 */
- (void)itemButtonClicked:(UIButton *)sender {
    if (_selectorBlock) {
        _selectorBlock(sender, sender.tag - 100);
    }
}

/**
 *  移除导航栏上所有button
 */
- (void)removeNavAllButtonItemWithLeft:(BOOL)isLeft
{
    if (isLeft) {
        [self.navigationItem.leftBarButtonItem.customView removeFromSuperview];
        self.navigationItem.leftBarButtonItem.customView = nil;
        self.navigationItem.leftBarButtonItem = nil;
    } else {
        [self.navigationItem.rightBarButtonItem.customView removeFromSuperview];
        self.navigationItem.rightBarButtonItem.customView = nil;
        self.navigationItem.rightBarButtonItem = nil;
    }
}

/**
 *  返回按钮点击方法
 */
- (void)backBtnClick
{
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kBackTipKey]) {
        [[LXMessage shareMessage] show:@"高速公路页面都支持侧滑，您可以体验一下侧滑返回。"
                              tipTitle:@"温馨提示"
                              oneTitle:@"知道了"
                               Clicked:^(NSInteger buttonIndex) {
                                   
                               }];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kBackTipKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return;
    }
    
    [kWindow endEditing:YES];
    if (self.navigationController.viewControllers.count >1) {
        self.hidesBottomBarWhenPushed = NO;
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark 弹框
//弹框 取消回调 确认回调
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel sure:(NSString *)sure cancelHandler:(void(^)(void))cancelHandler sureHandler:(void(^)(void))sureHandler
{
    //避免弹出框和键盘响应事件冲突
    if (SYSTEM_VERSION >= 8.0) {//8.0 以上版本
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        if (sure && sure.length >0) {
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sure style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (sureHandler) {
                    sureHandler();
                }
            }];
            [alertVC addAction:sureAction];
        }
        if (cancel && cancel.length >0) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (cancelHandler) {
                    cancelHandler();
                }
            }];
            [alertVC addAction:cancelAction];
        }
        [self presentViewController:alertVC animated:YES completion:nil];
    }else{//8.0 一下版本
        self.alertSureHandler = sureHandler;
        self.alertCancelHandler = cancelHandler;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"提示文字" delegate:self cancelButtonTitle:cancel otherButtonTitles:sure, nil];
        [alertView show];
    }
}

// 无取消回调
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel sure:(NSString *)sure sureHandler:(void(^)(void))sureHandler{
    
    [self showAlertWithTitle:title message:message cancel:cancel sure:sure cancelHandler:nil sureHandler:sureHandler];
}

//无标题 无取消回调
- (void)showAlertWithmessage:(NSString *)message cancel:(NSString *)cancel sure:(NSString *)sure sureHandler:(void(^)(void))sureHandler
{
    [self showAlertWithTitle:nil message:message cancel:cancel sure:sure cancelHandler:nil sureHandler:sureHandler];
}

//alert view弹框回调
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (self.alertCancelHandler) {
            self.alertCancelHandler();
        }
    }else{
        if (self.alertSureHandler) {
            self.alertSureHandler();
        }
    }
}


@end
