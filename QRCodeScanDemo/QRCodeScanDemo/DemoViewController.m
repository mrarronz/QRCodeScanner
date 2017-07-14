//
//  DemoViewController.m
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/12.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import "DemoViewController.h"
#import "QRScannerView.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupComponent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 处理扫描结果
- (void)handleScanResult {
    if (!self.scanResult) {
        [self showAlert:@"无法识别二维码，请换个码重新扫描"];
        return;
    }
    [self showAlert:self.scanResult];
}

- (void)showAlert:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self startScanning];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)setupComponent {
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.photoButton];
    [self.view addSubview:self.flashLightButton];
    
    CGFloat originY = CGRectGetMaxY([self scanRect]) + 50;
    
    self.tipLabel.frame = CGRectMake(0, 60, CGRectGetWidth(self.view.bounds), 20);
    self.photoButton.frame = CGRectMake(CGRectGetWidth(self.view.bounds)/2 - 30 - 64, originY, 64, 64);
    self.flashLightButton.frame = CGRectMake(CGRectGetWidth(self.view.bounds)/2 + 30, originY, 64, 64);
}

/**
 * 选择图片
 */
- (void)selectPhotoButtonClicked:(id)sender {
    [self openPhotoLibrary];
}

/**
 * 切换闪光灯
 */
- (void)toggleFlashLight:(id)sender {
    [self switchFlashLight];
}

#pragma mark - Init property

- (UIButton *)photoButton {
    if (!_photoButton) {
        _photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_photoButton setBackgroundImage:[UIImage imageNamed:@"icon_select_photo"] forState:UIControlStateNormal];
        [_photoButton addTarget:self action:@selector(selectPhotoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _photoButton;
}

- (UIButton *)flashLightButton {
    if (!_flashLightButton) {
        _flashLightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_flashLightButton setBackgroundImage:[UIImage imageNamed:@"icon_open_light"] forState:UIControlStateNormal];
        [_flashLightButton addTarget:self action:@selector(toggleFlashLight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashLightButton;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:17];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.text = @"将方框对准二维码即可自动扫描";
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [_tipLabel sizeToFit];
    }
    return _tipLabel;
}

@end
