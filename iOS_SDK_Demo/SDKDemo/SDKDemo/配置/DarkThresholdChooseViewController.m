//
//  DarkThresholdChooseViewController.m
//  SeekcyIBeaconConfig
//
//  Created by seekcy on 15/8/3.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "DarkThresholdChooseViewController.h"

@interface DarkThresholdChooseViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation DarkThresholdChooseViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _dataArray = @[@{@"text":@"档位1",@"value":@"1"},@{@"text":@"档位2",@"value":@"2"},@{@"text":@"档位3",@"value":@"3"},@{@"text":@"档位4",@"value":@"4"},@{@"text":@"档位5",@"value":@"5"}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CityCellIdentifier = @"CityCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CityCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *obj = _dataArray[indexPath.row];
    cell.textLabel.text = obj[@"text"];
    
    if([_selectedValue isEqualToString:obj[@"value"]]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *obj = _dataArray[indexPath.row];
    chooseDarkThresholdBlock(obj[@"value"]);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)chooseDarkThresholdBlock:(void(^)(NSString *darkThresholdString))block{
    chooseDarkThresholdBlock = block;
}


@end
