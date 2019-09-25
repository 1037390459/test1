//
//  LXPassWordView.h
//  PeacockShop
//
//  Created by Cheng on 17/11/9.
//  Copyright © 2017年 LX. All rights reserved.
//

#import <UIKit/UIKit.h>
//TPPasswordTextView *view1 = [[TPPasswordTextView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
//view1.elementCount = 5;
//view1.center = CGPointMake(center.x, 50);
//[self.view addSubview:view1];
//view1.passwordDidChangeBlock = ^(NSString *password) {
//    NSLog(@"%@",password);
//};
@interface LXPassWordView : UIView

/**
 the password is user inputed
 */
@property (nonatomic, copy) void(^passwordDidChangeBlock)(NSString *password);

/**
 set element count, default is 4, remove all elements and creat new elemets when it was set
 */
@property (nonatomic, assign) NSInteger elementCount;

/**
 set element color, default is balck color
 */
@property (nonatomic, strong) UIColor *elementBorderColor;

/**
 set element margein, default is 4 point
 */
@property (nonatomic, assign) CGFloat elementMargin;

/**
 auto hide the keyboard when input password was completed, default is YES
 */
@property (nonatomic, assign) BOOL autoHideKeyboard;

/**
 set element border width, default's 1 point
 */
@property (nonatomic, assign) CGFloat elementBorderWidth;

/**
 clear all password
 */
- (void)clearPassword;


- (void)showKeyboard;

- (void)hideKeyboard;
@end
