//
//  ETUIUtils.h
//  SmartTrack
//
//  Created by 陈明 on 2017/8/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIUtils : NSObject

//uibutton image position
typedef NS_ENUM(NSInteger, ETButtonImagePostion) {
    ETButtonImagePostionLeft = 0,
    ETButtonImagePostionRight,
    ETButtonImagePostionUp,
    ETButtonImagePostionDown
};
+ (void)setButton:(UIButton *)btn ImagePosition:(ETButtonImagePostion)pos Padding:(CGFloat)padding;
+ (void)setButtons:(NSArray<UIButton*> *)btns ImagePosition:(ETButtonImagePostion)pos Padding:(CGFloat)padding;

@end
