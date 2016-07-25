//
//  MutipleIDBeaconConfiglViewController.m
//  SeekcyIBeaconConfig
//
//  Created by seekcy on 15/7/22.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "MutipleIDBeaconConfiglViewController.h"
#import "CellUseOfViewController.h"
#import "TextEnterViewController.h"
#import "MMMaterialDesignSpinner.h"
#import "SICUUIDChooseViewController.h"
#import "TxPowerChooseViewController.h"
#import "SVProgressHUD.h"
#import "UpdateFrequencyViewController.h"
#import "DarkThresholdChooseViewController.h"
#import "DarkBroadcastFrequencyViewController.h"
@import SeekcyBeaconSDK;

@interface MutipleIDBeaconConfiglViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,SKYBeaconManagerConfigurationDelegate,TextEnterViewControllerDelegate>{
    MMMaterialDesignSpinner *activityView;
    SKYBeaconConfigMutipleID *beaconToConfig;
    UITextField *keyTextField;
    UITextField *resetConfigKeyTextField;
    enum SKYBeaconVersion myBeaconType;
}

@property (strong, nonatomic) UISwitch *lightSensationSwitch;

@end

@implementation MutipleIDBeaconConfiglViewController


- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if(self){
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *navbackItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(navbackPress)];
    self.navigationItem.leftBarButtonItem = navbackItem;
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(savePress)];
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithTitle:@"一键清除" style:UIBarButtonItemStyleDone target:self action:@selector(clearPress)];
    self.navigationItem.rightBarButtonItems = @[saveItem,clearItem];
    
    MMMaterialDesignSpinner *spinnerView = [[MMMaterialDesignSpinner alloc] initWithFrame:CGRectZero];
    activityView = spinnerView;
    activityView.frame = CGRectMake(10, (60 - 42)/2, 42, 42);
    activityView.center = self.view.center;
    activityView.tintColor = kMainNavColor;
    activityView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.navigationController.view addSubview:activityView];
    
    self.tableView.alpha = 0.0f;
    self.tableView.hidden = YES;
    
    
    myBeaconType = [[SKYBeaconManager sharedDefaults] getBeaconTypeWithhardwareVersion:self.detailBeacon.hardwareVersion firmwareVersionMajor:self.detailBeacon.firmwareVersionMajor firmwareVersionMinor:self.detailBeacon.firmwareVersionMinor];
    
    [activityView startAnimating];
    
    [[SKYBeaconManager sharedDefaults] connectMutipleIDBeacon:self.detailBeacon delegate:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    [self.tableView reloadData];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}

- (void)navbackPress{
    
    if(![[SKYBeaconManager sharedDefaults] isConnect]){
        [self clearAndNavBack];
    }
    else{
        __weak MutipleIDBeaconConfiglViewController *blockSelf = self;
        [[SKYBeaconManager sharedDefaults] cancelBeaconConnection:self.detailBeacon completion:^(BOOL complete, NSError *error) {
            
            if(complete){
                // 取消连接成功
                [blockSelf performSelector:@selector(clearAndNavBack) withObject:nil afterDelay:2.0f];
            }
            else{
                // 取消连接失败
                NSLog(@"-- 取消连接失败 --");
            }
        }];
    }
}

