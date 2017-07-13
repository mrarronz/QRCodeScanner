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
    
//    QRScannerView *scanView = [[QRScannerView alloc] initWithFrame:self.view.bounds
//                                                             style:[QRScannerStyle defaultStyle]];
//    [self.view addSubview:scanView];
//    
//    [scanView showLoadingView];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [scanView hideLoadingView];
//        [scanView startAnimating];
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
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
