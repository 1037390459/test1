//
//  UIImageView+Gif.m
//  Buggy
//
//  Created by 孟德林 on 2017/5/25.
//  Copyright © 2017年 ningwu. All rights reserved.
//

#import "UIImageView+Gif.h"
#import <ImageIO/ImageIO.h>

@implementation UIImageView (Gif)
-(void)getGifImageWithUrk:(NSURL *)url
               returnData:(void(^)(NSArray<UIImage *> * imageArray,
                                   NSArray<NSNumber *>*timeArray,
                                   CGFloat totalTime,
                                   NSArray<NSNumber *>* widths,
                                   NSArray<NSNumber *>* heights))dataBlock{
    // 通过文件的url获取gif文件的图片数据引用
    CGImageSourceRef source = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    size_t count = CGImageSourceGetCount(source);
    float allTime = 0;
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray *timeArray  = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray *widthArray = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray *heightArray = [NSMutableArray arrayWithCapacity:count];
    for (size_t i =0; i < count; i ++) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i,NULL);
        [imageArray addObject:(__bridge UIImage *)(image)];
        CGImageRelease(image);
        //获取图片信息
        NSDictionary * info = (__bridge NSDictionary*)CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
        CGFloat width = [[info objectForKey:(__bridge NSString *)kCGImagePropertyPixelWidth] floatValue];
        CGFloat height = [[info objectForKey:(__bridge NSString *)kCGImagePropertyPixelHeight] floatValue];
        [widthArray addObject:[NSNumber numberWithFloat:width]];
        [heightArray addObject:[NSNumber numberWithFloat:height]];
        NSDictionary * timeDic = [info objectForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
        CGFloat time = [[timeDic objectForKey:(__bridge NSString *)kCGImagePropertyGIFDelayTime]floatValue];
        allTime+=time;
        [timeArray addObject:[NSNumber numberWithFloat:time]];
    }
    dataBlock(imageArray,timeArray,allTime,widthArray,heightArray);
}

- (void)gif_setImage:(NSURL *)imageUrl {
    
    __weak typeof(self) wself = self;
    [self getGifImageWithUrk:imageUrl returnData:^(NSArray<UIImage *> *imageArray, NSArray<NSNumber *> *timeArray, CGFloat totalTime, NSArray<NSNumber *> *widths, NSArray<NSNumber *> *heights) {
        
        //添加帧动画
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
        NSMutableArray * times = [[NSMutableArray alloc]init];
        float currentTime = 0;
        //设置每一帧的时间占比
        for (int i=0; i<imageArray.count; i++) {
            [times addObject:[NSNumber numberWithFloat:currentTime/totalTime]];
            currentTime+=[timeArray[i] floatValue];
        }
        [animation setKeyTimes:times];
        [animation setValues:imageArray];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        //设置循环
        animation.repeatCount= MAXFLOAT;
        //设置播放总时长
        animation.duration = totalTime;
        //Layer层添加
        [[(UIImageView *)wself layer]addAnimation:animation forKey:@"gifAnimation"];
    }];
}


/**
 *  @brief  倒影
 */
- (void)reflect {
    CGRect frame = self.frame;
    frame.origin.y += (frame.size.height + 1);
    
    UIImageView *reflectionImageView = [[UIImageView alloc] initWithFrame:frame];
    self.clipsToBounds = TRUE;
    reflectionImageView.contentMode = self.contentMode;
    [reflectionImageView setImage:self.image];
    reflectionImageView.transform = CGAffineTransformMakeScale(1.0, -1.0);
    
    CALayer *reflectionLayer = [reflectionImageView layer];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.bounds = reflectionLayer.bounds;
    gradientLayer.position = CGPointMake(reflectionLayer.bounds.size.width / 2, reflectionLayer.bounds.size.height * 0.5);
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)[[UIColor clearColor] CGColor],
                            (id)[[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3] CGColor], nil];
    
    gradientLayer.startPoint = CGPointMake(0.5,0.5);
    gradientLayer.endPoint = CGPointMake(0.5,1.0);
    reflectionLayer.mask = gradientLayer;
    
    [self.superview addSubview:reflectionImageView];
    
}
@end
