

#import <UIKit/UIKit.h>
typedef void(^CompletionBlock)( NSError *error);

typedef NS_ENUM(NSUInteger ,GradientType) {
    topToBottom = 0,//从上到小
    leftToRight = 1,//从左到右
    upleftTolowRight = 2,//左上到右下
    uprightTolowLeft = 3,//右上到左下
};

@interface UIColor(Additions)
- (BOOL)isBlackOrWhite;
@end

@interface UIImage (Additions)
/**
 *   纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size andRoundSize:(CGFloat)roundSize;

+ (UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *) buttonImageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius shadowColor:(UIColor *)shadowColor shadowInsets:(UIEdgeInsets)shadowInsets;
+ (UIImage *) circularImageWithColor:(UIColor *)color size:(CGSize)size;
- (UIImage *) imageWithMinimumSize:(CGSize)size;
+ (UIImage *) stepperPlusImageWithColor:(UIColor *)color;
+ (UIImage *) stepperMinusImageWithColor:(UIColor *)color;
+ (UIImage *) backButtonImageWithColor:(UIColor *)color barMetrics:(UIBarMetrics) metrics cornerRadius:(CGFloat)cornerRadius;

- (UIImage *)imageTintedWithColor:(UIColor *)color;
- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction;

//渐变
+(UIImage*)imageWithFrame:(CGSize)size Colors:(NSArray*)colors GradientType:(GradientType)gradientType;

- (id)roundedSize:(CGSize)size radius:(NSInteger)r;
/**
 获取图片上某一点的颜色
 
 @param point  图片内的一个点。范围是 [0, image.width-1],[0, image.height-1]
 超出图片范围则返回nil
 */
- (UIColor *) getPixelColorAtLocation:(CGPoint)point;

- (instancetype)imageWithOverlayColor:(UIColor *)overlayColor;


/**
 *  根据颜色返回一张图片
 *
 *  @param color 颜色
 *  @param rect  大小
 *
 *  @return 背景图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color rect:(CGRect)rect;
/**
 *  保存图片到相册
 */
-(void)imageWriteToSavedPhotosAlbum:(UIImage *)image result:(CompletionBlock) completionBlock;

#pragma mark - Blur Image

/**
 *  Get blured image.
 *
 *  @return Blured image.
 */
- (UIImage *)blurImage;

/**
 *  Get the blured image masked by another image.
 *
 *  @param maskImage Image used for mask.
 *
 *  @return the Blured image.
 */
- (UIImage *)blurImageWithMask:(UIImage *)maskImage;

/**
 *  Get blured image and you can set the blur radius.
 *
 *  @param radius Blur radius.
 *
 *  @return Blured image.
 */
- (UIImage *)blurImageWithRadius:(CGFloat)radius;

/**
 *  Get blured image at specified frame.
 *
 *  @param frame The specified frame that you use to blur.
 *
 *  @return Blured image.
 */
- (UIImage *)blurImageAtFrame:(CGRect)frame;

#pragma mark - Grayscale Image

/**
 *  Get grayScale image.
 *
 *  @return GrayScaled image.
 */
- (UIImage *)grayScale;

#pragma mark - Some Useful Method

/**
 *  Scale image with fixed width.
 *
 *  @param width The fixed width you give.
 *
 *  @return Scaled image.
 */
- (UIImage *)scaleWithFixedWidth:(CGFloat)width;

/**
 *  Scale image with fixed height.
 *
 *  @param height The fixed height you give.
 *
 *  @return Scaled image.
 */
- (UIImage *)scaleWithFixedHeight:(CGFloat)height;

/**
 *  Get the image average color.
 *
 *  @return Average color from the image.
 */
- (UIColor *)averageColor;

/**
 *  Get cropped image at specified frame.
 *
 *  @param frame The specified frame that you use to crop.
 *
 *  @return Cropped image
 */
- (UIImage *)croppedImageAtFrame:(CGRect)frame;



/**
 旋转图片 (中心旋转)
 @param radians   旋转弧度 (逆时针).⟲
 @param fitSize   YES: 旋转后，图片大小会扩大以包含全部内容
 NO: 旋转后，图片大小不变，某些内容会被裁剪
 */
- (UIImage *)lf_imageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize;


/// 向左旋转90° ⤺ (图片宽高会对调)
- (UIImage *)lf_imageByRotateLeft90;

