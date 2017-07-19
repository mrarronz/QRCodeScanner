#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "QRCodeScanner.h"
#import "QRScannerHelper.h"
#import "QRScannerStyle.h"
#import "QRScannerView.h"
#import "QRScannerViewController.h"
#import "UIImage+QRScanner.h"

FOUNDATION_EXPORT double QRCodeScannerVersionNumber;
FOUNDATION_EXPORT const unsigned char QRCodeScannerVersionString[];

