//
//  CellUseOfViewController.m
//  SeekcyBeaconSDKDemo
//
//  Created by seekcy on 15/7/1.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "CellUseOfViewController.h"
#import "CellUseOfChooseViewController.h"
@import SeekcyBeaconSDK;

@interface CellUseOfViewController ()<CellUseOfChooseViewControllerDelegate>{
    NSInteger selectedRow;
}

@end

@implementation CellUseOfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
    }
    
    if(indexPath.row == 0){
        cell.textLabel.text = @"格子1";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.configBeacon.cellUseOfToWrite[1]];
    }
    else if (indexPath.row == 1){
        cell.textLabel.text = @"格子2";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.configBeacon.cellUseOfToWrite[2]];
    }
    else if (indexPath.row == 2){
        cell.textLabel.text = @"格子3";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.configBeacon.cellUseOfToWrite[3]];
    }
    else if (indexPath.row == 3){
        cell.textLabel.text = @"格子4";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.configBeacon.cellUseOfToWrite[4]];
    }
    else if (indexPath.row == 4){
        cell.textLabel.text = @"格子5";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.configBeacon.cellUseOfToWrite[5]];
    }
    else if (indexPath.row == 5){
        cell.textLabel.text = @"格子6";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.configBeacon.cellUseOfToWrite[6]];
    }
    else if (indexPath.row == 6){
        cell.textLabel.text = @"格子7";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.configBeacon.cellUseOfToWrite[7]];
    }
    else if (indexPath.row == 7){
        cell.textLabel.text = @"格子8";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.configBeacon.cellUseOfToWrite[8]];
    }
    else if (indexPath.row == 8){
        cell.textLabel.text = @"格子9";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.configBeacon.cellUseOfToWrite[9]];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedRow = indexPath.row;
    
    CellUseOfChooseViewController *vc = [[CellUseOfChooseViewController alloc] init];
    vc.delegate = self;
    vc.configBeacon = self.configBeacon;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)selectedIndex:(NSInteger)index{
    
    if(index == 3){
        self.configBeacon.cellUseOfToWrite[selectedRow+1] = [NSNull null];
    }
    else{
        self.configBeacon.cellUseOfToWrite[selectedRow+1] = [NSString stringWithFormat:@"%ld",(long)index];
    }
    
    int count = 0;
    for(int i = 1 ; i < self.configBeacon.cellUseOfToWrite.count ; i ++){
        
        if(![self.configBeacon.cellUseOfToWrite[i] isKindOfClass:[NSNull class]] && ![self.configBeacon.cellUseOfToWrite[i] isEqualToString:@""]){
            count ++;
        }
    }
    self.configBeacon.cellUseOfToWrite[0] = [NSString stringWithFormat:@"%ld",(long)count];
    selectedRow = -1;
    [self.tableView reloadData];
}

@end