/// 向右旋转90° ⤺ (图片宽高会对调)
- (UIImage *)lf_imageByRotateRight90;

/// 旋转180°
- (UIImage *)lf_imageByRotate180;

/// 上下翻转 ⥯
- (UIImage *)lf_imageByFlipVertical;

/// 左右翻转 ⇋
- (UIImage *)lf_imageByFlipHorizontal;


#pragma mark - 图片效果
///=============================================================================
/// @name 图片效果
///=============================================================================

/// 给图片染色(Tint Color) (就像用有色眼镜看图片)
- (UIImage *)lf_imageByTintColor:(UIColor *)color;

/// 黑白化
- (UIImage *)lf_imageByGrayscale;

/// 灰毛玻璃效果 (适合在里面显示任何内容)
- (UIImage *)lf_imageByBlurSoft;

/// 白色毛玻璃效果 (苹果内置)(适合在里面显示任何内容，除了纯白色文本) 和上拉控制中心、桌面文件夹效果一样
- (UIImage *)lf_imageByBlurLight;

/// 亮白色毛玻璃效果 (苹果内置)(适合在里面显示深色文字)
- (UIImage *)lf_imageByBlurExtraLight;

/// 黑色色毛玻璃效果 (苹果内置)(适合在里面显示浅色文字) 和下拉通知中心的效果一样
- (UIImage *)lf_imageByBlurDark;

/// 模糊一张图片，并添加tintColor
- (UIImage *)lf_imageByBlurWithTint:(UIColor *)tintColor;

/**
 这是苹果官方提供的一个方法，用于调整图片的模糊、饱和度、蒙板等方法。
 
 Applies a blur, tint color, and saturation adjustment to this image,
 optionally within the area specified by @a maskImage.
 
 @param blurRadius     The radius of the blur in points, 0 means no blur effect.
 
 @param tintColor      An optional UIColor object that is uniformly blended with
 the result of the blur and saturation operations. The
 alpha channel of this color determines how strong the
 tint is. nil means no tint.
 
 @param tintBlendMode  The @a tintColor blend mode. Default is kCGBlendModeNormal (0).
 
 @param saturation     A value of 1.0 produces no change in the resulting image.
 Values less than 1.0 will desaturation the resulting image
 while values greater than 1.0 will have the opposite effect.
 0 means gray scale.
 
 @param maskImage      If specified, @a inputImage is only modified in the area(s)
 defined by this mask.  This must be an image mask or it
 must meet the requirements of the mask parameter of
 CGContextClipToMask.
 
 @return               image with effect, or nil if an error occurs (e.g. no
 enough memory).
 */
- (UIImage *)lf_imageByBlurRadius:(CGFloat)blurRadius
                        tintColor:(UIColor *)tintColor
                         tintMode:(CGBlendMode)tintBlendMode
                       saturation:(CGFloat)saturation
                        maskImage:(UIImage *)maskImage;


/**
 * 模糊一张图片 (只模糊，不调整颜色)
 *
 * @param radius           模糊半径(力度) iOS7模糊大约是40
 */
- (UIImage *)lf_blurredImageWithRadius:(CGFloat)radius;

/**
 * 模糊一张图片
 *
 * @param radius           模糊半径(力度) iOS7模糊大约是40
 * @param iterations       模糊迭代次数 (次数越多、计算量越大、模糊越平滑，通常3就足够了)
 * @param tintColor        模糊后着色 (如果该值为nil,则不会进行着色)
 * @param tintColorPercent 着色的百分比 (0.0~1.0)
 * @param blendMode        着色的混合模式
 */
- (UIImage *)lf_blurredImageWithRadius:(CGFloat)radius
                            iterations:(NSUInteger)iterations
                             tintColor:(UIColor *)tintColor
                      tintColorPercent:(CGFloat)tintColorPercent
                             blendMode:(CGBlendMode)blendMode;


/**
 * @brief 裁剪图片
 * @param image 需要裁剪的图片
 * @param size 需要裁剪的长度和宽度（两者都是size）
 * @returns 裁剪后的图片
 */
+ (UIImage *)lf_scaleAndRotateImage:(UIImage *)image size:(NSInteger)size;

+ (CGSize)lf_imageSizeWithData:(NSData *)data;

@end

