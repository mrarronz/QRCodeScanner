//
//  QRScannerHelper.h
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/12.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "QRScannerStyle.h"

@interface QRScannerHelper : NSObject

/**
 * 手机震动
 */
+ (void)systemVibrate;

/**
 * 播放系统音
 */
+ (void)systemSound;

/**
 * 根据相机权限来进行下一步操作
 */
+ (void)beginScanningWithCompletion:(void (^)())completion;

/**
 * 根据相册权限来进行下一步操作
 */
+ (void)accessPhotosWithCompletion:(void (^)(BOOL isPhotoAccessable))completion;

/**
 * 相机是否已授权访问
 */
+ (BOOL)isCameraAuthorized;

/**
 * 相册是否已授权访问
 */
+ (BOOL)isPhotoAuthorized;

/**
 * 获取扫码的识别区域
 */
+ (CGRect)rectOfInterestInView:(UIView *)videoView scannerStyle:(QRScannerStyle *)style;

/**
 * 获取扫码识别区域，按照屏幕横竖屏计算位置，当手机或iPad横屏扫码框居中显示时可使用
 */
+ (CGRect)getInterestRectInView:(UIView *)videoView style:(QRScannerStyle *)style;


@end
