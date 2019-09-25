//
//  LZBSegmentBarViewController.h
//  LZBSegmentBar
//
//  Created by zibin on 2017/8/14.
//  Copyright © 2017年 lzbgithubcode. All rights reserved.
//

//// 1.创建标题
//NSArray *titles = @[@"英雄联盟",@"火蓝",@"提姆队长",@"史前巨鳄",@"洛克萨斯之手",@"狗头",@"武器"];
////2.创建需要使用的控制器数组
//for (NSInteger i = 0; i < titles.count; i++) {
//    UIViewController *vc = [[UIViewController alloc]init];
//    vc.view.backgroundColor = [UIColor getRandomColor];
//    UILabel *label = [UILabel new];
//    label.text = titles[i];
//    label.textColor = [UIColor blueColor];
//    label.center = CGPointMake(150, 200);
//    label.textAlignment = NSTextAlignmentCenter;
//    [label sizeToFit];
//    [vc.view addSubview:label];
//    [self.childVcs addObject:vc];
//}
//// 3.创建选项卡配置样式
//LZBSegmentConfig  *pageStyleModel = [LZBSegmentConfig defaultConfig];
//pageStyleModel.isScrollEnable = YES;  //是否可以滚动
//pageStyleModel.isNeedScale = YES;    //是否需要放大
//pageStyleModel.isShowIndicatorLine = YES;  //是否需要下划线
//// pageStyleModel.isNeedMask = YES;   //是否需要遮罩
//// 4.创建pageView，增加到父类View，可以使用
//LZBPageView *pageView = [[LZBPageView alloc]initWithFrame:pageFrame segmentConfig:pageStyleModel items:titles childVCs:self.childVcs parentVc:self];
//self.pageView = pageView;
//[self.view addSubview:pageView];
#import <UIKit/UIKit.h>
#import "LZBSegmentBar.h"

@interface LZBSegmentBarViewController : UIViewController


/**
 自定义segmentBar的父类。如果没有设置就增加到LZBSementBarViewController，用于设置到导航条上的bar
 */
@property (nonatomic, strong) LZBSegmentBar *segmentBar;


/**
 初始化控制器

 @param config 配置模型
 @param items 标题数组
 @param childVCs 子控制数组
 @return 控制器
 */
- (instancetype)initWithSegmentConfig:(LZBSegmentConfig *)config items:(NSArray<NSString *> *)items childVCs:(NSArray<UIViewController *> *)childVCs;


/**
 更新frame
 
 @param udpateFrame 设置更新frame
 */
- (void)updateFrameWithLayoutSubViews:(CGRect)udpateFrame;
@end
