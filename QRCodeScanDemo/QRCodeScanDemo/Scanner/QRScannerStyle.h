//
//  QRScannerStyle.h
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/11.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

/**
 * 扫码的基本UI样式
 */
@interface QRScannerStyle : NSObject

/**
 * 是否需要显示扫码的矩形线框
 */
@property (nonatomic, assign) BOOL isNeedShowRectangle;

/**
 * 扫码矩形框在垂直方向的偏移量
 */
@property (nonatomic, assign) CGFloat verticalOffset;

/**
 * 扫码矩形框与左右两边的距离
 */
@property (nonatomic, assign) CGFloat marginOffset;

/**
 * 扫码矩形框的边框颜色
 */
@property (nonatomic, strong) UIColor *rectangleBorderColor;

/**
 * 扫码矩形框四个角的颜色
 */
@property (nonatomic, strong) UIColor *angleColor;

/**
 * 非识别区域的遮盖层颜色
 */
@property (nonatomic, strong) UIColor *noneRecognizeColor;

/**
 * 扫码矩形框四个角的线条宽度
 */
@property (nonatomic, assign) CGFloat angleLineWidth;

/**
 * 扫码矩形框四个角的宽高
 */
@property (nonatomic, assign) CGFloat angleLineLength;

/**
 * 扫码框的四个角是在扫描框内部还是外部，默认为贴着四个角在框线外部
 */
@property (nonatomic, assign) BOOL isAngleDisplayInner;

/**
 * 扫描线的图片
 */
@property (nonatomic, strong) UIImage *scanLineImage;

/**
 * 单例，得到默认的样式
 */
+ (QRScannerStyle *)defaultStyle;

@end
