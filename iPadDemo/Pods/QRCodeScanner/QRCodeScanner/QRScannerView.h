//
//  QRScannerView.h
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/11.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRScannerStyle.h"

@interface QRScannerView : UIView

- (instancetype)initWithFrame:(CGRect)frame style:(QRScannerStyle *)style;

/**
 * 显示“准备中”的提示
 */
- (void)showLoadingView;

/**
 * 隐藏提示
 */
- (void)hideLoadingView;

/**
 * 开始显示线条动画
 */
- (void)startAnimating;

/**
 * 停止显示线条动画
 */
- (void)stopAnimating;

@end
