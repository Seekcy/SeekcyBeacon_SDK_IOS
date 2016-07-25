//
//  SICBaseViewController.m
//  SeekcyIBeaconConfig
//
//  Created by seekcy on 15/6/16.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "SICBaseViewController.h"

@interface SICBaseViewController ()

@end

@implementation SICBaseViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *navBack = [UIButton buttonWithType:UIButtonTypeCustom];
    navBack.frame = CGRectMake(0, 0, 32, 32);
    [navBack setImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
    [navBack addTarget:self action:@selector(navBackPress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:navBack];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)navBackPress{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
