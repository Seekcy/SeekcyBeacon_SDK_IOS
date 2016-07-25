//
//  TxPowerChooseViewController.h
//  SeekcyIBeaconConfig
//
//  Created by seekcy on 15/7/20.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SICBaseViewController.h"

@interface TxPowerChooseViewController : SICBaseViewController{
    void (^chooseTxPowerBlock)(NSString *);
}

- (void)chooseTxPowerBlock:(void(^)(NSString *txPowerString))block;

@property (nonatomic, strong) NSString *selectedTxPowerString;
@property (nonatomic, strong) NSString *beaconHardwareVersion;
@property (nonatomic, strong) NSString *beaconFirmwareVersionMajor;
@property (nonatomic, strong) NSString *beaconFirmwareVersionMinor;

@end
