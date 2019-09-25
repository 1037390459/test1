//
//  UIImageView+Barcode.h
//  Daiyanxiu
//
//  Created by MacOS_1 on 16/4/18.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Barcode)
//根据文本以及 图片大小  创建对应二维码图片
- (void)creatBarcodeWithText:(NSString *)text andWithSize:(CGFloat)size;

@end
