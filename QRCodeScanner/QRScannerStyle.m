//
//  QRScannerStyle.m
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/11.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import "QRScannerStyle.h"

@implementation QRScannerStyle

+ (QRScannerStyle *)defaultStyle {
    static QRScannerStyle *styleInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        styleInstance = [[self alloc] init];
    });
    return styleInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _isNeedShowRectangle = YES;
        _isAngleDisplayInner = NO;
        _playCustomSound = NO;
        _verticalOffset = 60;
        _marginOffset = 60;
        _rectangleBorderColor = [UIColor whiteColor];
        _angleColor = [UIColor colorWithRed:0.1 green:0.8 blue:0.3 alpha:1.0];
        _noneRecognizeColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _angleLineWidth = 7;
        _angleLineLength = 24;
    }
    return self;
}



@end
