//
//  SLLoginViewController.m
//  智能锁
//
//  Created by million on 2019/4/7.
//  Copyright © 2019 million. All rights reserved.
//

#import "SLLoginViewController.h"

@interface SLLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTf;
@property (weak, nonatomic) IBOutlet UITextField *pwdTf;
@property (weak, nonatomic) IBOutlet UIButton *rememberBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation SLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
    _nextBtn.layer.cornerRadius = 4;
    _nextBtn.layer.masksToBounds = true;
    _registerBtn.layer.cornerRadius = 4;
    _registerBtn.layer.borderColor = [UIColor colorWithHexString:@"#02A2F4"].CGColor;
    _registerBtn.layer.borderWidth = 1;
    _nextBtn.layer.masksToBounds = true;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = true;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = false;
}

- (IBAction)next:(id)sender {
   [UIApplication sharedApplication].keyWindow.rootViewController = [UIStoryboard storyboardWithName:@"Main" bundle:    nil].instantiateInitialViewController;
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
