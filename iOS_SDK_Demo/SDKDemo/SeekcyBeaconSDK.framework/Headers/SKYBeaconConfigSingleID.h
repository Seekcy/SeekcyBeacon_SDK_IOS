//
//  SKYBeaconConfig.h
//  SeekcyBeaconSDK
//
//  Created by seekcy on 15/6/29.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SKYBeacon;
@class SKYLightSensation;


/// SKYBeaconConfigSingleID
@interface SKYBeaconConfigSingleID : NSObject


/*!
 *  @property beaconModel
 *
 *  @discussion SKYBeacon对象，用于保存beacon配置前的原有数据
 *
 */
@property (nonatomic, strong) SKYBeacon *beaconModel;

/*!
 *  @property uuidStringToWrite
 *
 *  @discussion uuid的写入值
 *
 */
@property (nonatomic, strong) NSString *uuidStringToWrite;
//@property (nonatomic, assign) Byte *uuidBytes;

/*!
 *  @property majorStringToWrite
 *
 *  @discussion major的写入值
 *
 */
@property (nonatomic, strong) NSString *majorStringToWrite;
//@property (nonatomic, assign) Byte *majorBytes;

/*!
 *  @property minorStringToWrite
 *
 *  @discussion minor的写入值
 *
 */
@property (nonatomic, strong) NSString *minorStringToWrite;
//@property (nonatomic, assign) Byte *minorBytes;

/*!
 *  @property measurePowerStringToWrite
 *
 *  @discussion measuredPower的写入值
 *
 */
@property (nonatomic, strong) NSString *measuredPowerStringToWrite;
//@property (nonatomic, assign) Byte measuredPowerByte;

/*!
 *  @property txPowerStringToWrite
 *
 *  @discussion txPower的写入值
 *
 */
@property (nonatomic) enum SKYBeaconConfigTxPowerValue txPowerStringToWrite;
//@property (nonatomic, assign) Byte txPowerByte;

/*!
 *  @property intervalStringToWrite
 *
 *  @discussion interval的写入值
 *
 */
@property (nonatomic, strong) NSString *intervalStringToWrite;
//@property (nonatomic, assign) Byte intervalByte;

/*!
 *  @property configState
 *
 *  @discussion 记录beacon的配置状态, 默认初始化的状态为 beaconConfigState_wating
 *
 */
@property (nonatomic) enum BeaconConfigState configState;

/*!
 *  @property isLockedToWrite
 *
 *  @discussion 是否打开防篡改模式，yes:关闭，no:开启
 *
 */
@property (nonatomic) BOOL isLockedToWrite;

/*!
 *  @property lockedKeyToWrite
 *
 *  @discussion 开启防篡改模式时设置的key值,开启防篡改后，所有写入动作都会使用这个key，否则使用寻息提供的默认key。 (初始化的时候默认为@"")
 *
 */
@property (nonatomic, strong) NSString *lockedKeyToWrite;

/*!
 *  @property isEncryptedToWrite
 *
 *  @discussion 是否开启防蹭用模式，0表示关闭，1表示开启
 *
 */
@property (nonatomic) BOOL isEncryptedToWrite;


/*!
 *  @property isLedOn
 *
 *  @discussion led是否点亮
 *
 */
@property (nonatomic) BOOL isLedOnToWrite;


/*!
 *  @property lightSensation
 *
 *  @discussion 光感信息，SKYLightSensation对象
 *
 */
@property (nonatomic, strong) SKYLightSensation *lightSensationToWrite;

/*!
 *  @property temperatureUpdateFrequency
 *
 *  @discussion 温度值更新频率，单位s
 *
 */
@property (nonatomic, strong) NSString *temperatureUpdateFrequencyToWrite;


/*!
 *  @property deviceNameToWrite
 *
 *  @discussion 写入的设备名称
 *
 */
@property (nonatomic, strong) NSString *deviceNameToWrite;

/*!
 *  @method initWithBeacon:
 *
 *  @param beacon SKYBeacon对象
 *
 *  @discussion   初始化，根据传入的SKYBeacon对象进行初始化
 *
 */
- (instancetype)initWithBeacon:(SKYBeacon *)beacon;

@end
