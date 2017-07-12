//
//  QRScannerView.h
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/11.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRScannerStyle.h"

@interface QRScannerView : UIView

- (instancetype)initWithFrame:(CGRect)frame style:(QRScannerStyle *)style;

@end
