//
//  QRScannerViewController.m
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/11.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import "QRScannerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface QRScannerViewController ()<AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

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

/**
 * 开关闪光灯，闪光灯默认是关闭的
 */
- (void)switchFlashLight {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device.hasTorch) {
        [device lockForConfiguration:nil];
        if (device.torchMode != AVCaptureTorchModeOn) {
            [device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];
        }
        [device unlockForConfiguration];
    }
}

/**
 * 打开本地相册进行二维码图片的识别
 */
- (void)openPhotoLibrary {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    [QRScannerHelper systemSound];
    [QRScannerHelper systemVibrate];
    
    if (metadataObjects && metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        self.scanResult = metadataObject.stringValue;
    }
    [self stopScanning];
    [self handleScanResult];
}

- (void)handleScanResult {
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    // 识别图片二维码
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode
                                              context:nil
                                              options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    CIQRCodeFeature *feature = [features objectAtIndex:0];
    
    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        weakSelf.scanResult = feature.messageString;
        [weakSelf handleScanResult];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Init property

- (QRScannerView *)scannerView {
    if (!_scannerView) {
        _scannerView = [[QRScannerView alloc] initWithFrame:self.view.bounds style:_style];
    }
    return _scannerView;
}

@end
