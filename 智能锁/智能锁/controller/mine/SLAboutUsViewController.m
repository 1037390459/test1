//
//  SLAboutUsViewController.m
//  智能锁
//
//  Created by million on 2019/4/3.
//  Copyright © 2019 million. All rights reserved.
//

#import "SLAboutUsViewController.h"

@interface SLAboutUsViewController ()

@end

@implementation SLAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    bgImageView.image = [UIImage imageNamed:@"bg.png"];
    [self.view insertSubview:bgImageView atIndex:0];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
