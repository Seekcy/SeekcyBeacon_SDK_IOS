//
//  ViewController.m
//  SeekcyBeaconSDKDemo
//
//  Created by seekcy on 15/6/17.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "MutipleIDDetailViewController.h"
@import SeekcyBeaconSDK;

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,SKYBeaconManagerScanDelegate,SKYBeaconManagerMonitorDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *beaconScanedArray;
@property (nonatomic, strong) NSMutableArray *beaconScanedArraySingleID;
@property (nonatomic, strong) NSMutableArray *beaconScanedArrayMutipleID;

- (void)scanSKYBeacons;
- (void)addTableView;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"列表";
    self.beaconScanedArray = [[NSMutableArray alloc] init];
    self.beaconScanedArraySingleID = [[NSMutableArray alloc] init];
    self.beaconScanedArrayMutipleID = [[NSMutableArray alloc] init];
    [self addTableView];
    
    // 设置防蹭用解密密钥
    [SKYBeaconManager sharedDefaults].seekcyDecryptKey = @"A5B5C146ADA7291E7FF5579539C04181B2E3F58C232641D741D03EED5932409D";
}

#pragma mark - Getter And Setter

- (void)addTableView{
    self.myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"beaconCell"];
    [self.view addSubview:self.myTableView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self scanSKYBeacons];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[SKYBeaconManager sharedDefaults] stopScanSKYBeacon];
}

#pragma mark - User Method

- (void)scanSKYBeacons{
    // 扫描
    NSArray *scanUUIDArray = @[[[SKYBeaconScan alloc] initWithuuid:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0" name:@"apple"],[[SKYBeaconScan alloc] initWithuuid:@"FDA50693-A4E2-4FB1-AFCF-C6EB07647825" name:@"寻息摇一摇"],[[SKYBeaconScan alloc] initWithuuid:@"C91ABDBE-DF54-4501-A3AA-D7BDF1FD2E1D" name:@"aaaaa"]]; 
    [[SKYBeaconManager sharedDefaults] startScanForSKYBeaconWithDelegate:self uuids:scanUUIDArray distinctionMutipleID:YES];
}


#pragma mark - SKYBeaconManagerScanDelegate
// 返回全部beacon
- (void)skyBeaconManagerCompletionScanWithBeacons:(NSArray *)beascons error:(SKYBeaconManagerError *)error{
    
    if(!error){
//        [self.beaconScanedArray removeAllObjects];
//        [self.beaconScanedArray addObjectsFromArray:beascons];
//        [self.myTableView reloadData];
    }
    else{
        // do sth...
    }
}

// 返回单id beacon
- (void)skyBeaconManagerCompletionScanWithSingleIDBeacons:(NSArray *)beascons error:(SKYBeaconManagerError *)error{
    
    if(!error){
        [self.beaconScanedArraySingleID removeAllObjects];
        [self.beaconScanedArraySingleID addObjectsFromArray:beascons];
        [self.myTableView reloadData];
    }
    else{
        // do sth...
    }
}

// 返回多id beacon
- (void)skyBeaconManagerCompletionScanWithMutipleIDBeacons:(NSArray *)beascons error:(SKYBeaconManagerError *)error{
    
    if(!error){
        [self.beaconScanedArrayMutipleID removeAllObjects];
        [self.beaconScanedArrayMutipleID addObjectsFromArray:beascons];
        [self.myTableView reloadData];
    }
    else{
        // do sth...
    }
}

- (void)configCell:(UITableViewCell *)cell skyBeacon:(SKYBeacon *)beacon{
    
    UILabel *deviceNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 35)];
    deviceNameLabel.numberOfLines = 2;
    deviceNameLabel.lineBreakMode = NSLineBreakByCharWrapping;
    deviceNameLabel.backgroundColor = [UIColor whiteColor];
    deviceNameLabel.font = [UIFont systemFontOfSize:14];
    [cell addSubview:deviceNameLabel];
    
    UILabel *rssiLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, deviceNameLabel.frame.origin.y + deviceNameLabel.frame.size.height + 5, 100, 35)];
    rssiLabel.numberOfLines = 2;
    rssiLabel.lineBreakMode = NSLineBreakByCharWrapping;
    rssiLabel.backgroundColor = [UIColor whiteColor];
    rssiLabel.font = [UIFont systemFontOfSize:14];
    [cell addSubview:rssiLabel];
    
    UILabel *otherInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(100 + 10, 5, self.myTableView.frame.size.width - (100 + 10) - 5, 180)];
    otherInfoLabel.numberOfLines = 20;
    otherInfoLabel.lineBreakMode = NSLineBreakByCharWrapping;
    otherInfoLabel.backgroundColor = [UIColor whiteColor];
    otherInfoLabel.font = [UIFont systemFontOfSize:12];
    [cell addSubview:otherInfoLabel];
    
    deviceNameLabel.text = beacon.deviceName == nil ? @"Unknow" : beacon.deviceName;
    rssiLabel.text = [NSString stringWithFormat:@"%@ dBm",beacon.rssi];
    
    NSMutableString *otherString = [NSMutableString stringWithString:@""];
    [otherString appendFormat:@"mac地址:%@\n",beacon.macAddress];
    [otherString appendFormat:@"uuid name:%@\n",beacon.uuidReplaceName];
    [otherString appendFormat:@"uuid:%@\n",beacon.proximityUUID];
    [otherString appendFormat:@"major:%@\n",beacon.major];
    [otherString appendFormat:@"minor:%@\n",beacon.minor];
    [otherString appendFormat:@"版本号:%@-%@-%@\n",beacon.hardwareVersion,beacon.firmwareVersionMajor,beacon.firmwareVersionMinor];
    [otherString appendFormat:@"实测功率:%@\n",beacon.measuredPower];
    [otherString appendFormat:@"发送间隔:%@\n",beacon.intervalMillisecond];
    [otherString appendFormat:@"发送功率:%@\n",beacon.txPower];
    [otherString appendFormat:@"电量:%ld%%\n",(long)beacon.battery];
    [otherString appendFormat:@"距离:%.1f\n",beacon.distance];
    [otherString appendFormat:@"温度:%.1f\n",beacon.temperature];
    
    otherInfoLabel.text = otherString;
}


