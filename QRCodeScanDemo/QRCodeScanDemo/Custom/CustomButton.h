//
//  CustomButton.h
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/17.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton

@property (nonatomic, assign) CGFloat labelMargin;

+ (instancetype)buttonWithTitle:(NSString *)title image:(UIImage *)image;

@end
