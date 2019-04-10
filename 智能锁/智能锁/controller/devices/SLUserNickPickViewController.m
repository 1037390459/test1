//
//  SLUserNickPickViewController.m
//  智能锁
//
//  Created by million on 2019/4/11.
//  Copyright © 2019 million. All rights reserved.
//

#import "SLUserNickPickViewController.h"

@interface SLUserNickPickViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *nickButtons;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation SLUserNickPickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (UIButton *nickButton in _nickButtons) {
        nickButton.layer.borderColor = [UIColor whiteColor].CGColor;
        nickButton.layer.borderWidth = 1;
        nickButton.layer.cornerRadius = 10;
        nickButton.layer.masksToBounds = true;
        [nickButton addTarget:self action:@selector(pick:) forControlEvents:UIControlEventTouchUpInside];
    }
    _nextBtn.layer.cornerRadius = 4;
    _nextBtn.layer.masksToBounds = true;
}

- (void)pick:(id)sender {
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
