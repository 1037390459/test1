//
//  CAAnimation+PagesViewBarShake.m
//  CorePagesView
//
//  Created by muxi on 15/3/20.
//  Copyright (c) 2015年 muxi. All rights reserved.
//

#import "CAAnimation+PagesViewBarShake.h"

@implementation CAAnimation (PagesViewBarShake)



/**
 *  抖动
 */
+(CAKeyframeAnimation *)shake{
    CAKeyframeAnimation *kfa=[CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    
    //值
    kfa.values=@[@(10),@(-8),@(6),@(-4),@(2),@(-1),@(0)];
    
    //设置时间
    kfa.duration=0.6f;
    
    //是否重复
    kfa.repeatCount=0;
    
    //是否反转
    kfa.autoreverses=NO;
    
    //完成移除
    kfa.removedOnCompletion=YES;
    
    return kfa;
}

#define kDegreeToRadian(x) (M_PI/180.0 * (x))

/**
 *  生成一个翻转动画
 */
+(CABasicAnimation *)rotationAnim{
    
    CABasicAnimation *anim=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //起点
    anim.fromValue = @(0);
    
    //终点
    anim.toValue=@(kDegreeToRadian(-360));
    
    //动画时长
    anim.duration=1.f;
    
    //是否反转
    anim.autoreverses=NO;
    
    //是否重复
    anim.repeatCount=.0f;
    
    //动画完成移除
    anim.removedOnCompletion=YES;
    
    return anim;
}



/**
 *  旋转动画
 */
+(CABasicAnimation *)rotaAnim{
    
    
    CABasicAnimation *anim=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    
    //设置起点
    anim.fromValue=0;
    
    //设置终点
    anim.toValue=@(kDegreeToRadian(360.0f));
    
    //设置动画执行一次的时长
    anim.duration=.8f;
    
    //设置速度函数
    anim.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    //完成动画不删除：
    anim.removedOnCompletion=NO;
    
    //向前填充
    anim.fillMode=kCAFillModeForwards;
    
    //设置重复次数
    anim.repeatCount=MAXFLOAT;
    
    anim.removedOnCompletion =YES;
    return anim;
}


/**
 *  抖动
 */
+(CAKeyframeAnimation *)shakeAnim{
    
    CAKeyframeAnimation *kfa=[CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    
    //值
    kfa.values=@[@0.1f,@(0),@(-0.1f),@(0),@0.1f,@(0),@(-0.1f)];
    
    //设置时间
    kfa.duration=0.15f;
    
    //是否重复
    kfa.repeatCount=6.0f;
    
    //是否反转
    kfa.autoreverses=YES;
    
    //完成移除
    kfa.removedOnCompletion=YES;
    
    return kfa;
}


+ (CABasicAnimation *)scale{
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    
    return pulse;
}
+ (CABasicAnimation *)transform_scale{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:0.1];
    animation.duration=0.3;
    animation.autoreverses=NO;
    animation.repeatCount=0;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}
+ (CAKeyframeAnimation *)scaleToView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    return animation;
}
+ (CABasicAnimation *)bigScale{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;           //保证动画效果延续
    animation.fromValue = [NSNumber numberWithFloat:1.0];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.15];     //结束伸缩倍数
    return animation;
}
@end
