//
//  ViewController.m
//  QRCodeScanDemo
//
//  Created by Arron Zhu on 2017/7/11.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"
#import "GenerateImageViewController.h"
#import "MobikeScanViewController.h"
#import "OfobikeScanViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *items;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.items = @[@"扫描二维码", @"生成二维码", @"简单模仿摩拜扫码", @"简单模仿ofo扫码"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSString *title = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
        {
            DemoViewController *vc = [[DemoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            GenerateImageViewController *vc = [[GenerateImageViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            MobikeScanViewController *vc = [[MobikeScanViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            OfobikeScanViewController *vc = [[OfobikeScanViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}


@end
