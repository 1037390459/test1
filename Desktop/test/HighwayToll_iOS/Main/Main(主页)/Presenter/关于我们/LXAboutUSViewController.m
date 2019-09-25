//
//  LXAboutUSViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/5.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXAboutUSViewController.h"

@interface LXAboutUSViewController ()
@property (nonatomic,strong) UIImageView *bgImage;      /**< 背景图片 */
@end

@implementation LXAboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

/**
    配置UI
 */
- (void)configUI{
    self.title = @"关于我们";
    self.bgImage = [LXView createImageViewFrame:CGRectZero
                                      imageName:@"aboutUS"
                                    isUIEnabled:YES];
    [self.view addSubview:self.bgImage];
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
@end
