//
//  IntervalChooseViewController.m
//  SeekcyIBeaconConfig
//
//  Created by seekcy on 15/7/21.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "IntervalChooseViewController.h"

@interface IntervalChooseViewController ()

@property (strong, nonatomic) UISlider *intervalSlider;
@property (strong, nonatomic) UILabel *intervalLabel;

@end

@implementation IntervalChooseViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"发送间隔";
    
    _intervalLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, self.view.frame.size.width - 20, 30)];
    _intervalLabel.text = [NSString stringWithFormat:@"%@0 ms",self.defaultInterval];
    [self.view addSubview:_intervalLabel];
    
    _intervalSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, _intervalLabel.frame.size.height + _intervalLabel.frame.origin.y + 5, self.view.frame.size.width - 20, 35)];
    _intervalSlider.maximumValue = 200;
    _intervalSlider.minimumValue = 10;
    _intervalSlider.value = [self.defaultInterval intValue];
    [self.view addSubview:_intervalSlider];
    [_intervalSlider addTarget:self action:@selector(intervalSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)intervalSliderValueChanged:(UISlider *)senderSlider{
    int value = senderSlider.value;
    _intervalLabel.text = [NSString stringWithFormat:@"%d ms",value*10];
}


- (void)navBackPress{
    chooseIntervalBlock([NSString stringWithFormat:@"%d",(int)_intervalSlider.value]);
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)chooseIntervalBlock:(void(^)(NSString *intervalString))block{
    chooseIntervalBlock = block;
}

@end
