//
//  LXRoadAdministrationDetailControllerViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/5.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXRoadAdministrationDetailControllerViewController.h"
#import "LXCustomNavigationView.h"
#import <WebKit/WebKit.h>
@interface LXRoadAdministrationDetailControllerViewController ()

@property (nonatomic,strong) LXCustomNavigationView *bgView; /**<  */
@end

@implementation LXRoadAdministrationDetailControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat hei = kNavHeight;
    WKWebView *web = [[WKWebView alloc] initWithFrame:CGRectMake(0, kNavHeight, kWidth, kHeight - hei)];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://weibo.com/tv/v/Fy6PIdbLn" ]]];
    [self.view addSubview:web];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    LXWeakSelf(self);
    [self.navigationController.navigationBar addSubview:self.bgView];
    [self.bgView didSelectClick:^{
        
        [weakself.bgView removeFromSuperview];
        [weakself.navigationController popViewControllerAnimated:YES];
    }];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.bgView removeFromSuperview];
}
- (LXCustomNavigationView *)bgView{
    if (!_bgView) {
        _bgView = [[LXCustomNavigationView alloc] initWithFrame:CGRectMake(0, -20, kWidth, kNavHeight)];
    }
    return _bgView;
}
@end
