//
//  SKYBeaconMutipleIDCharacteristicInfo.h
//  SeekcyBeaconSDK
//
//  Created by seekcy on 15/6/29.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKYBeaconEnumConstant.h"

#define SKYBeaconMutipleIDCharacteristicInfoKeyOne @"ID1"
#define SKYBeaconMutipleIDCharacteristicInfoKeyTwo @"ID2"
#define SKYBeaconMutipleIDCharacteristicInfoKeyThree @"ID3"

/// SKYBeaconMutipleIDCharacteristicInfo
@interface SKYBeaconMutipleIDCharacteristicInfo : NSObject

/*!
 *  @property characteristicID
 *
 *  @discussion id号
 *
 */
@property (nonatomic, strong) NSString *characteristicID;

/*!
 *  @property uuid
 *
 *  @discussion uuid
 *
 */
@property (nonatomic, strong) NSString *uuid;

/*!
 *  @property major
 *
 *  @discussion major
 *
 */
@property (nonatomic, strong) NSString *major;

/*!
 *  @property minor
 *
 *  @discussion minor
 *
 */
@property (nonatomic, strong) NSString *minor;

/*!
 *  @property txPower
 *
 *  @discussion txPower
 *
 */
@property (nonatomic) enum SKYBeaconConfigTxPowerValue txPower;

/*!
 *  @property measuredPower
 *
 *  @discussion measuredPower
 *
 */
@property (nonatomic, strong) NSString *measuredPower;

/*!
 *  @property IsEncrypted
 *
 *  @discussion 是否防蹭用
 *
 */
@property (nonatomic) enum SKYBeaconEncryptedConfigType IsEncrypted;

/*!
 *  @method initWithcharacteristicID:uuid:major:minor:txPower:measuredPower:isEncrypted:
 *
 *  @param  characteristicID    特征值id
 *  @param  uuid                uuid
 *  @param  major               major
 *  @param  minor               minor
 *  @param  txPower             txPower
 *  @param  measuredPower       measuredPower
 *  @param  isEncrypted         是否防蹭用
 *
 *  @discussion   获取默认measuredPower
 *
 */
- (instancetype)initWithcharacteristicID:(NSString *)characteristicID uuid:(NSString *)uuid major:(NSString *)major minor:(NSString *)minor txPower:(enum SKYBeaconConfigTxPowerValue)txPower measuredPower:(NSString *)measuredPower isEncrypted:(enum SKYBeaconEncryptedConfigType)isEncrypted;
@end
