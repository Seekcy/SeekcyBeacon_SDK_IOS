//
//  RangingViewController.m
//  SeekcyBeaconSDKDemo
//
//  Created by seekcy on 15/6/26.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "RangingViewController.h"
@import SeekcyBeaconSDK;

@interface RangingViewController ()<SKYBeaconManagerRangingDelegate,UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *rangingBeacons;
@property (nonatomic, strong) NSMutableArray *rangingedBeacons;

- (void)addTableView;

@end

@implementation RangingViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rangingBeacons = @[[[SKYBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"] identifier:@"苹果默认"],
                            [[SKYBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"FDA50693-A4E2-4FB1-AFCF-C6EB07647825"] identifier:@"苹果默认1"]];
    self.rangingedBeacons = [[NSMutableArray alloc] init];
    [self addTableView];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    // 监听
    [[SKYBeaconManager sharedDefaults] startRangingSKYBeaconsInRegions:self.rangingBeacons
                                                                 delegate:self];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [[SKYBeaconManager sharedDefaults] stopRangingSKYBeaconsInRegions:self.rangingBeacons];
}

#pragma mark - Getter And Setter

- (void)addTableView{
    self.myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"beaconCell"];
    [self.view addSubview:self.myTableView];
}

#pragma mark - SKYBeaconManagerRangingDelegate
- (void)skyBeaconManagerDidRangeBeacons:(NSArray *)beacons inRegion:(SKYBeaconRegion *)region{
    [self.rangingedBeacons removeAllObjects];
    [self.rangingedBeacons addObjectsFromArray:beacons];
    [self.myTableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rangingedBeacons.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    CLBeacon *beacon = self.rangingedBeacons[indexPath.row];
    cell.textLabel.text = beacon.proximityUUID.UUIDString;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Major:%@  Minor:%@",beacon.major,beacon.minor];
    
    return cell;
}

@end
