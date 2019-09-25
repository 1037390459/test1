//
//  UIImage+WaterMark.h
//  Image+watermark
//
//  Created by zyq on 13-5-8.
//  Copyright (c) 2013年 zyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WaterMark)
// 文字水印  可用
- (UIImage *) imageWithStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font;

- (UIImage *) imageWithStringWaterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font;
- (UIImage *)imageWithLogoText:(UIImage *)img text:(NSString *)text1;

// 图片水印   可用
- (UIImage *) imageWithWaterMask:(UIImage*)mask inRect:(CGRect)rect;
- (UIImage *)imageWithLogoImage:(UIImage *)img logo:(UIImage *)logo;//图片水印

//透明水印
- (UIImage *)imageWithTransImage:(UIImage *)useImage addtransparentImage:(UIImage *)transparentimg;

+(CGRect)getFrameSizeForImage:(UIImage *)image inImageView:(UIImageView *)imageView;

/**
 *  压缩上传图片到指定字节
 *
 *  @param image     压缩的图片
 *  @param maxLength 压缩后最大字节大小
 *
 *  @return 压缩后图片的二进制
 */
+ (NSData *)compressImage:(UIImage *)image toMaxLength:(NSInteger) maxLength maxWidth:(NSInteger)maxWidth;

/**
 *  获得指定size的图片
 *
 *  @param image   原始图片
 *  @param newSize 指定的size
 *
 *  @return 调整后的图片
 */
+ (UIImage *)resizeImage:(UIImage *) image withNewSize:(CGSize) newSize;

/**
 *  通过指定图片最长边，获得等比例的图片size
 *
 *  @param image       原始图片
 *  @param imageLength 图片允许的最长宽度（高度）
 *
 *  @return 获得等比例的size
 */
+ (CGSize)scaleImage:(UIImage *) image withLength:(CGFloat) imageLength;

///对指定图片进行拉伸
+ (UIImage*)resizableImage:(NSString *)name;
@end
