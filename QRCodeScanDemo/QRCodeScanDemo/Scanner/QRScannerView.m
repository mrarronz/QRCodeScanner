//
//  QRScannerView.m
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/11.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import "QRScannerView.h"

@interface QRScannerView ()

@property (nonatomic, strong) QRScannerStyle *scannerStyle;

/**
 * 准备中的提示菊花
 */
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
/**
 * 准备中的提示文字
 */
@property (nonatomic, strong) UILabel *readyLabel;
/**
 * 方框中移动的扫描线图片
 */
@property (nonatomic, strong) UIImageView *scanLineView;

@end

@implementation QRScannerView

- (instancetype)initWithFrame:(CGRect)frame style:(QRScannerStyle *)style {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _scannerStyle = style;
        [self setupScanLineView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // 扫码框与左右两边的距离
    CGFloat horizontalPadding = _scannerStyle.marginOffset;
    // 扫码框的长宽
    CGFloat rectangleLength = CGRectGetWidth(self.frame) - horizontalPadding * 2;
    
    // 扫码区域y轴最小坐标
    CGFloat minY = CGRectGetHeight(self.frame)/2 - rectangleLength/2 - _scannerStyle.verticalOffset;
    // 扫码区域y轴最大坐标
    CGFloat maxY = minY + rectangleLength;
    // 扫码区域x轴最大坐标
    CGFloat maxX = CGRectGetWidth(self.frame) - horizontalPadding;
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 非扫码区域填充
    CGContextSetFillColorWithColor(context, _scannerStyle.noneRecognizeColor.CGColor);
    
    // 扫码区域的上部分填充
    CGRect tempRect = CGRectMake(0, 0, CGRectGetWidth(self.frame), minY);
    CGContextFillRect(context, tempRect);
    
    // 扫码区域左边填充
    tempRect = CGRectMake(0, minY, horizontalPadding, rectangleLength);
    CGContextFillRect(context, tempRect);
    
    // 扫码区域右边填充
    tempRect = CGRectMake(maxX, minY, horizontalPadding, rectangleLength);
    CGContextFillRect(context, tempRect);
    
    // 扫码区域下边填充
    tempRect = CGRectMake(0, maxY, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - maxY);
    CGContextFillRect(context, tempRect);
    
    CGContextFillPath(context);
    
    
    // 是否需要显示中间的扫码框
    if (_scannerStyle.isNeedShowRectangle) {
        CGContextSetStrokeColorWithColor(context, _scannerStyle.rectangleBorderColor.CGColor);
        CGContextSetLineWidth(context, 1);
        CGContextAddRect(context, CGRectMake(horizontalPadding, minY, rectangleLength, rectangleLength));
        CGContextStrokePath(context);
    }
    
    // 绘制矩形框外的四个角
    CGFloat length = _scannerStyle.angleLineLength;
    CGFloat angleLineWidth = _scannerStyle.angleLineWidth;
    CGFloat diffAngle = _scannerStyle.isAngleDisplayInner ? -angleLineWidth/2 : angleLineWidth/3;
    
    CGContextSetStrokeColorWithColor(context, _scannerStyle.angleColor.CGColor);
    CGContextSetLineWidth(context, angleLineWidth);
    
    CGFloat leftX = horizontalPadding - diffAngle;
    CGFloat rightX = maxX + diffAngle;
    CGFloat topY = minY - diffAngle;
    CGFloat bottomY = maxY + diffAngle;
    
    // 左上角水平线
    CGContextMoveToPoint(context, leftX - angleLineWidth/2, topY);
    CGContextAddLineToPoint(context, leftX + length, topY);
    
    // 左上角垂直线
    CGContextMoveToPoint(context, leftX, topY - angleLineWidth/2);
    CGContextAddLineToPoint(context, leftX, topY + length);
    
    // 左下角水平线
    CGContextMoveToPoint(context, leftX - angleLineWidth/2, bottomY);
    CGContextAddLineToPoint(context, leftX + length, bottomY);
    
    // 左下角垂直线
    CGContextMoveToPoint(context, leftX, bottomY + angleLineWidth/2);
    CGContextAddLineToPoint(context, leftX, bottomY - length);
    
    // 右上角水平线
    CGContextMoveToPoint(context, rightX + angleLineWidth/2, topY);
    CGContextAddLineToPoint(context, rightX - length, topY);
    
    // 右上角垂直线
    CGContextMoveToPoint(context, rightX, topY - angleLineWidth/2);
    CGContextAddLineToPoint(context, rightX, topY + length);
    
    // 右下角水平线
    CGContextMoveToPoint(context, rightX + angleLineWidth/2, bottomY);
    CGContextAddLineToPoint(context, rightX - length, bottomY);
    
    // 右下角垂直线
    CGContextMoveToPoint(context, rightX, bottomY + angleLineWidth/2);
    CGContextAddLineToPoint(context, rightX, bottomY - length);
    
    CGContextStrokePath(context);
    
}

- (void)showLoadingView {
    [self addSubview:self.indicatorView];
    [self addSubview:self.readyLabel];
    
    CGFloat totalWidth = CGRectGetWidth(self.indicatorView.bounds) + CGRectGetWidth(self.readyLabel.bounds) + 10;
    CGFloat rectangleLength = CGRectGetWidth(self.bounds) - _scannerStyle.marginOffset * 2;
    
    // UIActivityIndicatorView的x坐标
    CGFloat originX = (rectangleLength - totalWidth)/2 + _scannerStyle.marginOffset;
    
    // 扫码区域y轴最小坐标
    CGFloat minY = CGRectGetHeight(self.frame)/2 - rectangleLength/2 - _scannerStyle.verticalOffset;
    // 确定菊花的位置
    self.indicatorView.center = CGPointMake(originX + CGRectGetWidth(self.indicatorView.bounds)/2, minY + rectangleLength/2);
    
    self.readyLabel.frame = CGRectMake(originX + CGRectGetWidth(self.indicatorView.bounds) + 10,
                                       CGRectGetMinY(self.indicatorView.frame),
                                       CGRectGetWidth(self.readyLabel.bounds),
                                       CGRectGetHeight(self.indicatorView.frame));
    
    [self.indicatorView startAnimating];
}

- (void)hideLoadingView {
    if (_indicatorView) {
        [_indicatorView stopAnimating];
        [_indicatorView removeFromSuperview];
        [_readyLabel removeFromSuperview];
    }
}

- (void)setupScanLineView {
    CGFloat rectangleLength = CGRectGetWidth(self.bounds) - _scannerStyle.marginOffset * 2;
    // 扫码区域y轴最小坐标
    CGFloat minY = CGRectGetHeight(self.frame)/2 - rectangleLength/2 - _scannerStyle.verticalOffset;
    
    self.scanLineView.frame = CGRectMake(_scannerStyle.marginOffset, minY, rectangleLength, 2);
    if (_scannerStyle.scanLineImage) {
        self.scanLineView.image = _scannerStyle.scanLineImage;
        self.scanLineView.backgroundColor = [UIColor clearColor];
        self.scanLineView.contentMode = UIViewContentModeScaleAspectFill;
    } else {
        self.scanLineView.image = nil;
        self.scanLineView.backgroundColor = _scannerStyle.angleColor;
    }
    [self addSubview:self.scanLineView];
    self.scanLineView.hidden = YES;
}

- (void)startAnimating {
    self.scanLineView.hidden = NO;
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    anim.toValue = [NSNumber numberWithFloat:(CGRectGetWidth(self.bounds) - _scannerStyle.marginOffset * 2)];
    anim.duration = 2.0;
    anim.repeatCount = INFINITY;
    anim.removedOnCompletion = NO;
    [self.scanLineView.layer addAnimation:anim forKey:@"transAnim"];
}

- (void)stopAnimating {
    if ([self.scanLineView.layer animationForKey:@"transAnim"]) {
        [self.scanLineView.layer removeAnimationForKey:@"transAnim"];
    }
    self.scanLineView.hidden = YES;
}

#pragma mark - Init property

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return _indicatorView;
}

- (UILabel *)readyLabel {
    if (!_readyLabel) {
        _readyLabel = [[UILabel alloc] init];
        _readyLabel.font = [UIFont systemFontOfSize:16];
        _readyLabel.textColor = [UIColor whiteColor];
        _readyLabel.text = @"准备中...";
        [_readyLabel sizeToFit];
    }
    return _readyLabel;
}

- (UIImageView *)scanLineView {
    if (!_scanLineView) {
        _scanLineView = [[UIImageView alloc] init];
    }
    return _scanLineView;
}

@end