- (void)configCell:(UITableViewCell *)cell skyMutipleBeacon:(SKYBeaconMutipleID *)beacon{
    
    UILabel *deviceNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 35)];
    deviceNameLabel.numberOfLines = 2;
    deviceNameLabel.lineBreakMode = NSLineBreakByCharWrapping;
    deviceNameLabel.backgroundColor = [UIColor whiteColor];
    deviceNameLabel.font = [UIFont systemFontOfSize:14];
    [cell addSubview:deviceNameLabel];
    
    UILabel *rssiLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, deviceNameLabel.frame.origin.y + deviceNameLabel.frame.size.height + 5, 100, 35)];
    rssiLabel.numberOfLines = 2;
    rssiLabel.lineBreakMode = NSLineBreakByCharWrapping;
    rssiLabel.backgroundColor = [UIColor whiteColor];
    rssiLabel.font = [UIFont systemFontOfSize:14];
    [cell addSubview:rssiLabel];
    
    UILabel *otherInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(100 + 10, 5, self.myTableView.frame.size.width - (100 + 10) - 5, 180)];
    otherInfoLabel.numberOfLines = 20;
    otherInfoLabel.lineBreakMode = NSLineBreakByCharWrapping;
    otherInfoLabel.backgroundColor = [UIColor whiteColor];
    otherInfoLabel.font = [UIFont systemFontOfSize:12];
    [cell addSubview:otherInfoLabel];
    
    deviceNameLabel.text = beacon.deviceName == nil ? @"Unknow" : beacon.deviceName;
    rssiLabel.text = [NSString stringWithFormat:@"%@ dBm",beacon.rssi];
    
    NSMutableString *otherString = [NSMutableString stringWithString:@""];
    [otherString appendFormat:@"mac地址:%@\n",beacon.macAddress];
    [otherString appendFormat:@"uuid name:%@\n",beacon.uuidReplaceName];
    [otherString appendFormat:@"uuid:%@\n",[beacon uuid]];
    [otherString appendFormat:@"major:%@\n",[beacon major]];
    [otherString appendFormat:@"minor:%@\n",[beacon minor]];
    [otherString appendFormat:@"版本号:%@-%@-%@\n",beacon.hardwareVersion,beacon.firmwareVersionMajor,beacon.firmwareVersionMinor];
    [otherString appendFormat:@"实测功率:%@\n",[beacon measuredPower]];
    [otherString appendFormat:@"发送间隔:%@\n",beacon.intervalMillisecond];
    [otherString appendFormat:@"发送功率:%@\n",[beacon txPower]];
    [otherString appendFormat:@"电量:%ld%%\n",(long)beacon.battery];
    [otherString appendFormat:@"距离:%.1f\n",beacon.distance];
    [otherString appendFormat:@"温度:%.1f\n",beacon.temperature];
    
    otherInfoLabel.text = otherString;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        return @"单id";
    }
    else if (section == 1){
        return @"多id";
    }
    
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        return self.beaconScanedArraySingleID.count;
    }
    else if (section == 1){
        return self.beaconScanedArrayMutipleID.count;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"];
    
    
    if(indexPath.section == 0){
        SKYBeacon *beacon = self.beaconScanedArraySingleID[indexPath.row];
        [self configCell:cell skyBeacon:beacon];
    }
    else if (indexPath.section == 1){
        SKYBeaconMutipleID *beacon = self.beaconScanedArrayMutipleID[indexPath.row];
        [self configCell:cell skyMutipleBeacon:beacon];
    }
    
    return cell;
}

#pragma mark - UItableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(indexPath.section == 0){
        SKYBeacon *beacon = self.beaconScanedArraySingleID[indexPath.row];
        DetailViewController *detailViewController = [[DetailViewController alloc] init];
        detailViewController.detailBeacon = beacon;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    else if (indexPath.section == 1){
        SKYBeaconMutipleID *beacon = self.beaconScanedArrayMutipleID[indexPath.row];
        MutipleIDDetailViewController *vc = [[MutipleIDDetailViewController alloc] init];
        vc.detailBeacon = beacon;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
