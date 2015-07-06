//
//  MonitorViewController.m
//  SeekcyBeaconSDKDemo
//
//  Created by seekcy on 15/6/26.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "MonitorViewController.h"
@import SeekcyBeaconSDK;

@interface MonitorViewController ()<SKYBeaconManagerMonitorDelegate>

@property (nonatomic, strong) NSArray *monitorBeacons;

@end

@implementation MonitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.monitorBeacons = @[[[SKYBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"] identifier:@"苹果默认"],
                       [[SKYBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"FDA50693-A4E2-4FB1-AFCF-C6EB07647825"] identifier:@"苹果默认"]];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    // 监听
    [[SKYBeaconManager sharedDefaults] startMonitoringForSKYBeaconRegions:self.monitorBeacons delegate:self];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[SKYBeaconManager sharedDefaults] stopMonitorForSKYBeaconRegions:self.monitorBeacons];
}


#pragma mark - SKYBeaconManagerMonitorDelegate
- (void)skyBeaconManagerDidEnterRegion:(CLRegion *)region{
    
}

- (void)skyBeaconManagerDidExitRegion:(CLRegion *)region{
    
}

@end
