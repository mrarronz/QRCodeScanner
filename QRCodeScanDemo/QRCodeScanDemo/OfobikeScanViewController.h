//
//  OfobikeScanViewController.h
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/14.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import "QRScannerViewController.h"

@interface OfobikeScanViewController : QRScannerViewController

/// 小黄车logo
@property (nonatomic, strong) UIImageView *bikeLogoView;

/// 关闭button
@property (nonatomic, strong) UIButton *closeButton;

/// 输入编号button
@property (nonatomic, strong) UIButton *inputCodeButton;

/// 闪光灯button
@property (nonatomic, strong) UIButton *flashLightButton;

/// 提示文字
@property (nonatomic, strong) UILabel *tipLabel;

/// 输入编号label
@property (nonatomic, strong) UILabel *inputCodeLabel;

/// 闪光灯label
@property (nonatomic, strong) UILabel *flashLightLabel;

@end
