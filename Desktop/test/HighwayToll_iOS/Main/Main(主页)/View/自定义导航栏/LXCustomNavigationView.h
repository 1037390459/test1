//
//  LXCustomNavigationView.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/5.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LXCustomNavigationViewBlock)(void);
@interface LXCustomNavigationView : UIView
@property (nonatomic,copy) LXCustomNavigationViewBlock block; /**<  */
- (void) didSelectClick:(LXCustomNavigationViewBlock)block;
@end
