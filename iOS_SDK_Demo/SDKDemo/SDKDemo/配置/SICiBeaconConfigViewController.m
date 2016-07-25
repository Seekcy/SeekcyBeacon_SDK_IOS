//
//  SICiBeaconConfigViewController.m
//  SeekcyIBeaconConfig
//
//  Created by metRooooo on 15/4/28.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "SICiBeaconConfigViewController.h"
#import "SICUUIDChooseViewController.h"
#import "TxPowerChooseViewController.h"
#import "IntervalChooseViewController.h"
#import "DarkThresholdChooseViewController.h"
#import "DarkBroadcastFrequencyViewController.h"
#import "UpdateFrequencyViewController.h"
#import "TemperatureUpdateFrequencyChooseViewController.h"
#import "SVProgressHUD.h"
@import SeekcyBeaconSDK;

@interface SICiBeaconConfigViewController ()<SKYBeaconManagerConfigurationDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    BOOL viewShowAfterChooseUUID;
    SKYBeaconConfigSingleID *modelToConfig;
    UIView *inputView;
    BOOL disconnectAfterWrite;
    enum SKYBeaconVersion myBeaconType;
}

@property (strong, nonatomic) UITextField *majorTextField;
@property (strong, nonatomic) UITextField *minorTextField;
@property (strong, nonatomic) UITextField *measurePowerTextField;
@property (strong, nonatomic) UISwitch *lightSensationSwitch;
@property (strong, nonatomic) UISwitch *ledSwitch;


@end

@implementation SICiBeaconConfigViewController

