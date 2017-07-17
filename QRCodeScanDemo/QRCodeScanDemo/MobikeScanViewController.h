//
//  MobikeScanViewController.h
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/14.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import "QRScannerViewController.h"
#import "CustomButton.h"

@interface MobikeScanViewController : QRScannerViewController

/// 摩拜单车图标
@property (nonatomic, strong) UIImageView *bikeImageView;

/// 提示文字
@property (nonatomic, strong) UILabel *tipLabel;

/// 输入编号button
@property (nonatomic, strong) CustomButton *inputCodeButton;

/// 闪光灯button
@property (nonatomic, strong) CustomButton *flashLightButton;

@end
