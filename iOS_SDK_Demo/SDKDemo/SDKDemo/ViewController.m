//
//  ViewController.m
//  SDKDemo
//
//  Created by seekcy on 15/9/30.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "ViewController.h"
#import "ScanSKYBeaconViewController.h"
#import "PushListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"功能列表";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scanSKYBeacon:(id)sender {
    ScanSKYBeaconViewController *vc = [[ScanSKYBeaconViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)pushSKYBeacon:(id)sender {
    PushListViewController *vc = [[PushListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
