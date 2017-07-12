//
//  QRScannerHelper.h
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/12.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

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
 * 播放自定义的文件声音
 */
+ (void)customSound;

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

@end
