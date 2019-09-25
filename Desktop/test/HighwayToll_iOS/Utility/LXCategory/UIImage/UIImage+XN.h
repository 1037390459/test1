//
//  UIImage+XN.h
//  51XiaoNiu
//
//  Created by 乔同新 on 16/4/6.
//  Copyright © 2016年 乔同新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XN)
//保持原来的长宽比，生成一个缩略图
+ (nullable UIImage *)thumbnailWithImageWithoutScale:(nullable UIImage *)image size:(CGSize)asize;
//content
+ (nullable UIImage *)contentFileWithName:(nullable NSString *)fileName Type:(nullable NSString *)type;
//返回一张自由拉伸的图片
+(nullable UIImage *)resizedImageWithName:(nullable NSString *)name;
//返回一张自由调整大小的图片
+(nullable UIImage *)newImageWithNamed:(nullable NSString *)name size:(CGSize)size;
///改变一张图片的大小
+ (nullable UIImage *)changeImageSize:(nullable UIImage *)icon AndSize:(CGSize)size;
+ (nullable UIImage *)imageWithOriginal:(nullable NSString *)imageName;
+ (nullable UIImage *)resizedImage:(nullable NSString *)name;
//根据颜色值生成纯色图片
+ (nullable UIImage *)createImageWithColor:(nullable UIColor *)color frame:(CGRect)frame;
//原图输出
+ (nullable UIImage *)imageWithName:(nullable NSString *)name size:(CGSize)size;
///压缩
+ (nullable UIImage*)imageWithImageSimple:( nullable UIImage*)image scaledToSize:(CGSize)newSize;
+ (nullable UIImage *)createThumbImage:(nullable UIImage *)image size:(CGSize )thumbSize;
/**
 *  高斯模糊
 *
 *  @param view   view
 *  @param radius radius
 *  @param size   size
 *
 *  @return image
 */
+ (nullable UIImage*)imageWithView:(nullable UIView*)view radius:(CGFloat)radius size:(CGSize)size;

+ (nullable UIImage *)imageWithColor:(nullable UIColor *)color;

+ (nullable UIImage *)qrCodeImageWithContent:( nullable NSString *)content
                      codeImageSize:(CGFloat)size
                               logo:(nullable UIImage *)logo
                          logoFrame:(CGRect)logoFrame
                                red:(CGFloat)red
                              green:(CGFloat)green
                               blue:(CGFloat)blue;

+ (nullable UIImage *)getTheLaunchImage;
+ (nullable UIImage*)imageWithUIView:(nullable UIView*)view;
- (nullable UIImage *)imageWithTitle:(nullable NSString *)title fontSize:(CGFloat)fontSize;
+ (CGSize)getImageSizeWithURL:(nullable id)URL;

/**
 将图片进行圆形切割处理，默认无边框(PS:此操作是线程安全的)。
 @param scaleSize 图片将会缩放成的目标大小
 @return 返回处理之后的图片
 */
- (nullable UIImage *)dd_imageByRoundScaleSize:(CGSize)scaleSize;

/**
 将图片进行圆角处理，并加上边框(PS:此操作是线程安全的)。
 @param radius 圆角大小
 @param scaleSize 图片将会缩放成的目标大小
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @param corners 图片圆角样式（UIRectCorner）
 @return 返回处理之后的图片
 */
- (nullable UIImage *)dd_imageByCornerRadius:(CGFloat)radius
                                   scaleSize:(CGSize)scaleSize
                                 borderWidth:(CGFloat)borderWidth
                                 borderColor:(nullable UIColor *)borderColor
                                     corners:(UIRectCorner)corners;

/**
 图片加上圆形边框，图片必须得是正方形的，否则直接返回未加边框的原图片(PS:此操作是线程安全的)
 @param color 边框颜色
 @param width 边框宽度
 @return 返回处理之后的图片
 */
- (nullable UIImage *)dd_imageByRoundBorderedColor:(nullable UIColor *)color
                                       borderWidth:(CGFloat)width;

/**
 创建一张纯色的圆形图片
 @param color 图片填充的颜色
 @param size 图片的大小
 @return 返回纯色的圆形图片
 */
+ (nullable UIImage *)dd_roundImageWithColor:(nullable UIColor *)color
                                        size:(CGSize)size;

/**
 图片加上边框 (PS:此操作是线程安全的)
 @param radius 圆角大小
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 @param corners 图片圆角样式（UIRectCorner）
 @return 返回处理之后的图片
 */
- (nullable UIImage *)dd_imageByCornerRadius:(CGFloat)radius
                               borderedColor:(nullable UIColor *)borderColor
                                 borderWidth:(CGFloat)borderWidth
                                     corners:(UIRectCorner)corners;

/**
 将图片指定圆角样式处理，并加上边框(PS:此操作是线程安全的)。
 @param radius 圆角大小
 @param corners 图片圆角样式（UIRectCorner）
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @return 返回处理之后的图片
 */
- (nullable UIImage *)dd_imageByCornerRadius:(CGFloat)radius
                                     corners:(UIRectCorner)corners
                                 borderWidth:(CGFloat)borderWidth
                                 borderColor:(nullable UIColor *)borderColor;

/** 设置圆形图片(放到分类中使用) */
- (nullable UIImage *)cutCircleImage;
@end
