//
//  ScanSKYBeaconViewController.m
//  SDKDemo
//
//  Created by seekcy on 15/10/8.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "ScanSKYBeaconViewController.h"
#import "SVProgressHUD.h"
#import "SICiBeaconConfigViewController.h"
#import "MutipleIDBeaconConfiglViewController.h"
@import SeekcyBeaconSDK;

@interface ScanSKYBeaconViewController ()<SKYBeaconManagerScanDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *scanUUIDArray;
    NSMutableArray *peripheralsForScanArray;
}

@property (nonatomic, strong) UITableView *tbView;

@end

@implementation ScanSKYBeaconViewController

- (void)loadView{
    [super loadView];
    
    //
    // tableview
    self.tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    [self.view addSubview:self.tbView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"扫描列表";
    
    peripheralsForScanArray = [[NSMutableArray alloc] init];
    scanUUIDArray = [[NSMutableArray alloc] init];
    
    [scanUUIDArray addObject:[[SKYBeaconScan alloc] initWithuuid:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0" name:@"苹果默认"]];
    [scanUUIDArray addObject:[[SKYBeaconScan alloc] initWithuuid:@"FDA50693-A4E2-4FB1-AFCF-C6EB07647825" name:@"微信摇一摇"]];
    
    // 用于解密mac地址
    [SKYBeaconManager sharedDefaults].seekcyDecryptKey = @""; // 你的解密密钥
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    [SKYBeaconManager sharedDefaults].scanBeaconTimeInterval = 1.2;
    [[SKYBeaconManager sharedDefaults] startScanForSKYBeaconWithDelegate:self uuids:scanUUIDArray distinctionMutipleID:NO isReturnValueEncapsulation:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [[SKYBeaconManager sharedDefaults] stopScanSKYBeacon];
}

#pragma mark - SKYBeaconManagerScanDelegate
- (void)skyBeaconManagerCompletionScanWithBeacons:(NSArray *)beascons error:(NSError *)error{
    
    if(error){
        
        if(error.code == SKYBeaconSDKErrorBlueToothPoweredOff){
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"error"] maskType:SVProgressHUDMaskTypeBlack];
            
        }
        return;
    }
    
//    for(SKYBeacon *beacon in beascons) {
//        //        NSNumber *rssi = beacon.rssi;
//        NSString *major = beacon.major;
//        //        NSString *minor = beacon.minor;
//        //        NSString *macAddress = beacon.macAddress;
//        //        float distance = beacon.distance;
//        
//        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys: major, @"major", nil];
//        
//        NSLog(@"%@ —— %d", dict, [NSJSONSerialization isValidJSONObject: dict]);
//        
//    }
    
    
    NSLog(@"--skyBeaconManagerCompletionScanWithBeacons--");
    NSLog(@"扫描到：%lu 个",(unsigned long)beascons.count);
    
    [peripheralsForScanArray removeAllObjects];
    [peripheralsForScanArray addObjectsFromArray:beascons];
    
    [self.tbView reloadData];
}


#pragma mark - uitableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return peripheralsForScanArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *model = peripheralsForScanArray[indexPath.row];
    
    NSMutableString *s = [NSMutableString string];
    [s appendFormat:@"major:%@\n",model[modelTransitField_major]];
    [s appendFormat:@"minor:%@\n",model[modelTransitField_minor]];
    [s appendFormat:@"mac:%@\n",model[modelTransitField_macAddress]];
    [s appendFormat:@"rssi:%@ dBm\n",model[modelTransitField_rssi]];
    [s appendFormat:@"电量:%@%%\n",model[modelTransitField_battery]];
    [s appendFormat:@"measuredPower:%@\n",model[modelTransitField_measuredPower]];
    [s appendFormat:@"距离:%@m\n",model[modelTransitField_distance]];
    
    
    cell.textLabel.text = model[modelTransitField_uuidReplaceName];
    cell.detailTextLabel.text = s;
    
    cell.detailTextLabel.numberOfLines = 50;
    
    
    if([model[modelTransitField_isMutipleID] boolValue]){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 40, 5, 17, 32/2)];
        label.text = @"多";
        [cell addSubview:label];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *model = peripheralsForScanArray[indexPath.row];
    
    
    if([[model objectForKey:modelTransitField_isMutipleID] boolValue]){
        SKYBeaconMutipleID *muti = [[SKYBeaconMutipleID alloc] init];
        muti.peripheral = [model objectForKey:modelTransitField_peripheral];
        muti.macAddress = [model objectForKey:modelTransitField_macAddress];
        muti.deviceName = [model objectForKey:modelTransitField_deviceName];
        muti.hardwareVersion = [model objectForKey:modelTransitField_hardwareVersion];
        muti.firmwareVersionMajor = [model objectForKey:modelTransitField_firmwareVersionMajor];
        muti.firmwareVersionMinor = [model objectForKey:modelTransitField_firmwareVersionMinor];
        muti.uuidReplaceName = [model objectForKey:modelTransitField_uuidReplaceName];
        muti.rssi = [model objectForKey:modelTransitField_rssi];
        muti.battery = [[model objectForKey:modelTransitField_battery] integerValue];
        muti.temperature = [[model objectForKey:modelTransitField_temperature] floatValue];
        muti.isLocked = [[model objectForKey:modelTransitField_isLocked] boolValue];
        muti.isSeekcyBeacon = [[model objectForKey:modelTransitField_isSeekcyBeacon] boolValue];
        muti.timestampMillisecond = [[model objectForKey:modelTransitField_timestampMillisecond] longValue];
        muti.intervalMillisecond = [model objectForKey:modelTransitField_intervalMillisecond];
        
        SKYBeaconMutipleIDCharacteristicInfo *info1 = [[SKYBeaconMutipleIDCharacteristicInfo alloc] initWithcharacteristicID:@"1" uuid:[model objectForKey:modelTransitField_proximityUUID] major:[model objectForKey:modelTransitField_major] minor:[model objectForKey:modelTransitField_minor] txPower:[[model objectForKey:modelTransitField_txPower] intValue] measuredPower:@"" isEncrypted:[[model objectForKey:modelTransitField_isEncrypted] boolValue]];
        [muti.characteristicInfo setValue:info1 forKey:SKYBeaconMutipleIDCharacteristicInfoKeyOne];
        
        MutipleIDBeaconConfiglViewController *vc = [[MutipleIDBeaconConfiglViewController alloc] init];
        vc.detailBeacon = muti;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        SKYBeacon *single = [[SKYBeacon alloc] init];
        single.peripheral = [model objectForKey:modelTransitField_peripheral];
        single.macAddress = [model objectForKey:modelTransitField_macAddress];
        single.deviceName = [model objectForKey:modelTransitField_deviceName];
        single.hardwareVersion = [model objectForKey:modelTransitField_hardwareVersion];
        single.firmwareVersionMajor = [model objectForKey:modelTransitField_firmwareVersionMajor];
        single.firmwareVersionMinor = [model objectForKey:modelTransitField_firmwareVersionMinor];
        single.uuidReplaceName = [model objectForKey:modelTransitField_uuidReplaceName];
        single.proximityUUID = [model objectForKey:modelTransitField_proximityUUID];
        single.major =  [model objectForKey:modelTransitField_major];
        single.minor = [model objectForKey:modelTransitField_minor];
        single.measuredPower = [model objectForKey:modelTransitField_measuredPower];
        single.intervalMillisecond = [model objectForKey:modelTransitField_intervalMillisecond];
        single.txPower = [[model objectForKey:modelTransitField_txPower] intValue];
        single.rssi = [model objectForKey:modelTransitField_rssi];
        single.battery = [[model objectForKey:modelTransitField_battery] integerValue];
        single.temperature = [[model objectForKey:modelTransitField_temperature] floatValue];
        single.isLocked = [[model objectForKey:modelTransitField_isLocked] boolValue];
        single.isEncrypted = [[model objectForKey:modelTransitField_isEncrypted] boolValue];
        single.isSeekcyBeacon = [[model objectForKey:modelTransitField_isSeekcyBeacon] boolValue];
        single.timestampMillisecond = [[model objectForKey:modelTransitField_timestampMillisecond] longValue];
        
        SICiBeaconConfigViewController *vc = [[SICiBeaconConfigViewController alloc] init];
        vc.detailBeacon = single;
        [self.navigationController pushViewController:vc animated:YES];
    }

}

@end
