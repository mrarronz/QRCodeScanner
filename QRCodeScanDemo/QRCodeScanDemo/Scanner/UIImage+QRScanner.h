//
//  UIImage+QRScanner.h
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/14.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRScanner)

+ (UIImage *)QRImageWithInputText:(NSString *)inputText;

+ (UIImage *)QRImageWithText:(NSString *)text size:(CGSize)size;

+ (UIImage *)QRImageWithText:(NSString *)text
                        size:(CGSize)size
                  frontColor:(UIColor *)frontColor
             backgroundColor:(UIColor *)bkgColor;

- (UIImage *)imageWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

@end
