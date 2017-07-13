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
    
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 处理扫描结果
- (void)handleScanResult {
    if (!self.scanResult) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                       message:@"无法识别二维码，请换个码重新扫描"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self startScanning];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}

#pragma mark - Init property

- (UIButton *)photoButton {
    if (!_photoButton) {
        _photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _photoButton.frame = CGRectMake(0, 0, 64, 64);
        [_photoButton setBackgroundImage:[UIImage imageNamed:@"icon_select_photo"] forState:UIControlStateNormal];
    }
    return _photoButton;
}

- (UIButton *)cameraButton {
    if (!_cameraButton) {
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraButton setBackgroundImage:[UIImage imageNamed:@"icon_switch_camera"] forState:UIControlStateNormal];
    }
    return _cameraButton;
}

- (UIButton *)flashLightButton {
    if (!_flashLightButton) {
        _flashLightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _flashLightButton.frame = CGRectMake(0, 0, 64, 64);
        [_flashLightButton setBackgroundImage:[UIImage imageNamed:@"icon_open_light"] forState:UIControlStateNormal];
    }
    return _flashLightButton;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:17];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.text = @"将方框对准二维码即可自动扫描";
        [_tipLabel sizeToFit];
    }
    return _tipLabel;
}

@end
