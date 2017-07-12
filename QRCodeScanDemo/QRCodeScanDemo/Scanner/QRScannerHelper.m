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

@end
