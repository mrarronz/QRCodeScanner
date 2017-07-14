//
//  QRScannerViewController.h
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/11.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRScannerView.h"
#import "QRScannerHelper.h"

@interface QRScannerViewController : UIViewController

@property (nonatomic, strong, readonly) QRScannerView *scannerView;

@property (nonatomic, strong, readonly) QRScannerStyle *style;

/**
 * 扫码结果
 */
@property (nonatomic, copy, readonly) NSString *scanResult;

- (instancetype)initWithScannerStyle:(QRScannerStyle *)style;

/**
 * 获取扫描区域的范围
 */
- (CGRect)scanRect;

/**
 * 开始扫描，隐藏准备中的提示，显示扫描线动画
 */
- (void)startScanning;

/**
 * 停止扫描，停止扫描线移动的动画
 */
- (void)stopScanning;

/**
 * 开关闪光灯，闪光灯默认是关闭的
 */
- (void)switchFlashLight;

/**
 * 打开本地相册进行二维码图片的识别
 */
- (void)openPhotoLibrary;

/**
 * 处理扫描结果
 */
- (void)handleScanResult;

@end
