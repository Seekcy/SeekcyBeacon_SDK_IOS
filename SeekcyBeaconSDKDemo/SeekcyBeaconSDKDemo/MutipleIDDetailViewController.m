//
//  MutipleIDDetailViewController.m
//  SeekcyBeaconSDKDemo
//
//  Created by seekcy on 15/6/29.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "MutipleIDDetailViewController.h"
#import "CellUseOfViewController.h"
@import SeekcyBeaconSDK;

@interface MutipleIDDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>{
    UIActivityIndicatorView *activityView;
    SKYBeaconConfigMutipleID *beaconToConfig;
    UITextField *keyTextField;
    UITextField *resetConfigKeyTextField;
}

@end

@implementation MutipleIDDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"多id详情";
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    
    UIBarButtonItem *navbackItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(navbackPress)];
    self.navigationItem.leftBarButtonItem = navbackItem;
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(savePress)];
    self.navigationItem.rightBarButtonItem = saveItem;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.center = self.view.center;
    [self.navigationController.view addSubview:activityView];
    
    self.tableView.alpha = 0.0f;
    self.tableView.hidden = YES;
    
    [activityView startAnimating];
    
    __weak UIActivityIndicatorView *activityView_weak = activityView;
    __weak UITableView *tableview_weak = self.tableView;
    
    beaconToConfig = [[SKYBeaconConfigMutipleID alloc] initWithBeacon:self.detailBeacon];
    
    [[SKYBeaconManager sharedDefaults] connectBeacon:self.detailBeacon completion:^(BOOL complete, NSError *error) {
        [activityView_weak stopAnimating];

        if(complete){
            // 连接成功
            [UIView animateWithDuration:0.3f animations:^{
                tableview_weak.alpha = 1.0f;
                tableview_weak.hidden = NO;
            }];
            [tableview_weak reloadData];
        }
        else{
            // 连接失败
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"连接出错" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    [self.tableView reloadData];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}

- (void)navbackPress{
    
    if([[SKYBeaconManager sharedDefaults] isConnect]){
        
        [self clearAndNavBack];
    }
    else{
        __weak MutipleIDDetailViewController *blockSelf = self;
        [[SKYBeaconManager sharedDefaults] cancelBeaconConnection:self.detailBeacon completion:^(BOOL complete, NSError *error) {
            
            if(complete){
                // 取消连接成功
                [blockSelf performSelector:@selector(clearAndNavBack) withObject:nil afterDelay:0.1f];
            }
            else{
                // 取消连接失败
            }
        }];
    }

}

- (void)clearAndNavBack{
    [activityView removeFromSuperview];
    activityView = nil;
    keyTextField = nil;
    beaconToConfig = nil;
    self.detailBeacon = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc{
    NSLog(@"----------- MutipleIDDetailViewController dealloc ------------");
}

- (void)savePress{
    beaconToConfig.lockedKeyToWrite = keyTextField.text;
    
    [[SKYBeaconManager sharedDefaults] writeMutipleIDBeaconValues:beaconToConfig completion:^(NSError *error) {
        
        if(error != nil){
            NSLog(@"%@",error.userInfo[@"error"]);
        }
        else{
            [self showSuccessAlert];
        }
    }];
}

- (void)showSuccessAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"config successed" message:nil delegate:nil cancelButtonTitle:@"Okey" otherButtonTitles: nil];
    [alert show];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
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
    
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0 || section == 1 || section == 2){
        
        return 6;
    }
    else{
        return 7;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2){
        
        if(indexPath.row == 0){
            return 88;
        }
    }
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
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
            cell.detailTextLabel.text = info.txPower;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (row == 5){
            cell.textLabel.text = @"防蹭用";
            UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 70, 0, 60, 35)];
            [cell addSubview:sw];
            [sw addTarget:self action:@selector(isEncryptedswValueChange:) forControlEvents:UIControlEventValueChanged];
            sw.center = CGPointMake(sw.center.x, cell.center.y);
            sw.tag = section;
            sw.on = info.IsEncrypted;
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
            for(int i = 0; i < beaconToConfig.beaconModel.cellUseOf.count - 1 ; i++){
                [str appendString:[NSString stringWithFormat:@"%@",beaconToConfig.beaconModel.cellUseOf[i+1]]];
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
        else if (row == 3){
            cell.textLabel.text = @"防窜改模式";
            
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 110, 30)];
            [cell addSubview:textField];
            textField.delegate = self;
            textField.placeholder = @"输入您的密钥";
            keyTextField = textField;
            
            UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 70, 0, 60, 35)];
            sw.center = CGPointMake(sw.center.x, cell.center.y);
            [sw addTarget:self action:@selector(lockKeyswValueChange:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:sw];
            
            sw.on = beaconToConfig.isLockedToWrite;
        }
        else if(row == 4){
            cell.textLabel.text = @"配置时间";
            
            UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 70, 0, 60, 35)];
            sw.center = CGPointMake(sw.center.x, cell.center.y);
            [sw addTarget:self action:@selector(configTimeswValueChange:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:sw];
        }
        else if(row == 5){
            cell.textLabel.text = @"恢复出厂设置";
            
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, 110, 30)];
            [cell addSubview:textField];
            textField.delegate = self;
            textField.placeholder = @"输入您的密钥";
            resetConfigKeyTextField = textField;
            
            UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 70, 0, 60, 35)];
            sw.center = CGPointMake(sw.center.x, cell.center.y);
            [sw addTarget:self action:@selector(factoryResetswValueChange:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:sw];
        }
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
                text = info.txPower;
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
                text = info.txPower;
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
                text = info.txPower;
            }
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titile message:nil delegate:self cancelButtonTitle:@"完成" otherButtonTitles: nil];
        alert.tag = tag;
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [alert textFieldAtIndex:0].text = text;
        [alert show];
    }
    else{
        
        if(row == 0){
            CellUseOfViewController *vc = [[CellUseOfViewController alloc] init];
            vc.configBeacon = beaconToConfig;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (row == 1){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发送间隔" message:nil delegate:self cancelButtonTitle:@"完成" otherButtonTitles: nil];
            alert.tag = 4001;
            [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
            [alert textFieldAtIndex:0].text = beaconToConfig.intervalToWrite;
            [alert show];
        }
        else if (row == 2){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设备名称" message:nil delegate:self cancelButtonTitle:@"完成" otherButtonTitles: nil];
            alert.tag = 4002;
            [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
            [alert textFieldAtIndex:0].text = beaconToConfig.deviceName;
            [alert show];
        }
        
    }
}

- (void)isEncryptedswValueChange:(UISwitch *)senderSwitch{
    
    NSString *key = @"";
    if(senderSwitch.tag == 0){
        key = SKYBeaconMutipleIDCharacteristicInfoKeyOne;
    }
    else if(senderSwitch.tag == 1){
        key = SKYBeaconMutipleIDCharacteristicInfoKeyTwo;
    }
    else if(senderSwitch.tag == 2){
        key = SKYBeaconMutipleIDCharacteristicInfoKeyThree;
    }
    SKYBeaconMutipleIDCharacteristicInfo *info = [beaconToConfig.beaconModel.characteristicInfo valueForKey:key];
    
    info.IsEncrypted = senderSwitch.isOn;
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
    NSString *text = [alertView textFieldAtIndex:0].text;
    
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
    // id1
    else if (alertView.tag == 1001){
        beaconToConfig.beaconConfigID1ToWrite.uuid = text;
    }
    else if (alertView.tag == 1002){
        beaconToConfig.beaconConfigID1ToWrite.major = text;
    }
    else if (alertView.tag == 1003){
        beaconToConfig.beaconConfigID1ToWrite.minor = text;
    }
    else if (alertView.tag == 1004){
        beaconToConfig.beaconConfigID1ToWrite.measuredPower = text;
    }
    else if (alertView.tag == 1005){
        beaconToConfig.beaconConfigID1ToWrite.txPower = text;
    }
    // id2
    else if (alertView.tag == 2001){
        beaconToConfig.beaconConfigID2ToWrite.uuid = text;
    }
    else if (alertView.tag == 2002){
        beaconToConfig.beaconConfigID2ToWrite.major = text;
    }
    else if (alertView.tag == 2003){
        beaconToConfig.beaconConfigID2ToWrite.minor = text;
    }
    else if (alertView.tag == 2004){
        beaconToConfig.beaconConfigID2ToWrite.measuredPower = text;
    }
    else if (alertView.tag == 2005){
        beaconToConfig.beaconConfigID2ToWrite.txPower = text;
    }
    // id3
    else if (alertView.tag == 3001){
        beaconToConfig.beaconConfigID3ToWrite.uuid = text;
    }
    else if (alertView.tag == 3002){
        beaconToConfig.beaconConfigID3ToWrite.major = text;
    }
    else if (alertView.tag == 3003){
        beaconToConfig.beaconConfigID3ToWrite.minor = text;
    }
    else if (alertView.tag == 3004){
        beaconToConfig.beaconConfigID3ToWrite.measuredPower = text;
    }
    else if (alertView.tag == 3005){
        beaconToConfig.beaconConfigID3ToWrite.txPower = text;
    }
    // 发送间隔
    else if (alertView.tag == 4001){
        beaconToConfig.intervalToWrite = text;
    }
    // 设备名称
    else if (alertView.tag == 4002){
        beaconToConfig.deviceName = text;
    }
    
    
    [self.tableView reloadData];
}

@end
