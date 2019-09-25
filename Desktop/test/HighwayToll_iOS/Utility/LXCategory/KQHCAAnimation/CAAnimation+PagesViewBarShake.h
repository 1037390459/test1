//
//  CAAnimation+PagesViewBarShake.h
//  CorePagesView
//
//  Created by muxi on 15/3/20.
//  Copyright (c) 2015年 muxi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAAnimation (PagesViewBarShake)


/**
 *  抖动
 */
+(CAKeyframeAnimation *)shake;



/**
 *  生成一个翻转动画
 */
+(CABasicAnimation *)rotationAnim;



/**
 *  旋转动画
 */
+(CABasicAnimation *)rotaAnim;

/**
 *  旋转动画
 */
+(CAKeyframeAnimation *)shakeToShow;

/**
 *  缩放
 */
+ (CABasicAnimation *)scale;

/**
 缩放并保持

 @return nil
 */
+ (CABasicAnimation *)bigScale;
/**
   缩小至0.1

 @return CABasicAnimation
 */
+ (CABasicAnimation *)transform_scale;
/**
 duang

 @return <#return value description#>
 */
+ (CAKeyframeAnimation *)scaleToView;
@end
