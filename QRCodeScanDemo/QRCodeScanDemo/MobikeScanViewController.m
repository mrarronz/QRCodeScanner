//
//  MobikeScanViewController.m
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/14.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import "MobikeScanViewController.h"

@interface MobikeScanViewController ()

@end

@implementation MobikeScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"扫码开锁";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (QRScannerStyle *)customStyle {
    QRScannerStyle *style = [[QRScannerStyle alloc] init];
    style.isAngleDisplayInner = YES;
    style.isNeedShowRectangle = NO;
    style.verticalOffset = 80;
    style.angleColor = [UIColor colorWithRed:0.7 green:0.3 blue:0.3 alpha:1.0];
    style.angleLineWidth = 2;
    style.angleLineLength = 18;
    style.noneRecognizeColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    style.scanLineImage = [UIImage imageNamed:@"icon_mobike_scanline"];
    return style;
}

- (void)setupComponents {
    [self.view addSubview:self.bikeImageView];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.inputCodeButton];
    [self.view addSubview:self.flashLightButton];
    
    self.bikeImageView.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetMinY([self scanRect])/2);
    self.tipLabel.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetMaxY([self scanRect]) + 30);
    
    
    CGFloat height = CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(self.tipLabel.frame);
    CGFloat centerY = CGRectGetMaxY(self.tipLabel.frame) + height/2 - 30;
    self.inputCodeButton.center = CGPointMake(CGRectGetMidX(self.view.bounds) - 80, centerY);
    self.flashLightButton.center = CGPointMake(CGRectGetMidX(self.view.bounds) + 80, centerY);
    
}

#pragma mark - Init property

- (UIImageView *)bikeImageView {
    if (!_bikeImageView) {
        _bikeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_mobike_logo"]];
        [_bikeImageView sizeToFit];
    }
    return _bikeImageView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"对准车上的二维码";
        [_tipLabel sizeToFit];
    }
    return _tipLabel;
}

- (CustomButton *)inputCodeButton {
    if (!_inputCodeButton) {
        _inputCodeButton = [CustomButton buttonWithTitle:@"输入编号开锁" image:[UIImage imageNamed:@"icon_mobike_input"]];
        _inputCodeButton.frame = CGRectMake(0, 0, 100, 70);
    }
    return _inputCodeButton;
}

- (CustomButton *)flashLightButton {
    if (!_flashLightButton) {
        _flashLightButton = [CustomButton buttonWithTitle:@"打开手电筒" image:[UIImage imageNamed:@"icon_torch_open"]];
        _flashLightButton.frame = CGRectMake(0, 0, 100, 70);
        [_flashLightButton setImage:[UIImage imageNamed:@"icon_torch_close"] forState:UIControlStateSelected];
        [_flashLightButton addTarget:self action:@selector(flashLightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashLightButton;
}

- (void)flashLightButtonClicked:(CustomButton *)sender {
    [self switchFlashLight];
    sender.selected = !sender.selected;
}

@end
