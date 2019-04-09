//
//  SLSignUpViewController.m
//  智能锁
//
//  Created by million on 2019/4/7.
//  Copyright © 2019 million. All rights reserved.
//

#import "SLSignUpViewController.h"

@interface SLSignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTf;
@property (weak, nonatomic) IBOutlet UITextField *vcodeTf;
@property (weak, nonatomic) IBOutlet UITextField *pwdTf;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation SLSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
    _registerBtn.layer.cornerRadius = 4;
    _registerBtn.layer.masksToBounds = true;
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