#pragma mark - Life Cycle
- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if(self){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.title = @"配置";
    
    UIButton *navBack = [UIButton buttonWithType:UIButtonTypeCustom];
    navBack.frame = CGRectMake(0, 0, 32, 32);
    [navBack setImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
    [navBack addTarget:self action:@selector(navBackPress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:navBack];
    self.navigationItem.leftBarButtonItem = item;
    
    UIBarButtonItem *itemSave = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(savePress)];
    self.navigationItem.rightBarButtonItem = itemSave;
    
    //
    // 初始化
    inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    inputView.backgroundColor = [UIColor whiteColor];
    
    UIButton *keyboardDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    keyboardDownButton.frame = CGRectMake(inputView.frame.size.width - 80, (44-35)/2, 60, 35);
    keyboardDownButton.layer.cornerRadius = 5;
    keyboardDownButton.backgroundColor = kMainNavColor;
    [keyboardDownButton setTitle:@"完成" forState:UIControlStateNormal];
    [keyboardDownButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [keyboardDownButton addTarget:self action:@selector(keyboardDownButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [inputView addSubview:keyboardDownButton];
    
    
    myBeaconType = [[SKYBeaconManager sharedDefaults] getBeaconTypeWithhardwareVersion:self.detailBeacon.hardwareVersion firmwareVersionMajor:self.detailBeacon.firmwareVersionMajor firmwareVersionMinor:self.detailBeacon.firmwareVersionMinor];
    
    [self connectBeacon];
}


- (void)connectBeacon{
    [[SKYBeaconManager sharedDefaults] connectSingleIDBeacon:self.detailBeacon delegate:self];
    
    //
    // TODO:初始化数据
    modelToConfig = [[SKYBeaconConfigSingleID alloc] initWithBeacon:self.detailBeacon];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}

- (void)dealloc{
    NSLog(@"sicbeaconconfigviewcontroller dealloc");
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}

- (void)navBackPress{
    
    if(![[SKYBeaconManager sharedDefaults] isConnect]){
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        __weak SICiBeaconConfigViewController *weak_Self = self;
        
        [[SKYBeaconManager sharedDefaults] cancelBeaconConnection:self.detailBeacon completion:^(BOOL complete, NSError *error) {
           
            if(complete){
                [weak_Self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}


- (void)keyboardDownButtonPress{
    [_majorTextField resignFirstResponder];
    [_minorTextField resignFirstResponder];
    [_measurePowerTextField resignFirstResponder];
    
    [self saveUIData];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if(myBeaconType == SKYBeaconVersion_0_1_0_S0){
        return 1;
    }
    else if (myBeaconType == SKYBeaconVersion_1_1_0_M0){
        return 1;
    }
    else if(myBeaconType == SKYBeaconVersion_3_1_0_M0L){
        return 3;
    }
    else if (myBeaconType == SKYBeaconVersion_5_1_1_S0L || myBeaconType == SKYBeaconVersion_5_1_0_S0L || myBeaconType ==  SKYBeaconVersion_6_1_0_K1 || myBeaconType == SKYBeaconVersion_7_1_0_Dialog){
        return 3;
    }
    
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    if(myBeaconType == SKYBeaconVersion_0_1_0_S0){
        return @"基本";
    }
    else if(myBeaconType == SKYBeaconVersion_1_1_0_M0){
        return @"基本";
    }
    else if(myBeaconType == SKYBeaconVersion_2_1_0_S0P){
        return @"基本";
    }
    else if(myBeaconType == SKYBeaconVersion_3_1_0_M0L){
        
        if(section == 0){
            return @"基本";
        }
        else if(section == 1){
            return @"光感";
        }
        else if(section == 2){
            return @"温度";
        }
    }
    else if (myBeaconType == SKYBeaconVersion_5_1_1_S0L || myBeaconType == SKYBeaconVersion_5_1_0_S0L || myBeaconType ==  SKYBeaconVersion_6_1_0_K1 || myBeaconType == SKYBeaconVersion_7_1_0_Dialog){
        
        if(section == 0){
            return @"基本";
        }
        else if(section == 1){
            return @"";
        }
        else if(section == 2){
            return @"温度";
        }
    }
    
    
    
    return @"基本";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(myBeaconType == SKYBeaconVersion_0_1_0_S0){
        return 6;
    }
    else if(myBeaconType == SKYBeaconVersion_1_1_0_M0){
        return 7;
    }
    else if(myBeaconType == SKYBeaconVersion_2_1_0_S0P){
        return 6;
    }
    else if(myBeaconType == SKYBeaconVersion_3_1_0_M0L){
        
        if(section == 0){
            return 7;
        }
        else if(section == 1){
            
            if(modelToConfig.lightSensationToWrite.isOn){
                return 4;
            }
            else{
                return 2;
            }
        }
        else if(section == 2){
            return 1;
        }
    }
    else if (myBeaconType == SKYBeaconVersion_5_1_1_S0L || myBeaconType == SKYBeaconVersion_5_1_0_S0L || myBeaconType ==  SKYBeaconVersion_6_1_0_K1 || myBeaconType == SKYBeaconVersion_7_1_0_Dialog){
        
        if(section == 0){
            return 6;
        }
        else if(section == 1){
            return 0;
        }
        else if(section == 2){
            return 1;
        }
    }
    
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        if(indexPath.row == 0){
            return 88;
        }
    }
    
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"myCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    
    if(myBeaconType == SKYBeaconVersion_0_1_0_S0){
        [self drawBasicSection:section row:row cell:cell];
    }
    else if(myBeaconType == SKYBeaconVersion_1_1_0_M0){
        [self drawBasic_LED_Section:section row:row cell:cell];
    }
    else if(myBeaconType == SKYBeaconVersion_2_1_0_S0P){
        [self drawBasicSection:section row:row cell:cell];
    }
    else if(myBeaconType == SKYBeaconVersion_3_1_0_M0L){
        [self drawBasic_LED_temperature_lightSensation_Section:section row:row cell:cell];
    }
    else if (myBeaconType == SKYBeaconVersion_5_1_1_S0L || myBeaconType == SKYBeaconVersion_5_1_0_S0L || myBeaconType ==  SKYBeaconVersion_6_1_0_K1 || myBeaconType == SKYBeaconVersion_7_1_0_Dialog){
        [self drawBasic_temperature_Section:section row:row cell:cell];
    }
    else{
        [self drawBasicSection:section row:row cell:cell];
    }
    
    return cell;
}

#pragma mark - 适配各个版本的cell

- (void)drawBasicSection:(NSInteger)section row:(NSInteger)row cell:(UITableViewCell *)cell{
    
    if(section == 0){
        
        if(row == 0){
            cell.textLabel.text = @"UUID";
            cell.detailTextLabel.text = modelToConfig.uuidStringToWrite;
            cell.detailTextLabel.numberOfLines = 3;
            cell.detailTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(row == 1){
            cell.textLabel.text = @"Major";
            
            _majorTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 130, 2.5, 100, 40)];
            _majorTextField.textAlignment = NSTextAlignmentRight;
            _majorTextField.placeholder = @"major";
            _majorTextField.textColor = [UIColor colorWithRed:114/255.0f green:114/255.0f blue:116/255.0f alpha:1.0f];
            _majorTextField.keyboardType = UIKeyboardTypeNumberPad;
            _majorTextField.text = modelToConfig.majorStringToWrite;
            _majorTextField.inputAccessoryView = inputView;
            [cell addSubview:_majorTextField];
        }
        else if(row == 2){
            cell.textLabel.text = @"Minor";
            
            _minorTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 130, 2.5, 100, 40)];
            _minorTextField.textAlignment = NSTextAlignmentRight;
            _minorTextField.placeholder = @"major";
            _minorTextField.textColor = [UIColor colorWithRed:114/255.0f green:114/255.0f blue:116/255.0f alpha:1.0f];
            _minorTextField.keyboardType = UIKeyboardTypeNumberPad;
            _minorTextField.text = modelToConfig.minorStringToWrite;
            _minorTextField.inputAccessoryView = inputView;
            [cell addSubview:_minorTextField];
        }
        else if(row == 3){
            cell.textLabel.text = @"MeasuredPower";
            
            _measurePowerTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 130, 2.5, 100, 40)];
            _measurePowerTextField.textAlignment = NSTextAlignmentRight;
            _measurePowerTextField.placeholder = @"measuredPower";
            _measurePowerTextField.textColor = [UIColor colorWithRed:114/255.0f green:114/255.0f blue:116/255.0f alpha:1.0f];
            _measurePowerTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            _measurePowerTextField.text = modelToConfig.measuredPowerStringToWrite;
            _measurePowerTextField.inputAccessoryView = inputView;
            [cell addSubview:_measurePowerTextField];
        }
        else if(row == 4){
            cell.textLabel.text = @"TxPower";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d dBm",modelToConfig.txPowerStringToWrite];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(row == 5){
            cell.textLabel.text = @"Interval";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@0 ms",modelToConfig.intervalStringToWrite];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
}


- (void)drawBasic_LED_Section:(NSInteger)section row:(NSInteger)row cell:(UITableViewCell *)cell{
    
    if(section == 0){
        
        if(row == 0){
            cell.textLabel.text = @"UUID";
            cell.detailTextLabel.text = modelToConfig.uuidStringToWrite;
            cell.detailTextLabel.numberOfLines = 3;
            cell.detailTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(row == 1){
            cell.textLabel.text = @"Major";
            
            _majorTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 130, 2.5, 100, 40)];
            _majorTextField.textAlignment = NSTextAlignmentRight;
            _majorTextField.placeholder = @"major";
            _majorTextField.textColor = [UIColor colorWithRed:114/255.0f green:114/255.0f blue:116/255.0f alpha:1.0f];
            _majorTextField.keyboardType = UIKeyboardTypeNumberPad;
            _majorTextField.text = modelToConfig.majorStringToWrite;
            _majorTextField.inputAccessoryView = inputView;
            [cell addSubview:_majorTextField];
        }
        else if(row == 2){
            cell.textLabel.text = @"Minor";
            
            _minorTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 130, 2.5, 100, 40)];
            _minorTextField.textAlignment = NSTextAlignmentRight;
            _minorTextField.placeholder = @"major";
            _minorTextField.textColor = [UIColor colorWithRed:114/255.0f green:114/255.0f blue:116/255.0f alpha:1.0f];
            _minorTextField.keyboardType = UIKeyboardTypeNumberPad;
            _minorTextField.text = modelToConfig.minorStringToWrite;
            _minorTextField.inputAccessoryView = inputView;
            [cell addSubview:_minorTextField];
        }
        else if(row == 3){
            cell.textLabel.text = @"MeasuredPower";
            
            _measurePowerTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 130, 2.5, 100, 40)];
            _measurePowerTextField.textAlignment = NSTextAlignmentRight;
            _measurePowerTextField.placeholder = @"measuredPower";
            _measurePowerTextField.textColor = [UIColor colorWithRed:114/255.0f green:114/255.0f blue:116/255.0f alpha:1.0f];
            _measurePowerTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            _measurePowerTextField.text = modelToConfig.measuredPowerStringToWrite;
            _measurePowerTextField.inputAccessoryView = inputView;
            [cell addSubview:_measurePowerTextField];
        }
        else if(row == 4){
            cell.textLabel.text = @"TxPower";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d dBm",modelToConfig.txPowerStringToWrite];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(row == 5){
            cell.textLabel.text = @"Interval";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@0 ms",modelToConfig.intervalStringToWrite];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(row == 6){
            cell.textLabel.text = @"LED";
            
            UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 60, 5, 50, 35)];
            [sw addTarget:self action:@selector(ledSwitchValueChange) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:sw];
            
            self.ledSwitch = sw;
            self.ledSwitch.on = modelToConfig.isLedOnToWrite;
        }
    }
}


