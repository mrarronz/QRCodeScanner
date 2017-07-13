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
 * 处理扫描结果
 */
- (void)handleScanResult;

@end
