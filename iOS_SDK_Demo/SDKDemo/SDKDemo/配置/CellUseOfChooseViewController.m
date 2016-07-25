//
//  CellUseOfChooseViewController.m
//  SeekcyBeaconSDKDemo
//
//  Created by seekcy on 15/7/1.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "CellUseOfChooseViewController.h"
@import SeekcyBeaconSDK;


@interface CellUseOfChooseViewController ()

@end

@implementation CellUseOfChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
    }
    
    if(indexPath.row == 0){
        cell.textLabel.text = @"ID1";
    }
    else if(indexPath.row == 1){
        cell.textLabel.text = @"ID2";
    }
    else if(indexPath.row == 2){
        cell.textLabel.text = @"ID3";
    }
    else if(indexPath.row == 3){
        cell.textLabel.text = @"无";
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate selectedIndex:indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