- (void)drawBasic_LED_temperature_lightSensation_Section:(NSInteger)section row:(NSInteger)row cell:(UITableViewCell *)cell{
    
    if(section == 0){
        
        if(row == 0){
            cell.textLabel.text = @"UUID";
            cell.detailTextLabel.text = modelToConfig.uuidStringToWrite;
            cell.detailTextLabel.numberOfLines = 3;
            cell.detailTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(row == 1){
            cell.textLabel.text = @"Major";
            
            _majorTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 130, 2.5, 100, 40)];
            _majorTextField.textAlignment = NSTextAlignmentRight;
            _majorTextField.placeholder = @"major";
            _majorTextField.textColor = [UIColor colorWithRed:114/255.0f green:114/255.0f blue:116/255.0f alpha:1.0f];
            _majorTextField.keyboardType = UIKeyboardTypeNumberPad;
            _majorTextField.text = modelToConfig.majorStringToWrite;
            _majorTextField.inputAccessoryView = inputView;
            [cell addSubview:_majorTextField];
        }
        else if(row == 2){
            cell.textLabel.text = @"Minor";
            
            _minorTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 130, 2.5, 100, 40)];
            _minorTextField.textAlignment = NSTextAlignmentRight;
            _minorTextField.placeholder = @"major";
            _minorTextField.textColor = [UIColor colorWithRed:114/255.0f green:114/255.0f blue:116/255.0f alpha:1.0f];
            _minorTextField.keyboardType = UIKeyboardTypeNumberPad;
            _minorTextField.text = modelToConfig.minorStringToWrite;
            _minorTextField.inputAccessoryView = inputView;
            [cell addSubview:_minorTextField];
        }
        else if(row == 3){
            cell.textLabel.text = @"MeasuredPower";
            
            _measurePowerTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 130, 2.5, 100, 40)];
            _measurePowerTextField.textAlignment = NSTextAlignmentRight;
            _measurePowerTextField.placeholder = @"measuredPower";
            _measurePowerTextField.textColor = [UIColor colorWithRed:114/255.0f green:114/255.0f blue:116/255.0f alpha:1.0f];
            _measurePowerTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            _measurePowerTextField.text = modelToConfig.measuredPowerStringToWrite;
            _measurePowerTextField.inputAccessoryView = inputView;
            [cell addSubview:_measurePowerTextField];
        }
        else if(row == 4){
            cell.textLabel.text = @"TxPower";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d dBm",modelToConfig.txPowerStringToWrite];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(row == 5){
            cell.textLabel.text = @"Interval";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@0 ms",modelToConfig.intervalStringToWrite];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(row == 6){
            cell.textLabel.text = @"LED";
            
            UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 60, 5, 50, 35)];
            [sw addTarget:self action:@selector(ledSwitchValueChange) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:sw];
            
            self.ledSwitch = sw;
            self.ledSwitch.on = modelToConfig.isLedOnToWrite;
        }
        
    }
    else if(section == 1){
        
        if(row == 0){
            cell.textLabel.text = @"光感开关";
            
            UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 60, 5, 50, 35)];
            [sw addTarget:self action:@selector(lightSensationisOnChange) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:sw];
            sw.on = modelToConfig.lightSensationToWrite.isOn;
            _lightSensationSwitch = sw;
        }
        else if(row == 1){
            cell.textLabel.text = @"光感值更新频率";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ s",modelToConfig.lightSensationToWrite.updateFrequency];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(row == 2){
            cell.textLabel.text = @"黑暗阈值";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"档位%@",modelToConfig.lightSensationToWrite.darkThreshold];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(row == 3){
            cell.textLabel.text = @"黑暗广播频率";
            
            if([modelToConfig.lightSensationToWrite.darkBroadcastFrequency isEqualToString:@"0"]){
                cell.detailTextLabel.text = @"关闭";
            }
            else{
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d ms",[modelToConfig.lightSensationToWrite.darkBroadcastFrequency intValue]*50];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    else if(section == 2){
        
        if(row == 0){
            cell.textLabel.text = @"温度值更新频率";
            
            if([modelToConfig.temperatureUpdateFrequencyToWrite isEqualToString:@"0"]){
                cell.detailTextLabel.text = @"关闭";
            }
            else{
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d s",[modelToConfig.temperatureUpdateFrequencyToWrite intValue]];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
}


- (void)drawBasic_temperature_Section:(NSInteger)section row:(NSInteger)row cell:(UITableViewCell *)cell{
    
    if(section == 0){
        
        if(row == 0){
            cell.textLabel.text = @"UUID";
            cell.detailTextLabel.text = modelToConfig.uuidStringToWrite;
            cell.detailTextLabel.numberOfLines = 3;
            cell.detailTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(row == 1){
            cell.textLabel.text = @"Major";
            
            _majorTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 130, 2.5, 100, 40)];
            _majorTextField.textAlignment = NSTextAlignmentRight;
            _majorTextField.placeholder = @"major";
            _majorTextField.textColor = [UIColor colorWithRed:114/255.0f green:114/255.0f blue:116/255.0f alpha:1.0f];
            _majorTextField.keyboardType = UIKeyboardTypeNumberPad;
            _majorTextField.text = modelToConfig.majorStringToWrite;
            _majorTextField.inputAccessoryView = inputView;
            [cell addSubview:_majorTextField];
        }
        else if(row == 2){
            cell.textLabel.text = @"Minor";
            
            _minorTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 130, 2.5, 100, 40)];
            _minorTextField.textAlignment = NSTextAlignmentRight;
            _minorTextField.placeholder = @"major";
            _minorTextField.textColor = [UIColor colorWithRed:114/255.0f green:114/255.0f blue:116/255.0f alpha:1.0f];
            _minorTextField.keyboardType = UIKeyboardTypeNumberPad;
            _minorTextField.text = modelToConfig.minorStringToWrite;
            _minorTextField.inputAccessoryView = inputView;
            [cell addSubview:_minorTextField];
        }
        else if(row == 3){
            cell.textLabel.text = @"MeasuredPower";
            
            _measurePowerTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 130, 2.5, 100, 40)];
            _measurePowerTextField.textAlignment = NSTextAlignmentRight;
            _measurePowerTextField.placeholder = @"measuredPower";
            _measurePowerTextField.textColor = [UIColor colorWithRed:114/255.0f green:114/255.0f blue:116/255.0f alpha:1.0f];
            _measurePowerTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            _measurePowerTextField.text = modelToConfig.measuredPowerStringToWrite;
            _measurePowerTextField.inputAccessoryView = inputView;
            [cell addSubview:_measurePowerTextField];
        }
        else if(row == 4){
            cell.textLabel.text = @"TxPower";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d dBm",modelToConfig.txPowerStringToWrite];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(row == 5){
            cell.textLabel.text = @"Interval";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@0 ms",modelToConfig.intervalStringToWrite];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }
    else if(section == 2){
        
        if(row == 0){
            cell.textLabel.text = @"温度值更新频率";
            
            if([modelToConfig.temperatureUpdateFrequencyToWrite isEqualToString:@"0"]){
                cell.detailTextLabel.text = @"关闭";
            }
            else{
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d s",[modelToConfig.temperatureUpdateFrequencyToWrite intValue]];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
}


- (void)ledSwitchValueChange{
    modelToConfig.isLedOnToWrite = self.ledSwitch.isOn;
}


#pragma mark - uitableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if(section == 0){
        
        if(row == 0){
            [self keyboardDownButtonPress];
            
            viewShowAfterChooseUUID = YES;
            SICUUIDChooseViewController *vc = [[SICUUIDChooseViewController alloc] init];
            vc.selectedUUIDString = modelToConfig.uuidStringToWrite;
            [self.navigationController pushViewController:vc animated:YES];
            
            __weak UITableView *weak_tableview = self.tableView;
            __block SKYBeaconConfigSingleID *weak_beacon = modelToConfig;
            [vc chooseUUIDBlock:^(NSString *uuidString) {
                weak_beacon.uuidStringToWrite = uuidString;
                [weak_tableview reloadData];
            }];
        }
        else if (row == 4){
            [self keyboardDownButtonPress];
            
            TxPowerChooseViewController *vc = [[TxPowerChooseViewController alloc] init];
            vc.beaconHardwareVersion = modelToConfig.beaconModel.hardwareVersion;
            vc.beaconFirmwareVersionMajor = modelToConfig.beaconModel.firmwareVersionMajor;
            vc.beaconFirmwareVersionMinor = modelToConfig.beaconModel.firmwareVersionMinor;
            [self.navigationController pushViewController:vc animated:YES];
            
            __weak UITableView *weak_tableview = self.tableView;
            __block SKYBeaconConfigSingleID *weak_beacon = modelToConfig;
            [vc chooseTxPowerBlock:^(NSString *txPowerString) {
                weak_beacon.txPowerStringToWrite = [txPowerString intValue];
                [weak_tableview reloadData];
            }];
        }
        else if (row == 5){
            [self keyboardDownButtonPress];
            
            IntervalChooseViewController *vc = [[IntervalChooseViewController alloc] init];
            vc.defaultInterval = modelToConfig.intervalStringToWrite;
            [self.navigationController pushViewController:vc animated:YES];
            
            __weak UITableView *weak_tableview = self.tableView;
            __block SKYBeaconConfigSingleID *weak_beacon = modelToConfig;
            [vc chooseIntervalBlock:^(NSString *intervalString) {
                weak_beacon.intervalStringToWrite = intervalString;
                [weak_tableview reloadData];
            }];
        }
    }
    else if(section == 1){
        
        if(row == 1){
            UpdateFrequencyViewController *vc = [[UpdateFrequencyViewController alloc] init];
            vc.selectedValue = modelToConfig.lightSensationToWrite.updateFrequency;
            [self.navigationController pushViewController:vc animated:YES];
            
            __weak UITableView *weak_tableview = self.tableView;
            __block SKYBeaconConfigSingleID *weak_beacon = modelToConfig;
            [vc chooseValueBlock:^(NSString *valueString) {
                weak_beacon.lightSensationToWrite.updateFrequency = valueString;
                [weak_tableview reloadData];
            }];
        }
        else if(row == 2){
            DarkThresholdChooseViewController *vc = [[DarkThresholdChooseViewController alloc] init];
            vc.selectedValue = modelToConfig.lightSensationToWrite.darkThreshold;
            [self.navigationController pushViewController:vc animated:YES];
            
            __weak UITableView *weak_tableview = self.tableView;
            __block SKYBeaconConfigSingleID *weak_beacon = modelToConfig;
            [vc chooseDarkThresholdBlock:^(NSString *darkThresholdString) {
                weak_beacon.lightSensationToWrite.darkThreshold = darkThresholdString;
                [weak_tableview reloadData];
            }];
        }
        else if (row == 3){
            DarkBroadcastFrequencyViewController *vc = [[DarkBroadcastFrequencyViewController alloc] init];
            vc.selectedValue = modelToConfig.lightSensationToWrite.darkBroadcastFrequency;
            [self.navigationController pushViewController:vc animated:YES];
            
            __weak UITableView *weak_tableview = self.tableView;
            __block SKYBeaconConfigSingleID *weak_beacon = modelToConfig;
            [vc chooseValueBlock:^(NSString *valueString) {
                weak_beacon.lightSensationToWrite.darkBroadcastFrequency = valueString;
                [weak_tableview reloadData];
            }];
        }
    }
    else if(section == 2){
        
        if(row == 0){
            TemperatureUpdateFrequencyChooseViewController *vc = [[TemperatureUpdateFrequencyChooseViewController alloc] init];
            vc.selectedValue = modelToConfig.temperatureUpdateFrequencyToWrite;
            [self.navigationController pushViewController:vc animated:YES];
            
            __weak UITableView *weak_tableview = self.tableView;
            __block SKYBeaconConfigSingleID *weak_beacon = modelToConfig;
            [vc chooseValueBlock:^(NSString *valueString) {
                weak_beacon.temperatureUpdateFrequencyToWrite = valueString;
                [weak_tableview reloadData];
            }];
        }
    }
    
}


#pragma mark - SKYBeaconManagerConfigurationDelegate
- (void)skyBeaconManagerConnectResultSingleIDBeacon:(SKYBeacon *)beacon error:(NSError *)error{
   
    
    if(error == nil){
        
        //
        // TODO:初始化数据
        modelToConfig.uuidStringToWrite = beacon.proximityUUID;
        modelToConfig.majorStringToWrite = beacon.major;
        modelToConfig.minorStringToWrite = beacon.minor;
        modelToConfig.measuredPowerStringToWrite = beacon.measuredPower;
        modelToConfig.txPowerStringToWrite = beacon.txPower;
        modelToConfig.intervalStringToWrite = beacon.intervalMillisecond;
        modelToConfig.isLockedToWrite = beacon.isLocked;
        modelToConfig.lockedKeyToWrite = @"";
        modelToConfig.isEncryptedToWrite = beacon.isEncrypted;
        modelToConfig.isLedOnToWrite = beacon.isLedOn;
        
        modelToConfig.lightSensationToWrite.isOn = beacon.lightSensation.isOn;
        modelToConfig.lightSensationToWrite.darkThreshold = beacon.lightSensation.darkThreshold;
        modelToConfig.lightSensationToWrite.darkBroadcastFrequency = beacon.lightSensation.darkBroadcastFrequency;
        modelToConfig.lightSensationToWrite.voltage = beacon.lightSensation.voltage;
        modelToConfig.lightSensationToWrite.updateFrequency = beacon.lightSensation.updateFrequency;
        
        modelToConfig.temperatureUpdateFrequencyToWrite = beacon.temperatureUpdateFrequency;
        
        [self.tableView reloadData];
    }
    else{
        NSLog(@"连接失败");
    }
}

- (void)skyBeaconManagerDisconnectSingleIDBeaconError:(NSError *)error{
    
    if(!error){
        
    }
    else{
        
        if(!disconnectAfterWrite){
            // code 6 , time out
            if(error.code == 6){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"连接超时断开" message:nil delegate:nil cancelButtonTitle:@"Okey" otherButtonTitles: nil];
                [alert show];
            }
        }
        
    }
}

