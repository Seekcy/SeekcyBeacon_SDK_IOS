//
//  TemperatureUpdateFrequencyChooseViewController.m
//  SeekcyIBeaconConfig
//
//  Created by seekcy on 15/8/3.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "TemperatureUpdateFrequencyChooseViewController.h"

@interface TemperatureUpdateFrequencyChooseViewController ()

@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UISlider *slider;

@end

@implementation TemperatureUpdateFrequencyChooseViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title = @"温度值更新频率选择";
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveItemPress)];
    self.navigationItem.rightBarButtonItem = saveItem;
    
    _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 20)];
    _valueLabel.font = [UIFont boldSystemFontOfSize:17];
    _valueLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_valueLabel];
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 40, self.view.frame.size.width - 20, 40)];
    _slider.maximumValue = 1800;
    _slider.minimumValue = 1;
    _slider.continuous = YES;
    [self.view addSubview:_slider];
    [_slider addTarget:self action:@selector(sliderValueChange) forControlEvents:UIControlEventValueChanged];
    
    _slider.value = [self.selectedValue intValue];
    [self sliderValueChange];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 100, self.view.frame.size.width - 20, 40);
    button.backgroundColor = kMainNavColor;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:@"关闭温度更新" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(closeTemperatureUpdateFrequency) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)closeTemperatureUpdateFrequency{
    chooseValueBlock(@"0");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveItemPress{
    chooseValueBlock([NSString stringWithFormat:@"%d",(int)_slider.value]);
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)sliderValueChange{
    _valueLabel.text = [NSString stringWithFormat:@"%d ms",(int)_slider.value];
}


- (void)chooseValueBlock:(void(^)(NSString *valueString))block{
    chooseValueBlock = block;
}


@end
