//
//  UIImage+QRScanner.h
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/14.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIImage (QRScanner)

/**
 * 根据字符串生成二维码图片
 */
+ (UIImage *)QRImageWithInputText:(NSString *)inputText;

/**
 * 根据指定的长宽大小和字符串生成二维码图片
 */
+ (UIImage *)QRImageWithText:(NSString *)text size:(CGFloat)size;

/**
 * 根据指定的图片大小，字符串，前景色和背景色生成带有颜色的二维码图片
 */
+ (UIImage *)QRImageWithText:(NSString *)text
                        size:(CGSize)size
                  frontColor:(UIColor *)frontColor
             backgroundColor:(UIColor *)bkgColor;

/**
 * 处理二维码图片颜色
 */
- (UIImage *)imageWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

@end