- (void)skyBeaconManagerDisconnectMutipleIDBeaconError:(NSError *)error{

}


#pragma mark - User Method
// 断开连接
- (void)disconnectPeripheral{
}


- (void)saveUIData{
    modelToConfig.majorStringToWrite = _majorTextField.text;
    modelToConfig.minorStringToWrite = _minorTextField.text;
    modelToConfig.measuredPowerStringToWrite = _measurePowerTextField.text;
    modelToConfig.lockedKeyToWrite = @"123456"; // 这里配置你的lockKey
    modelToConfig.lightSensationToWrite.isOn = _lightSensationSwitch.isOn;
}

#pragma mark - 配置按钮press
- (void)savePress{
    [self keyboardDownButtonPress];
    
    disconnectAfterWrite = YES;
    
    
    [[SKYBeaconManager sharedDefaults] writeSingleIDBeaconValues:modelToConfig completion:^(NSError *error) {
        
        if(error != nil){
            NSLog(@"%@",error.userInfo[@"error"]);
            
            if(error.code != SKYBeaconSDKErrorNoneToWrite){
                [SVProgressHUD showInfoWithStatus:error.userInfo[@"error"] maskType:SVProgressHUDMaskTypeBlack];
            }
        }
        else{
            [SVProgressHUD showSuccessWithStatus:@"配置成功" maskType:SVProgressHUDMaskTypeBlack];
            
            [self navBackPress];
        }
    }];
    
}

- (void)lightSensationisOnChange{
    modelToConfig.lightSensationToWrite.isOn = _lightSensationSwitch.isOn;
    
    if(_lightSensationSwitch.isOn){
    
    }
    else{
        modelToConfig.lightSensationToWrite.darkThreshold = modelToConfig.beaconModel.lightSensation.darkThreshold;
        modelToConfig.lightSensationToWrite.darkBroadcastFrequency = modelToConfig.beaconModel.lightSensation.darkBroadcastFrequency;
    }
    
    [self performSelector:@selector(tableViewReloadData) withObject:nil afterDelay:0.2];
}

- (void)tableViewReloadData{
    [self.tableView reloadData];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag == 99999){
        [self.navigationController popViewControllerAnimated:YES];
    }
}



@end
