//
//  TxPowerChooseViewController.m
//  SeekcyIBeaconConfig
//
//  Created by seekcy on 15/7/20.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "TxPowerChooseViewController.h"

@interface TxPowerChooseViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *uuidArray;
@property (nonatomic, strong) UITableView *tbView;

- (void)addTableView;


@end

@implementation TxPowerChooseViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发射功率";
    
    
    NSString *beaconVersion = [NSString stringWithFormat:@"%@-%@-%@",self.beaconHardwareVersion,self.beaconFirmwareVersionMajor,self.beaconFirmwareVersionMinor];
    
    if([beaconVersion isEqualToString:@"5-1-1"] ||
       [beaconVersion isEqualToString:@"5-2-0"] ||
       [beaconVersion isEqualToString:@"3-1-0"]){
        
        self.uuidArray = @[@{@"value":@"-21"},
                           @{@"value":@"-18"},
                           @{@"value":@"-15"},
                           @{@"value":@"-12"},
                           @{@"value":@"-9"},
                           @{@"value":@"-6"},
                           @{@"value":@"-3"},
                           @{@"value":@"0"},
                           @{@"value":@"1"},
                           @{@"value":@"2"},
                           @{@"value":@"3"},
                           @{@"value":@"4"},
                           @{@"value":@"5"}];
    }
    else{
        
        self.uuidArray = @[
                           @{@"value":@"0"},
                           @{@"value":@"-2"},
                           @{@"value":@"-4"},
                           @{@"value":@"-6"},
                           @{@"value":@"-8"},
                           @{@"value":@"-10"}];
    }
    
    [self addTableView];
}


#pragma mark - Getter And Setter
- (void)addTableView{
    CGRect frame = self.view.bounds;
    frame.size.height -= 64;
    self.tbView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    [self.view addSubview:self.tbView];
}


- (void)chooseTxPowerBlock:(void(^)(NSString *txPowerString))block{
    chooseTxPowerBlock = block;
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.uuidArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *dic = self.uuidArray[indexPath.row];
    NSString *valueString = [NSString stringWithFormat:@"%@ dBm",dic[@"value"]];
    
    cell.textLabel.text = valueString;
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:17];
    
    if([self.selectedTxPowerString isEqualToString:valueString]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.uuidArray[indexPath.row];
    NSString *valueString = dic[@"value"];
    chooseTxPowerBlock(valueString);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
