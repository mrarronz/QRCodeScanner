//
//  CustomButton.m
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/17.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

+ (instancetype)buttonWithTitle:(NSString *)title image:(UIImage *)image {
    CustomButton *button = [[CustomButton alloc] init];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.labelMargin = 5;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setLabelMargin:(CGFloat)labelMargin {
    _labelMargin = labelMargin;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIImage *normalImage = [self imageForState:UIControlStateNormal];
    CGSize imageSize = normalImage.size;
    CGFloat totalHeight = imageSize.height + self.labelMargin + 20;
    
    CGFloat originY = (CGRectGetHeight(self.bounds) - totalHeight)/2;
    self.imageView.frame = CGRectMake((CGRectGetWidth(self.bounds) - imageSize.width)/2,
                                      originY,
                                      imageSize.width,
                                      imageSize.height);
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + self.labelMargin, CGRectGetWidth(self.bounds), 20);
    
}

@end
