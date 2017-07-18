//
//  QRScannerHelper.m
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/12.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import "QRScannerHelper.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@implementation QRScannerHelper

/**
 * 手机震动
 */
+ (void)systemVibrate {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

/**
 * 播放系统音
 */
+ (void)systemSound {
    AudioServicesPlaySystemSound(1012);
}

/**
 * 播放自定义的文件声音
 */
+ (void)customSound {
    static SystemSoundID soundId;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"wav"];
    if (path) {
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundId);
        AudioServicesPlaySystemSound(soundId);
    }
}

/**
 * 根据相机权限来进行下一步操作
 */
+ (void)beginScanningWithCompletion:(void (^)())completion {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"相机不可用"
                                                        message:@"当前设备相机不可用，无法进行扫描"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"相机不可用"
                                                        message:@"请在\"设置 - 相机\"中打开相机权限以便当前设备能够正常扫描"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    else if (status == AVAuthorizationStatusAuthorized) {
        completion();
    }
    else if (status == AVAuthorizationStatusNotDetermined) {
        // 主动获取相机权限
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion();
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"相机不可用"
                                                                    message:@"请在\"设置 - 相机\"中打开相机权限以便当前设备能够正常扫描"
                                                                   delegate:self
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:@"确定", nil];
                    [alert show];
                    return;
                });
            }
        }];
    }
}

/**
 * 根据相册权限来进行下一步操作
 */
+ (void)accessPhotosWithCompletion:(void (^)(BOOL isPhotoAccessable))completion {
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (authStatus == PHAuthorizationStatusDenied || authStatus == PHAuthorizationStatusRestricted) {
        completion(NO);
    }
    else if (authStatus == PHAuthorizationStatusAuthorized) {
        completion(YES);
    }
    else if (authStatus == PHAuthorizationStatusNotDetermined) {
        // 主动获取相册权限
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            BOOL isAvailable = NO;
            if (status == PHAuthorizationStatusAuthorized) {
                isAvailable = YES;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(isAvailable);
            });
        }];
    }
}

/**
 * 相机是否已授权访问
 */
+ (BOOL)isCameraAuthorized {
    BOOL isCameraAuthorized = YES;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted) {
        isCameraAuthorized = NO;
    }
    return isCameraAuthorized;
}

/**
 * 相册是否已授权访问
 */
+ (BOOL)isPhotoAuthorized {
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (authStatus == PHAuthorizationStatusDenied || authStatus == PHAuthorizationStatusRestricted) {
        return NO;
    }
    return YES;
}

/**
 * 获取扫码的识别区域
 */
+ (CGRect)rectOfInterestInView:(UIView *)videoView scannerStyle:(QRScannerStyle *)style {
    CGFloat rectangleLength = CGRectGetWidth(videoView.bounds) - style.marginOffset * 2;
    CGFloat minY = CGRectGetHeight(videoView.bounds)/2 - rectangleLength/2 - style.verticalOffset;
    CGFloat minX = style.marginOffset;
    
    // 扫码区域的坐标
    CGRect cropRect = CGRectMake(minX, minY, rectangleLength, rectangleLength);
    
    // 获取识别区域
    CGRect rectOfInterest;
    CGSize size = videoView.bounds.size;
    CGFloat p1 = size.height/size.width;
    CGFloat p2 = 1920./1080.;  //使用了1080p的图像输出
    if (p1 < p2) {
        CGFloat fixHeight = size.width * 1920. / 1080.;
        CGFloat fixPadding = (fixHeight - size.height)/2;
        rectOfInterest = CGRectMake((cropRect.origin.y + fixPadding)/fixHeight,
                                    cropRect.origin.x/size.width,
                                    cropRect.size.height/fixHeight,
                                    cropRect.size.width/size.width);
        
    } else {
        CGFloat fixWidth = size.height * 1080. / 1920.;
        CGFloat fixPadding = (fixWidth - size.width)/2;
        rectOfInterest = CGRectMake(cropRect.origin.y/size.height,
                                    (cropRect.origin.x + fixPadding)/fixWidth,
                                    cropRect.size.height/size.height,
                                    cropRect.size.width/fixWidth);
    }
    return rectOfInterest;
}

/**
 * 获取扫码识别区域，按照屏幕横竖屏计算位置，当手机或iPad横屏扫码框居中显示时可使用
 */
+ (CGRect)getInterestRectInView:(UIView *)videoView style:(QRScannerStyle *)style {
    CGFloat rectangleLength = CGRectGetWidth(videoView.bounds) - style.marginOffset * 2;
    CGFloat minY = CGRectGetHeight(videoView.bounds)/2 - rectangleLength/2 - style.verticalOffset;
    CGFloat minX = style.marginOffset;
    
    // 扫码区域的坐标
    CGRect cropRect = CGRectMake(minX, minY, rectangleLength, rectangleLength);
    CGRect rectOfInterest;
    // 计算横竖屏的情况下对应的识别区域
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        rectOfInterest = CGRectMake(CGRectGetMinY(cropRect)/CGRectGetHeight(videoView.bounds),
                                    CGRectGetMinX(cropRect)/CGRectGetWidth(videoView.bounds),
                                    CGRectGetHeight(cropRect)/CGRectGetHeight(videoView.bounds),
                                    CGRectGetWidth(cropRect)/CGRectGetWidth(videoView.bounds));
        
    } else {
        rectOfInterest = CGRectMake(CGRectGetMinX(cropRect)/CGRectGetWidth(videoView.bounds),
                                    CGRectGetMinY(cropRect)/CGRectGetHeight(videoView.bounds),
                                    CGRectGetWidth(cropRect)/CGRectGetWidth(videoView.bounds),
                                    CGRectGetHeight(cropRect)/CGRectGetHeight(videoView.bounds));
    }
    return rectOfInterest;
}

@end
