//
//  OfobikeScanViewController.m
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/14.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import "OfobikeScanViewController.h"

@interface OfobikeScanViewController ()

@end

@implementation OfobikeScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupComponents {
    [self.view addSubview:self.bikeLogoView];
    [self.view addSubview:self.closeButton];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.inputCodeButton];
    [self.view addSubview:self.inputCodeLabel];
    
    [self.view addSubview:self.flashLightButton];
    [self.view addSubview:self.flashLightLabel];
    
    self.bikeLogoView.frame = CGRectMake(20, 40, CGRectGetWidth(self.bikeLogoView.bounds), CGRectGetHeight(self.bikeLogoView.bounds));
    self.closeButton.center = CGPointMake(CGRectGetWidth(self.view.bounds) - 40, self.bikeLogoView.center.y);
    self.tipLabel.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetMinY([self scanRect]) - 30);
    self.inputCodeButton.center = CGPointMake(CGRectGetMidX(self.view.bounds) - 80, CGRectGetHeight(self.view.bounds) - 80);
    self.flashLightButton.center = CGPointMake(CGRectGetMidX(self.view.bounds) + 80, CGRectGetHeight(self.view.bounds) - 80);
    self.inputCodeLabel.center = CGPointMake(self.inputCodeButton.center.x, CGRectGetMaxY(self.inputCodeButton.frame) + 20);
    self.flashLightLabel.center = CGPointMake(self.flashLightButton.center.x, CGRectGetMaxY(self.flashLightButton.frame) + 20);
}

- (QRScannerStyle *)customStyle {
    QRScannerStyle *style = [[QRScannerStyle alloc] init];
    style.rectangleBorderColor = [UIColor yellowColor];
    style.angleColor = [UIColor yellowColor];
    style.isAngleDisplayInner = YES;
    style.isNeedShowRectangle = YES;
    style.verticalOffset = 20;
    style.marginOffset = 50;
    style.angleLineWidth = 8;
    style.angleLineLength = 40;
    style.scanLineImage = [UIImage imageNamed:@"icon_ofo_scanline"];
    return style;
}

- (UIImageView *)bikeLogoView {
    if (!_bikeLogoView) {
        _bikeLogoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_ofo_bike"]];
        [_bikeLogoView sizeToFit];
    }
    return _bikeLogoView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"icon_ofo_close"] forState:UIControlStateNormal];
        _closeButton.frame = CGRectMake(0, 0, 44, 44);
        [_closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:16];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"对准车牌上的二维码，即可自动扫描";
        [_tipLabel sizeToFit];
    }
    return _tipLabel;
}

- (UIButton *)inputCodeButton {
    if (!_inputCodeButton) {
        _inputCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_inputCodeButton setImage:[UIImage imageNamed:@"icon_ofo_input"] forState:UIControlStateNormal];
        _inputCodeButton.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
        _inputCodeButton.frame = CGRectMake(0, 0,  50, 50);
        _inputCodeButton.layer.cornerRadius = CGRectGetWidth(_inputCodeButton.bounds)/2;
        _inputCodeButton.layer.masksToBounds = YES;
    }
    return _inputCodeButton;
}

- (UIButton *)flashLightButton {
    if (!_flashLightButton) {
        _flashLightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_flashLightButton setImage:[UIImage imageNamed:@"icon_ofo_torch"] forState:UIControlStateNormal];
        _flashLightButton.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
        _flashLightButton.frame = CGRectMake(0, 0,  50, 50);
        _flashLightButton.layer.cornerRadius = CGRectGetWidth(_flashLightButton.bounds)/2;
        _flashLightButton.layer.masksToBounds = YES;
        [_flashLightButton addTarget:self action:@selector(flashLightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashLightButton;
}

- (UILabel *)inputCodeLabel {
    if (!_inputCodeLabel) {
        _inputCodeLabel = [[UILabel alloc] init];
        _inputCodeLabel.font = [UIFont systemFontOfSize:14];
        _inputCodeLabel.textColor = [UIColor whiteColor];
        _inputCodeLabel.textAlignment = NSTextAlignmentCenter;
        _inputCodeLabel.text = @"手动输入车牌";
        [_inputCodeLabel sizeToFit];
    }
    return _inputCodeLabel;
}

- (UILabel *)flashLightLabel {
    if (!_flashLightLabel) {
        _flashLightLabel = [[UILabel alloc] init];
        _flashLightLabel.font = [UIFont systemFontOfSize:14];
        _flashLightLabel.textColor = [UIColor whiteColor];
        _flashLightLabel.textAlignment = NSTextAlignmentCenter;
        _flashLightLabel.text = @"打开手电筒";
        [_flashLightLabel sizeToFit];
    }
    return _flashLightLabel;
}

- (void)closeButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)flashLightButtonClicked:(id)sender {
    [self switchFlashLight];
}

@end
