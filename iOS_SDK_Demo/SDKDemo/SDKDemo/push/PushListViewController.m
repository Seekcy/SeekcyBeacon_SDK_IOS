//
//  PushListViewController.m
//  SDKDemo
//
//  Created by seekcy on 16/4/7.
//  Copyright © 2016年 com.seekcy. All rights reserved.
//

#import "PushListViewController.h"
@import SeekcyBeaconSDK;

@interface PushListViewController ()<SKYBeaconManagerRangingDelegate>

@property (nonatomic, strong) NSMutableArray *rangedPushBeacon;

@end

@implementation PushListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _rangedPushBeacon = [[NSMutableArray alloc] init];
    
    
    UISegmentedControl *sgmentControl = [[UISegmentedControl alloc] initWithItems:@[@"1m",@"3m",@"middle",@"far"]];
    sgmentControl.frame = CGRectMake(0.0, 0.0, 250.0, 35.0);
    [sgmentControl addTarget:self action:@selector(sgmentControlChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = sgmentControl;
    
    NSMutableArray *rangingArray = [[NSMutableArray alloc] init];
    SKYBeaconRegion *region = [[SKYBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"FDA50693-A4E2-4FB1-AFCF-C6EB07647825"] major:1 identifier:@"wx_1"];
    [rangingArray addObject:region];
    
    sgmentControl.selectedSegmentIndex = 1;
    // 不设置的话，默认 -59
    [[SKYBeaconManager sharedDefaults] setRangedNearByPhoneMeasuredPower:-60];
    // 不设置的话，SKYBeaconNearbyThresholdNEAR_1_METER
    [[SKYBeaconManager sharedDefaults] setRangedNearByTriggerThreshold:SKYBeaconNearbyThresholdNEAR_3_METER];
    [[SKYBeaconManager sharedDefaults] startRangedNearBySKYBeaconsInRegions:rangingArray completion:^(BOOL complete, NSError *error, NSArray *beacons) {
        [_rangedPushBeacon removeAllObjects];
        [_rangedPushBeacon addObjectsFromArray:beacons];
        [self.tableView reloadData];
    }];
}

- (void)sgmentControlChanged:(UISegmentedControl *)sender{
    NSInteger index = sender.selectedSegmentIndex;
    
    switch (index) {
        case 0:
            [[SKYBeaconManager sharedDefaults] setRangedNearByTriggerThreshold:SKYBeaconNearbyThresholdNEAR_1_METER];
            break;
        case 1:
            [[SKYBeaconManager sharedDefaults] setRangedNearByTriggerThreshold:SKYBeaconNearbyThresholdNEAR_3_METER];
            break;
        case 2:
            [[SKYBeaconManager sharedDefaults] setRangedNearByTriggerThreshold:SKYBeaconNearbyThresholdMIDDLE];
            break;
        case 3:
            [[SKYBeaconManager sharedDefaults] setRangedNearByTriggerThreshold:SKYBeaconNearbyThresholdFAR];
            break;
            
        default:
            break;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _rangedPushBeacon.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    SKYBeacon * beacon = [_rangedPushBeacon objectAtIndex:indexPath.row];
    
    NSMutableString *s = [NSMutableString string];
    [s appendFormat:@"uuid:%@\n",beacon.proximityUUID];
    [s appendFormat:@"major:%@\n",beacon.major];
    [s appendFormat:@"minor:%@\n",beacon.minor];
    [s appendFormat:@"rssi:%@ dBm\n",beacon.rssi];
    [s appendFormat:@"权重:%.2f\n",beacon.pushWeight];
    
    cell.detailTextLabel.text = s;
    cell.detailTextLabel.numberOfLines = 50;
    
    return cell;
    
}


@end
