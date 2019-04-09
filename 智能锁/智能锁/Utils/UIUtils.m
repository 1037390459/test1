//
//  ETUIUtils.m
//  SmartTrack
//
//  Created by 陈明 on 2017/8/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIUtils.h"

@implementation UIUtils
+ (void)setButton:(UIButton *)btn ImagePosition:(ETButtonImagePostion)pos Padding:(CGFloat)padding{
    [btn sizeToFit];
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    if (pos == ETButtonImagePostionUp) {
        CGFloat totalHeight = (imageSize.height + titleSize.height + padding);
        CGFloat btnHeight = CGRectGetHeight(btn.bounds);
        btn.contentEdgeInsets =  UIEdgeInsetsMake(0.0f,
                                                  0.0f,
                                                  totalHeight-btnHeight,
                                                  0);
        btn.imageEdgeInsets = UIEdgeInsetsMake(-(btnHeight-imageSize.height)/2,
                                               titleSize.width/2,
                                               (btnHeight-imageSize.height)/2,
                                               - titleSize.width/2);
        btn.titleEdgeInsets = UIEdgeInsetsMake(
                                               totalHeight-(btnHeight+titleSize.height)/2,
                                               -imageSize.width/2,
                                               -(totalHeight-(btnHeight+titleSize.height)/2),
                                               imageSize.width/2);
        
    }
    else if (pos == ETButtonImagePostionDown) {
        CGFloat totalHeight = (imageSize.height + titleSize.height + padding);
        CGFloat btnHeight = CGRectGetHeight(btn.bounds);
        btn.contentEdgeInsets =  UIEdgeInsetsMake(0.0f,
                                                  0.0f,
                                                  totalHeight-btnHeight,
                                                  0);
        btn.imageEdgeInsets = UIEdgeInsetsMake(
                                               totalHeight-(btnHeight+imageSize.height)/2,
                                               titleSize.width/2,
                                               -(totalHeight-(btnHeight+imageSize.height)/2),
                                               -titleSize.width/2);
        
        btn.titleEdgeInsets = UIEdgeInsetsMake(-(btnHeight-titleSize.height)/2,
                                               - imageSize.width/2,
                                               (btnHeight-titleSize.height)/2,
                                               imageSize.width/2);
    }
    else if (pos == ETButtonImagePostionLeft) {
        
        btn.contentEdgeInsets =  UIEdgeInsetsMake(0.0f,
                                                  0.0f,
                                                  0.0f,
                                                  padding);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0.0f,
                                               padding,
                                               0.0f,
                                               -padding);
    }
    else if (pos == ETButtonImagePostionRight) {
        CGFloat totalWidth = (imageSize.width + titleSize.width + padding);
        btn.contentEdgeInsets =  UIEdgeInsetsMake(0.0f,
                                                  0.0f,
                                                  0.0f,
                                                  padding);
        
        btn.imageEdgeInsets = UIEdgeInsetsMake(0.0f,
                                               totalWidth - imageSize.width,
                                               0.0f,
                                               -totalWidth + imageSize.width);
        
        btn.titleEdgeInsets = UIEdgeInsetsMake(0.0f,
                                               -imageSize.width,
                                               0.0f,
                                               imageSize.width);
    }
}

+ (void)setButtons:(NSArray<UIButton*> *)btns ImagePosition:(ETButtonImagePostion)pos Padding:(CGFloat)padding{
    for (UIButton *btn in btns) {
        [self setButton:btn ImagePosition:pos Padding:padding];
    }
}

@end
