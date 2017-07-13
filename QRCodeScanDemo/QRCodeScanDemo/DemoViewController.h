//
//  DemoViewController.h
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/12.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRScannerViewController.h"

@interface DemoViewController : QRScannerViewController

/**
 * 转换前后摄像头的button
 */
@property (nonatomic, strong) UIButton *cameraButton;
/**
 * 选取图片button
 */
@property (nonatomic, strong) UIButton *photoButton;
/**
 * 打开闪光灯button
 */
@property (nonatomic, strong) UIButton *flashLightButton;

/**
 * 提示文字label, 如“将方框对准二维码即可自动扫描”
 */
@property (nonatomic, strong) UILabel *tipLabel;

@end
