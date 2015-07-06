//
//  DetailViewController.m
//  SeekcyBeaconSDKDemo
//
//  Created by seekcy on 15/6/19.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "DetailViewController.h"
@import SeekcyBeaconSDK;
@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    UIActivityIndicatorView *activityView;
    SKYBeaconConfigSingleID *beaconToConfig;
    UITextField *keyTextField;
}

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation DetailViewController
@synthesize detailBeacon;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"单id详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(savePress)];
    self.navigationItem.rightBarButtonItem = saveItem;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.center = self.view.center;
    [self.view addSubview:activityView];
    
    [self addTableView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [activityView startAnimating];
    [[SKYBeaconManager sharedDefaults] connectBeacon:self.detailBeacon completion:^(BOOL complete, NSError *error) {
        [activityView stopAnimating];
        
        if(complete){
            // 连接成功
            [UIView animateWithDuration:0.3f animations:^{
                self.myTableView.alpha = 1.0f;
                self.myTableView.hidden = NO;
            }];
            
            // 初始化SKYBeaconConfigSingleID对象， method 1: (需要给变量初始化)
            /*
            beaconToConfig = [[SKYBeaconConfigSingleID alloc] init];
            beaconToConfig.beaconModel = self.detailBeacon;
            beaconToConfig.uuidStringToWrite = self.detailBeacon.proximityUUID;
            beaconToConfig.majorStringToWrite = self.detailBeacon.major;
            beaconToConfig.minorStringToWrite = self.detailBeacon.minor;
            beaconToConfig.measuredPowerStringToWrite = self.detailBeacon.measuredPower;
            beaconToConfig.txPowerStringToWrite = self.detailBeacon.txPower;
            beaconToConfig.intervalStringToWrite = self.detailBeacon.intervalMillisecond;
            beaconToConfig.isLockedToWrite = self.detailBeacon.isLocked;
            beaconToConfig.isEncryptedToWrite = self.detailBeacon.isEncrypted;
             */
            
            // 初始化SKYBeaconConfigSingleID对象， method 2:
            beaconToConfig = [[SKYBeaconConfigSingleID alloc] initWithBeacon:self.detailBeacon];
            
            [self.myTableView reloadData];
        }
        else{
            // 连接失败
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"连接出错" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [[SKYBeaconManager sharedDefaults] cancelBeaconConnection:self.detailBeacon completion:^(BOOL complete, NSError *error) {
        
        if(complete){
            // 取消连接成功
        }
        else{
            // 取消连接失败
        }
    }];
}

- (void)addTableView{
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"beaconCell"];
    self.myTableView.alpha = 0.0f;
    self.myTableView.hidden = YES;
    [self.view addSubview:self.myTableView];
}

- (void)swValueChange:(UISwitch *)senderSwitch{
    beaconToConfig.isLockedToWrite = senderSwitch.isOn;
}

- (void)ledswValueChange:(UISwitch *)senderSwitch{
    beaconToConfig.isLedOnToWrite = senderSwitch.isOn;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    
    NSInteger row = indexPath.row;
    
    if(row == 0){
        cell.textLabel.text = @"uuid";
        cell.detailTextLabel.text = beaconToConfig.uuidStringToWrite;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(row == 1){
        cell.textLabel.text = @"major";
        cell.detailTextLabel.text = beaconToConfig.majorStringToWrite;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(row == 2){
        cell.textLabel.text = @"minor";
        cell.detailTextLabel.text = beaconToConfig.minorStringToWrite;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(row == 3){
        cell.textLabel.text = @"measuredPower";
        cell.detailTextLabel.text = beaconToConfig.measuredPowerStringToWrite;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(row == 4){
        cell.textLabel.text = @"txPower";
        cell.detailTextLabel.text = beaconToConfig.txPowerStringToWrite;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(row == 5){
        cell.textLabel.text = @"interval";
        cell.detailTextLabel.text = beaconToConfig.intervalStringToWrite;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(row == 6){
        cell.textLabel.text = @"防窜改模式";
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 110, 30)];
        [cell addSubview:textField];
        textField.placeholder = @"输入您的密钥";
        keyTextField = textField;
        
        UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 70, 0, 60, 35)];
        sw.center = CGPointMake(sw.center.x, cell.center.y);
        [sw addTarget:self action:@selector(swValueChange:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:sw];
        
        sw.on = beaconToConfig.isLockedToWrite;
    }
    else if(row == 7){
        cell.textLabel.text = @"Led";
        
        UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 70, 0, 60, 35)];
        sw.center = CGPointMake(sw.center.x, cell.center.y);
        [sw addTarget:self action:@selector(ledswValueChange:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:sw];
        
        sw.on = beaconToConfig.isLedOnToWrite;
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [keyTextField resignFirstResponder];
    
    NSString *title = @"";
    NSString *text = @"";
    NSInteger row = indexPath.row;
    
    
    if(row == 6){
        return;
    }
    
    if(row == 0){ // uuid
        title = @"uuid";
        text = beaconToConfig.uuidStringToWrite;
    }
    else if(row == 1){ // major
        title = @"major";
        text = beaconToConfig.majorStringToWrite;
    }
    else if(row == 2){ // minor
        title = @"minor";
        text = beaconToConfig.minorStringToWrite;
    }
    else if(row == 3){ // measuredPower
        title = @"measuredPower";
        text = beaconToConfig.measuredPowerStringToWrite;
    }
    else if(row == 4){ // txPower
        title = @"txPower";
        text = beaconToConfig.txPowerStringToWrite;
    }
    else if(row == 5){ // interval
        title = @"interval";
        text = beaconToConfig.intervalStringToWrite;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"完成" otherButtonTitles: nil];
    alert.tag = row;
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert textFieldAtIndex:0].text = text;
    [alert show];
}

#pragma mark - uialertviewdelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSInteger row = alertView.tag;
    NSString *text = [alertView textFieldAtIndex:0].text;
    if(row == 0){ // uuid
        beaconToConfig.uuidStringToWrite = text;
    }
    else if(row == 1){ // major
        beaconToConfig.majorStringToWrite = text;
    }
    else if(row == 2){ // minor
        beaconToConfig.minorStringToWrite = text;
    }
    else if(row == 3){ // measuredPower
        beaconToConfig.measuredPowerStringToWrite = text;
    }
    else if(row == 4){ // txPower
        beaconToConfig.txPowerStringToWrite = text;
    }
    else if(row == 5){ // interval
        beaconToConfig.intervalStringToWrite = text;
    }
    
    [self.myTableView reloadData];
}


- (void)savePress{
    [keyTextField resignFirstResponder];
    beaconToConfig.lockedKeyToWrite = keyTextField.text;
    [[SKYBeaconManager sharedDefaults] writeSingleIDBeaconValues:beaconToConfig completion:^(NSError *error) {
        
        if(error != nil){
            NSLog(@"%@",error.userInfo[@"error"]);
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:error.userInfo[@"error"] message:nil delegate:nil cancelButtonTitle:@"Okey" otherButtonTitles: nil];
            [alert show];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"config successed" message:nil delegate:nil cancelButtonTitle:@"Okey" otherButtonTitles: nil];
            [alert show];
        }
    }];
}

@end
