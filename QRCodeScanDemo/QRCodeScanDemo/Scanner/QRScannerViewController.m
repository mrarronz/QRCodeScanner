//
//  QRScannerViewController.m
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/11.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import "QRScannerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface QRScannerViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;

@property (nonatomic, copy) NSString *scanResult;
@property (nonatomic, strong) QRScannerView *scannerView;
@property (nonatomic, strong) QRScannerStyle *style;

@end

@implementation QRScannerViewController

- (instancetype)initWithScannerStyle:(QRScannerStyle *)style {
    self = [super init];
    if (self) {
        _style = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_style) {
        _style = [QRScannerStyle defaultStyle];
    }
    [self setupCamera];
    [self.view addSubview:self.scannerView];
    [self.scannerView showLoadingView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startScanning];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self stopScanning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupCamera {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_session canAddInput:input]) {
        [_session addInput:input];
    }
    if ([_session canAddOutput:_output]) {
        [_session addOutput:_output];
    }
    @try {
        _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    }
    @catch (NSException *exception) {
        NSLog(@"exception: %@", exception);
    }
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    
    if (device.isFocusPointOfInterestSupported && [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        [input.device lockForConfiguration:nil];
        [input.device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        [input.device unlockForConfiguration];
    }
    _output.rectOfInterest = [QRScannerHelper rectOfInterestInView:self.view scannerStyle:_style];
}

/**
 * 开始扫描，隐藏准备中的提示，显示扫描线动画
 */
- (void)startScanning {
    if (!_session.isRunning) {
        [_session startRunning];
        
        if (_session.isRunning) {
            [_scannerView hideLoadingView];
        }
    }
    [_scannerView startAnimating];
}

/**
 * 停止扫描，停止扫描线移动的动画
 */
- (void)stopScanning {
    if (_session.isRunning) {
        [_session stopRunning];
    }
    [_scannerView stopAnimating];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    [QRScannerHelper systemSound];
    [QRScannerHelper systemVibrate];
    
    if (metadataObjects && metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        self.scanResult = metadataObject.stringValue;
    }
    [self handleScanResult];
}

#pragma mark - Init property

- (QRScannerView *)scannerView {
    if (!_scannerView) {
        _scannerView = [[QRScannerView alloc] initWithFrame:self.view.bounds style:_style];
    }
    return _scannerView;
}

@end
