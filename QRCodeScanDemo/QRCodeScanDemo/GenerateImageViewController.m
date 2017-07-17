//
//  GenerateImageViewController.m
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/17.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import "GenerateImageViewController.h"
#import "UIImage+QRScanner.h"

@interface GenerateImageViewController ()

@end

@implementation GenerateImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    [self.view addSubview:imageView];
    imageView.center = self.view.center;
//    imageView.image = [UIImage QRImageWithText:@"这是一个二维码" size:150];
    imageView.image = [UIImage QRImageWithText:@"这是一个二维码"
                                          size:CGSizeMake(150, 150)
                                    frontColor:[UIColor blackColor]
                               backgroundColor:[[UIColor redColor]
                                                colorWithAlphaComponent:0.5]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
