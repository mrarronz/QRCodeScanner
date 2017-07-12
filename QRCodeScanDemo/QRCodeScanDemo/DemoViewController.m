//
//  DemoViewController.m
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/12.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import "DemoViewController.h"
#import "QRScannerView.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    QRScannerView *scanView = [[QRScannerView alloc] initWithFrame:self.view.bounds
                                                             style:[QRScannerStyle defaultStyle]];
    [self.view addSubview:scanView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

@end
