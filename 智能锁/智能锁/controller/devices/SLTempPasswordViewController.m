//
//  SLTempPasswordTableViewController.m
//  智能锁
//
//  Created by million on 2019/4/11.
//  Copyright © 2019 million. All rights reserved.
//

#import "SLTempPasswordViewController.h"

@interface SLTempPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *pwdTf;

@end

@implementation SLTempPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_pwdTf becomeFirstResponder];
}


@end