- (void)clearAndNavBack{
    [activityView stopAnimating];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc{
    NSLog(@"----------- MutipleIDDetailViewController dealloc ------------");
}

- (void)savePress{
    beaconToConfig.lockedKeyToWrite = @"123456"; // 这里配置你的lockKey
    
    [[SKYBeaconManager sharedDefaults] writeMutipleIDBeaconValues:beaconToConfig completion:^(NSError *error) {
        
        if(error != nil){
            NSLog(@"%@",error.userInfo[@"error"]);
            
            if(error.code != SKYBeaconSDKErrorNoneToWrite){
                [SVProgressHUD showInfoWithStatus:error.userInfo[@"error"] maskType:SVProgressHUDMaskTypeBlack];
            }
        }
        else{
            NSLog(@"config success");
            UIAlertView *alertSuccess = [[UIAlertView alloc] initWithTitle:@"配置成功" message:nil delegate:nil cancelButtonTitle:@"Okey" otherButtonTitles: nil];
            [alertSuccess show];
        }
    }];
}

- (void)clearPress{
    beaconToConfig.isLockedToWrite = beaconToConfig.beaconModel.isLocked;
    beaconToConfig.lockedKeyToWrite = @"";
    beaconToConfig.intervalToWrite = @"";
    beaconToConfig.deviceName = @"";
    beaconToConfig.configState = beaconConfigStateMutipleID_wating;
    
    beaconToConfig.beaconConfigID1ToWrite.uuid = @"";
    beaconToConfig.beaconConfigID1ToWrite.major = @"";
    beaconToConfig.beaconConfigID1ToWrite.minor = @"";
    beaconToConfig.beaconConfigID1ToWrite.txPower = SKYBeaconConfigTxPowerValue_0;
    beaconToConfig.beaconConfigID1ToWrite.measuredPower = @"";
    beaconToConfig.beaconConfigID1ToWrite.IsEncrypted = SKYBeaconEncryptedConfigTypeNotConfig;
    
    beaconToConfig.beaconConfigID2ToWrite.uuid = @"";
    beaconToConfig.beaconConfigID2ToWrite.major = @"";
    beaconToConfig.beaconConfigID2ToWrite.minor = @"";
    beaconToConfig.beaconConfigID2ToWrite.txPower = SKYBeaconConfigTxPowerValue_0;
    beaconToConfig.beaconConfigID2ToWrite.measuredPower = @"";
    beaconToConfig.beaconConfigID2ToWrite.IsEncrypted = SKYBeaconEncryptedConfigTypeNotConfig;
    
    beaconToConfig.beaconConfigID3ToWrite.uuid = @"";
    beaconToConfig.beaconConfigID3ToWrite.major = @"";
    beaconToConfig.beaconConfigID3ToWrite.minor = @"";
    beaconToConfig.beaconConfigID3ToWrite.txPower = SKYBeaconConfigTxPowerValue_0;
    beaconToConfig.beaconConfigID3ToWrite.measuredPower = @"";
    beaconToConfig.beaconConfigID3ToWrite.IsEncrypted = SKYBeaconEncryptedConfigTypeNotConfig;
    
    beaconToConfig.isConfigTime = NO;
    beaconToConfig.isFactoryReset = NO;
    beaconToConfig.lockedKeyToWrite = @"";
    beaconToConfig.resetConfigKeyToWrite = @"";
    
    beaconToConfig.cellUseOfToWrite = [[NSMutableArray alloc] initWithObjects:[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null], nil];
    
    [self.tableView reloadData];
}

#pragma mark - SKYBeaconManagerConfigurationDelegate
- (void)skyBeaconManagerConnectResultMutipleIDBeacon:(SKYBeaconMutipleID *)beacon error:(NSError *)error{
    
    if(error == nil){
        [activityView stopAnimating];
        beaconToConfig = [[SKYBeaconConfigMutipleID alloc] initWithBeacon:beacon];
        
        // 连接成功
        __weak UITableView *tableview_weak = self.tableView;
        [UIView animateWithDuration:0.3f animations:^{
            tableview_weak.alpha = 1.0f;
            tableview_weak.hidden = NO;
        }];
        [self.tableView reloadData];
    }
    else{
        NSLog(@"连接失败");
    }
}

- (void)skyBeaconManagerConnectResultSingleIDBeacon:(SKYBeacon *)beacon error:(NSError *)error{
}

- (void)skyBeaconManagerDisconnectSingleIDBeaconError:(NSError *)error{
    
}

- (void)skyBeaconManagerDisconnectMutipleIDBeaconError:(NSError *)error{

}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if(myBeaconType == SKYBeaconVersion_0_2_0_S0 ){
        return 4;
    }
    else if (myBeaconType == SKYBeaconVersion_0_2_1_S0){
        return 4;
    }
    else if (myBeaconType == SKYBeaconVersion_5_2_0_S1L){
        return 4;
    }
    else if (myBeaconType == SKYBeaconVersion_6_2_0_K1L){
        return 4;
    }
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if(myBeaconType == SKYBeaconVersion_0_2_0_S0 ){
        
        if(section == 0){
            return @"ID1";
        }
        else if(section == 1){
            return @"ID2";
        }
        else if(section == 2){
            return @"ID3";
        }
        else if(section == 3){
            return @"其他";
        }
    }
    else if (myBeaconType == SKYBeaconVersion_0_2_1_S0){
        
        if(section == 0){
            return @"ID1";
        }
        else if(section == 1){
            return @"ID2";
        }
        else if(section == 2){
            return @"ID3";
        }
        else if(section == 3){
            return @"其他";
        }
    }
    else if (myBeaconType == SKYBeaconVersion_5_2_0_S1L){
        
        if(section == 0){
            return @"ID1";
        }
        else if(section == 1){
            return @"ID2";
        }
        else if(section == 2){
            return @"ID3";
        }
        else if(section == 3){
            return @"其他";
        }
//        else if(section == 4){
//            return @"光感";
//        }
    }
    else if (myBeaconType == SKYBeaconVersion_6_2_0_K1L){
        
        if(section == 0){
            return @"ID1";
        }
        else if(section == 1){
            return @"ID2";
        }
        else if(section == 2){
            return @"ID3";
        }
        else if(section == 3){
            return @"其他";
        }
//        else if(section == 4){
//            return @"光感";
//        }
    }
    
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if(myBeaconType == SKYBeaconVersion_0_2_0_S0 ){
        
        if(section == 0 || section == 1 || section == 2){
            
            return 6;
        }
        else{
            return 5;
        }
    }
    else if (myBeaconType == SKYBeaconVersion_0_2_1_S0){
        
        if(section == 0 || section == 1 || section == 2){
            
            return 6;
        }
        else if(section == 3){
            return 5;
        }
    }
    else if (myBeaconType == SKYBeaconVersion_5_2_0_S1L){
        
        if(section == 0 || section == 1 || section == 2){
            
            return 6;
        }
        else if(section == 3){
            return 5;
        }
//        else if(section == 4){
//            
//            if(beaconToConfig.lightSensationToWrite.isOn){
//                return 4;
//            }
//            else{
//                return 2;
//            }
//        }
    }
    else if (myBeaconType == SKYBeaconVersion_6_2_0_K1L){
        
        if(section == 0 || section == 1 || section == 2){
            
            return 6;
        }
        else if(section == 3){
            return 5;
        }
//        else if(section == 4){
//            
//            if(beaconToConfig.lightSensationToWrite.isOn){
//                return 4;
//            }
//            else{
//                return 2;
//            }
//        }
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2){
        
        if(indexPath.row == 0){
            return 88;
        }
    }
    
    return 44;
}

#pragma mark - 适配各个版本的cell
- (UITableViewCell *)drawBasicSection:(NSInteger)section row:(NSInteger)row cell:(UITableViewCell *)cell{

    if(section == 0 || section == 1 || section == 2){
        
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        
        SKYBeaconMutipleIDCharacteristicInfo *info;
        
        if(section == 0){
            info = beaconToConfig.beaconConfigID1ToWrite;
        }
        else if(section == 1){
            info = beaconToConfig.beaconConfigID2ToWrite;
        }
        else if(section == 2){
            info = beaconToConfig.beaconConfigID3ToWrite;
        }
        
        if(row == 0){
            cell.textLabel.text = @"uuid";
            cell.detailTextLabel.text = info.uuid;
            cell.detailTextLabel.numberOfLines = 3;
            cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (row == 1){
            cell.textLabel.text = @"major";
            cell.detailTextLabel.text = info.major;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (row == 2){
            cell.textLabel.text = @"minor";
            cell.detailTextLabel.text = info.minor;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (row == 3){
            cell.textLabel.text = @"measuredPower";
            cell.detailTextLabel.text = info.measuredPower;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (row == 4){
            cell.textLabel.text = @"txPower";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d dBm",info.txPower];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (row == 5){
            cell.textLabel.text = @"防蹭用";
            
            UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"不配置",@"开",@"关"]];
            segmentedControl.frame = CGRectMake(self.tableView.frame.size.width - 210, 0, 200, 35);
            segmentedControl.center = CGPointMake(segmentedControl.center.x, cell.center.y);
            [segmentedControl addTarget:self action:@selector(isEncryptedswValueChange:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:segmentedControl];
            
            if(info.IsEncrypted == SKYBeaconEncryptedConfigTypeNotConfig){
                segmentedControl.selectedSegmentIndex = 0;
            }
            else if (info.IsEncrypted == SKYBeaconEncryptedConfigTypeOn){
                segmentedControl.selectedSegmentIndex = 1;
            }
            else if (info.IsEncrypted == SKYBeaconEncryptedConfigTypeOff){
                segmentedControl.selectedSegmentIndex = 2;
            }
        }
    }
    else{
        
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if(row == 0){
            cell.textLabel.text = @"广播ID顺序";
            NSMutableString *str = [NSMutableString stringWithString:@""];
            for(int i = 0; i < beaconToConfig.cellUseOfToWrite.count - 1 ; i++){
                [str appendString:[NSString stringWithFormat:@"%@",beaconToConfig.cellUseOfToWrite[i+1]]];
                [str appendString:@"-"];
            }
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[str substringToIndex:str.length-1]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(row == 1){
            cell.textLabel.text = @"发送间隔(10ms)";
            cell.detailTextLabel.text = beaconToConfig.intervalToWrite;
        }
        else if(row == 2){
            cell.textLabel.text = @"设备名称";
            cell.detailTextLabel.text = beaconToConfig.deviceName;
        }
        else if(row == 3){
            cell.textLabel.text = @"配置时间";
            
            UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 70, 0, 60, 35)];
            sw.center = CGPointMake(sw.center.x, cell.center.y);
            [sw addTarget:self action:@selector(configTimeswValueChange:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:sw];
        }
        else if(row == 4){
            cell.textLabel.text = @"恢复出厂设置";
            
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(125, 8, 110, 30)];
            [cell addSubview:textField];
            textField.delegate = self;
            textField.placeholder = @"输入您的密钥";
            resetConfigKeyTextField = textField;
            
            UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 70, 0, 60, 35)];
            sw.center = CGPointMake(sw.center.x, cell.center.y);
            [sw addTarget:self action:@selector(factoryResetswValueChange:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:sw];
        }
    }
    
    
    return cell;
}


- (UITableViewCell *)drawBasic_lightSensation_Section:(NSInteger)section row:(NSInteger)row cell:(UITableViewCell *)cell{
    
    if(section == 0 || section == 1 || section == 2){
        
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        
        SKYBeaconMutipleIDCharacteristicInfo *info;
        
        if(section == 0){
            info = beaconToConfig.beaconConfigID1ToWrite;
        }
        else if(section == 1){
            info = beaconToConfig.beaconConfigID2ToWrite;
        }
        else if(section == 2){
            info = beaconToConfig.beaconConfigID3ToWrite;
        }
        
        if(row == 0){
            cell.textLabel.text = @"uuid";
            cell.detailTextLabel.text = info.uuid;
            cell.detailTextLabel.numberOfLines = 3;
            cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (row == 1){
            cell.textLabel.text = @"major";
            cell.detailTextLabel.text = info.major;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (row == 2){
            cell.textLabel.text = @"minor";
            cell.detailTextLabel.text = info.minor;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (row == 3){
            cell.textLabel.text = @"measuredPower";
            cell.detailTextLabel.text = info.measuredPower;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (row == 4){
            cell.textLabel.text = @"txPower";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d dBm",info.txPower];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (row == 5){
            cell.textLabel.text = @"防蹭用";
            
            UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"不配置",@"开",@"关"]];
            segmentedControl.frame = CGRectMake(self.tableView.frame.size.width - 210, 0, 200, 35);
            segmentedControl.center = CGPointMake(segmentedControl.center.x, cell.center.y);
            [segmentedControl addTarget:self action:@selector(isEncryptedswValueChange:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:segmentedControl];
            
            if(info.IsEncrypted == SKYBeaconEncryptedConfigTypeNotConfig){
                segmentedControl.selectedSegmentIndex = 0;
            }
            else if (info.IsEncrypted == SKYBeaconEncryptedConfigTypeOn){
                segmentedControl.selectedSegmentIndex = 1;
            }
            else if (info.IsEncrypted == SKYBeaconEncryptedConfigTypeOff){
                segmentedControl.selectedSegmentIndex = 2;
            }
        }
    }
    else if(section == 3){
        
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if(row == 0){
            cell.textLabel.text = @"广播ID顺序";
            NSMutableString *str = [NSMutableString stringWithString:@""];
            for(int i = 0; i < beaconToConfig.cellUseOfToWrite.count - 1 ; i++){
                [str appendString:[NSString stringWithFormat:@"%@",beaconToConfig.cellUseOfToWrite[i+1]]];
                [str appendString:@"-"];
            }
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[str substringToIndex:str.length-1]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(row == 1){
            cell.textLabel.text = @"发送间隔(10ms)";
            cell.detailTextLabel.text = beaconToConfig.intervalToWrite;
        }
        else if(row == 2){
            cell.textLabel.text = @"设备名称";
            cell.detailTextLabel.text = beaconToConfig.deviceName;
        }
        else if(row == 3){
            cell.textLabel.text = @"配置时间";
            
            UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 70, 0, 60, 35)];
            sw.center = CGPointMake(sw.center.x, cell.center.y);
            [sw addTarget:self action:@selector(configTimeswValueChange:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:sw];
        }
        else if(row == 4){
            cell.textLabel.text = @"恢复出厂设置";
            
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(125, 8, 110, 30)];
            [cell addSubview:textField];
            textField.delegate = self;
            textField.placeholder = @"输入您的密钥";
            resetConfigKeyTextField = textField;
            
            UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 70, 0, 60, 35)];
            sw.center = CGPointMake(sw.center.x, cell.center.y);
            [sw addTarget:self action:@selector(factoryResetswValueChange:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:sw];
        }
    }
    else if(section == 4){
        
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if(row == 0){
            cell.textLabel.text = @"光感开关";
            
            UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 60, 5, 50, 35)];
            [sw addTarget:self action:@selector(lightSensationisOnChange) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:sw];
            sw.on = beaconToConfig.lightSensationToWrite.isOn;
            _lightSensationSwitch = sw;
        }
        else if(row == 1){
            cell.textLabel.text = @"光感值更新频率";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ s",beaconToConfig.lightSensationToWrite.updateFrequency];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(row == 2){
            cell.textLabel.text = @"黑暗阈值";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"档位%@",beaconToConfig.lightSensationToWrite.darkThreshold];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(row == 3){
            cell.textLabel.text = @"黑暗广播频率";
            
            if([beaconToConfig.lightSensationToWrite.darkBroadcastFrequency isEqualToString:@"0"]){
                cell.detailTextLabel.text = @"关闭";
            }
            else{
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d ms",[beaconToConfig.lightSensationToWrite.darkBroadcastFrequency intValue]*50];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    
    return cell;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if(myBeaconType == SKYBeaconVersion_0_2_0_S0 ){
        cell = [self drawBasicSection:section row:row cell:cell];
    }
    else if (myBeaconType == SKYBeaconVersion_0_2_1_S0){
        cell = [self drawBasic_lightSensation_Section:section row:row cell:cell];
    }
    else if (myBeaconType == SKYBeaconVersion_5_2_0_S1L){
        cell = [self drawBasicSection:section row:row cell:cell];
    }
    else if (myBeaconType == SKYBeaconVersion_6_2_0_K1L){
        cell = [self drawBasicSection:section row:row cell:cell];
    }
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [resetConfigKeyTextField resignFirstResponder];
    [keyTextField resignFirstResponder];
    
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if(section == 0 || section == 1 || section == 2){
        
        SKYBeaconMutipleIDCharacteristicInfo *info ;
        
        if(section == 0){
            info = beaconToConfig.beaconConfigID1ToWrite;
        }
        else if(section == 1){
            info = beaconToConfig.beaconConfigID2ToWrite;
        }
        else if(section == 2){
            info = beaconToConfig.beaconConfigID3ToWrite;
        }
        
        int tag = 0;
        NSString *titile = @"";
        NSString *text = @"";
        if(section == 0){
            
            if(row == 0){
                tag = 1001;
                titile = @"ID1 uuid";
                text = info.uuid;
            }
            else if(row == 1){
                tag = 1002;
                titile = @"ID1 major";
                text = info.major;
            }
            else if(row == 2){
                tag = 1003;
                titile = @"ID1 minor";
                text = info.minor;
            }
            else if(row == 3){
                tag = 1004;
                titile = @"ID1 measuredPower";
                text = info.measuredPower;
            }
            else if(row == 4){
                tag = 1005;
                titile = @"ID1 txPower";
                text = [NSString stringWithFormat:@"%d",info.txPower];
            }
        }
        else if(section == 1){
            
            if(row == 0){
                tag = 2001;
                titile = @"ID2 uuid";
                text = info.uuid;
            }
            else if(row == 1){
                tag = 2002;
                titile = @"ID2 major";
                text = info.major;
            }
            else if(row == 2){
                tag = 2003;
                titile = @"ID2 minor";
                text = info.minor;
            }
            else if(row == 3){
                tag = 2004;
                titile = @"ID2 measuredPower";
                text = info.measuredPower;
            }
            else if(row == 4){
                tag = 2005;
                titile = @"ID2 txPower";
                text = [NSString stringWithFormat:@"%d",info.txPower];
            }
        }
        else if(section == 2){
            
            if(row == 0){
                tag = 3001;
                titile = @"ID3 uuid";
                text = info.uuid;
            }
            else if(row == 1){
                tag = 3002;
                titile = @"ID3 major";
                text = info.major;
            }
            else if(row == 2){
                tag = 3003;
                titile = @"ID3 minor";
                text = info.minor;
            }
            else if(row == 3){
                tag = 3004;
                titile = @"ID3 measuredPower";
                text = info.measuredPower;
            }
            else if(row == 4){
                tag = 3005;
                titile = @"ID3 txPower";
                text = [NSString stringWithFormat:@"%d",info.txPower];
            }
        }
        
        
        if(row == 0){
            
            SICUUIDChooseViewController *vc = [[SICUUIDChooseViewController alloc] init];
            vc.selectedUUIDString = info.uuid;
            [self.navigationController pushViewController:vc animated:YES];
            
            __weak UITableView *weak_tableview = self.tableView;
            __block SKYBeaconMutipleIDCharacteristicInfo *weakInfo = info;
            [vc chooseUUIDBlock:^(NSString *uuidString) {
                weakInfo.uuid = uuidString;
                [weak_tableview reloadData];
            }];
        }
        else if (row == 1){
            
            TextEnterViewController *vc = [[TextEnterViewController alloc] init];
            vc.placeHolderString = text;
            vc.textString = text;
            vc.tag = tag;
            vc.delegate = self;
            vc.navigationItem.title = titile;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (row == 2){
            
            TextEnterViewController *vc = [[TextEnterViewController alloc] init];
            vc.placeHolderString = text;
            vc.textString = text;
            vc.tag = tag;
            vc.delegate = self;
            vc.navigationItem.title = titile;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (row == 3){ // measured power
            
            TextEnterViewController *vc = [[TextEnterViewController alloc] init];
            vc.placeHolderString = text;
            vc.textString = text;
            vc.tag = tag;
            vc.delegate = self;
            vc.navigationItem.title = titile;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (row == 4){ // txpower
            TxPowerChooseViewController *vc = [[TxPowerChooseViewController alloc] init];
            vc.beaconHardwareVersion = beaconToConfig.beaconModel.hardwareVersion;
            vc.beaconFirmwareVersionMajor = beaconToConfig.beaconModel.firmwareVersionMajor;
            vc.beaconFirmwareVersionMinor = beaconToConfig.beaconModel.firmwareVersionMinor;
            [self.navigationController pushViewController:vc animated:YES];
            
            __weak UITableView *weak_tableview = self.tableView;
            __block SKYBeaconMutipleIDCharacteristicInfo *weakInfo = info;
            [vc chooseTxPowerBlock:^(NSString *txPowerString) {
                weakInfo.txPower = [txPowerString intValue];
                [weak_tableview reloadData];
            }];
        }
    }
    else if(section == 3){
        
        if(row == 0){
            CellUseOfViewController *vc = [[CellUseOfViewController alloc] init];
            vc.configBeacon = beaconToConfig;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (row == 1){
            TextEnterViewController *vc = [[TextEnterViewController alloc] init];
            vc.placeHolderString = beaconToConfig.intervalToWrite;
            vc.textString = beaconToConfig.intervalToWrite;
            vc.tag = 4001;
            vc.delegate = self;
            vc.navigationItem.title = @"发送间隔";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if (row == 2){
            TextEnterViewController *vc = [[TextEnterViewController alloc] init];
            vc.placeHolderString = beaconToConfig.deviceName;
            vc.textString = beaconToConfig.deviceName;
            vc.tag = 4002;
            vc.delegate = self;
            vc.navigationItem.title = @"设备名称";
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    else if(section == 4){
        
        if(row == 1){
            UpdateFrequencyViewController *vc = [[UpdateFrequencyViewController alloc] init];
            vc.selectedValue = beaconToConfig.lightSensationToWrite.updateFrequency;
            [self.navigationController pushViewController:vc animated:YES];
            
            __weak UITableView *weak_tableview = self.tableView;
            __block SKYBeaconConfigMutipleID *weak_beacon = beaconToConfig;
            [vc chooseValueBlock:^(NSString *valueString) {
                weak_beacon.lightSensationToWrite.updateFrequency = valueString;
                [weak_tableview reloadData];
            }];
        }
        else if(row == 2){
            DarkThresholdChooseViewController *vc = [[DarkThresholdChooseViewController alloc] init];
            vc.selectedValue = beaconToConfig.lightSensationToWrite.darkThreshold;
            [self.navigationController pushViewController:vc animated:YES];
            
            __weak UITableView *weak_tableview = self.tableView;
            __block SKYBeaconConfigMutipleID *weak_beacon = beaconToConfig;
            [vc chooseDarkThresholdBlock:^(NSString *darkThresholdString) {
                weak_beacon.lightSensationToWrite.darkThreshold = darkThresholdString;
                [weak_tableview reloadData];
            }];
        }
        else if (row == 3){
            DarkBroadcastFrequencyViewController *vc = [[DarkBroadcastFrequencyViewController alloc] init];
            vc.selectedValue = beaconToConfig.lightSensationToWrite.darkBroadcastFrequency;
            [self.navigationController pushViewController:vc animated:YES];
            
            __weak UITableView *weak_tableview = self.tableView;
            __block SKYBeaconConfigMutipleID *weak_beacon = beaconToConfig;
            [vc chooseValueBlock:^(NSString *valueString) {
                weak_beacon.lightSensationToWrite.darkBroadcastFrequency = valueString;
                [weak_tableview reloadData];
            }];
        }
    }
    
    [tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section] animated:YES];
}

- (void)lightSensationisOnChange{
    beaconToConfig.lightSensationToWrite.isOn = _lightSensationSwitch.isOn;
    
    if(_lightSensationSwitch.isOn){
        
    }
    else{
        beaconToConfig.lightSensationToWrite.darkThreshold = beaconToConfig.beaconModel.lightSensation.darkThreshold;
        beaconToConfig.lightSensationToWrite.darkBroadcastFrequency = beaconToConfig.beaconModel.lightSensation.darkBroadcastFrequency;
    }
    
    [self performSelector:@selector(tableViewReloadData) withObject:nil afterDelay:0.2];
}

- (void)tableViewReloadData{
    [self.tableView reloadData];
}



- (void)isEncryptedswValueChange:(UISegmentedControl *)senderSwitch{
    
    SKYBeaconMutipleIDCharacteristicInfo *info;
    
    if(senderSwitch.tag == 0){
        info = beaconToConfig.beaconConfigID1ToWrite;
    }
    else if(senderSwitch.tag == 1){
        info = beaconToConfig.beaconConfigID2ToWrite;
    }
    else if(senderSwitch.tag == 2){
        info = beaconToConfig.beaconConfigID3ToWrite;
    }
    
    if(senderSwitch.selectedSegmentIndex == 0){
        info.IsEncrypted = SKYBeaconEncryptedConfigTypeNotConfig;
    }
    else if(senderSwitch.selectedSegmentIndex == 1){
        info.IsEncrypted = SKYBeaconEncryptedConfigTypeOn;
    }
    else if(senderSwitch.selectedSegmentIndex == 2){
        info.IsEncrypted = SKYBeaconEncryptedConfigTypeOff;
    }
}

- (void)lockKeyswValueChange:(UISwitch *)senderSwitch{
    beaconToConfig.isLockedToWrite = senderSwitch.isOn;
}

- (void)configTimeswValueChange:(UISwitch *)senderSwitch{
    beaconToConfig.isConfigTime = senderSwitch.isOn;
}

- (void)factoryResetswValueChange:(UISwitch *)senderSwitch{
    beaconToConfig.isFactoryReset = senderSwitch.isOn;
    
    if(senderSwitch.isOn){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认恢复出厂设置?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert.tag = 9999;
        [alert show];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    beaconToConfig.lockedKeyToWrite = keyTextField.text;
    beaconToConfig.resetConfigKeyToWrite = resetConfigKeyTextField.text;
    [textField resignFirstResponder];
    return YES;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    // 恢复出厂设置
    if(alertView.tag == 9999){
        [[SKYBeaconManager sharedDefaults] factoryResetMutipleIDBeaconValues:beaconToConfig completion:^(NSError *error) {
            
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
}


- (void)textEnterCompleteWithTextString:(NSString *)textString controllerTag:(NSInteger)controllerTag{
    NSString *text = textString;
    
    if (controllerTag == 1001){
        beaconToConfig.beaconConfigID1ToWrite.uuid = text;
    }
    else if (controllerTag == 1002){
        beaconToConfig.beaconConfigID1ToWrite.major = text;
    }
    else if (controllerTag == 1003){
        beaconToConfig.beaconConfigID1ToWrite.minor = text;
    }
    else if (controllerTag == 1004){
        beaconToConfig.beaconConfigID1ToWrite.measuredPower = text;
    }
    else if (controllerTag == 1005){
        beaconToConfig.beaconConfigID1ToWrite.txPower = [text intValue];
    }
    // id2
    else if (controllerTag == 2001){
        beaconToConfig.beaconConfigID2ToWrite.uuid = text;
    }
    else if (controllerTag == 2002){
        beaconToConfig.beaconConfigID2ToWrite.major = text;
    }
    else if (controllerTag == 2003){
        beaconToConfig.beaconConfigID2ToWrite.minor = text;
    }
    else if (controllerTag == 2004){
        beaconToConfig.beaconConfigID2ToWrite.measuredPower = text;
    }
    else if (controllerTag == 2005){
        beaconToConfig.beaconConfigID2ToWrite.txPower = [text intValue];
    }
    // id3
    else if (controllerTag == 3001){
        beaconToConfig.beaconConfigID3ToWrite.uuid = text;
    }
    else if (controllerTag == 3002){
        beaconToConfig.beaconConfigID3ToWrite.major = text;
    }
    else if (controllerTag == 3003){
        beaconToConfig.beaconConfigID3ToWrite.minor = text;
    }
    else if (controllerTag == 3004){
        beaconToConfig.beaconConfigID3ToWrite.measuredPower = text;
    }
    else if (controllerTag == 3005){
        beaconToConfig.beaconConfigID3ToWrite.txPower = [text intValue];
    }
    // 发送间隔
    else if (controllerTag == 4001){
        beaconToConfig.intervalToWrite = text;
    }
    // 设备名称
    else if (controllerTag == 4002){
        beaconToConfig.deviceName = text;
    }
    
    [self.tableView reloadData];
}



@end
