//
//  SKYBeacon.h
//  SeekcyBeaconSDK
//
//  Created by seekcy on 15/6/17.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKYBeaconMutipleIDCharacteristicInfo.h"
@class CBPeripheral;
@class SKYLightSensation;

/// SKYBeacon
@interface SKYBeacon : NSObject

/*!
 *  @property peripheral
 *
 *  @discussion 设备对象
 *
 */
@property (nonatomic, strong) CBPeripheral *peripheral;


/*!
 *  @property macAddress
 *
 *  @discussion 设备mac地址
 *
 */
@property (nonatomic, strong) NSString *macAddress;

/*!
 *  @property deviceName
 *
 *  @discussion 设备名称
 *
 */
@property (nonatomic, strong) NSString *deviceName;

/*!
 *  @property hardwareVersion
 *
 *  @discussion 硬件版本号
 *
 */
@property (nonatomic, strong) NSString *hardwareVersion;

/*!
 *  @property firmwareVersionMajor
 *
 *  @discussion 主固件版本号
 *
 */
@property (nonatomic, strong) NSString *firmwareVersionMajor;

/*!
 *  @property firmwareVersionMinor
 *
 *  @discussion 次固件版本号
 *
 */
@property (nonatomic, strong) NSString *firmwareVersionMinor;

/*!
 *  @property uuidReplaceName
 *
 *  @discussion uuid的替代名称
 *
 */
@property (nonatomic, strong) NSString *uuidReplaceName;

/*!
 *  @property proximityUUID
 *
 *  @discussion uuid
 *
 */
@property (nonatomic, strong) NSString *proximityUUID;

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
 *  @property measuredPower
 *
 *  @discussion 实测功率
 *
 */
@property (nonatomic, strong) NSString *measuredPower;

/*!
 *  @property intervalMillisecond
 *
 *  @discussion 发送间隔,单位:毫秒
 *
 */
@property (nonatomic, strong) NSString *intervalMillisecond;

/*!
 *  @property txPower
 *
 *  @discussion 发送功率
 *
 */
@property (nonatomic) enum SKYBeaconConfigTxPowerValue txPower;

/*!
 *  @property rssi
 *
 *  @discussion 场强
 *
 */
@property (nonatomic, strong) NSNumber *rssi;

/*!
 *  @property distance
 *
 *  @discussion 距离
 *
 */
@property (nonatomic) float distance;

/*!
 *  @property battery
 *
 *  @discussion 电量, 单位: %
 *
 */
@property (nonatomic) NSInteger battery;

/*!
 *  @property temperature
 *
 *  @discussion 温度：摄氏度
 *
 */
@property (nonatomic) float temperature;

/*!
 *  @property temperatureUpdateFrequency
 *
 *  @discussion 温度值更新频率
 *
 */
@property (nonatomic, strong) NSString *temperatureUpdateFrequency;

/*!
 *  @property isLocked
 *
 *  @discussion 是否打开防篡改模式，yes:关闭，no:开启
 *
 */
@property (nonatomic) BOOL isLocked;

/*!
 *  @property lockedKey
 *
 *  @discussion 开启防篡改模式时设置的key值,开启防篡改后，所有写入动作都会使用这个key，否则使用寻息提供的默认key。
 *
 */
@property (nonatomic, strong) NSString *lockedKey;

/*!
 *  @property isEncrypted
 *
 *  @discussion 是否开启防蹭用模式，0表示关闭，1表示开启
 *
 */
@property (nonatomic) BOOL isEncrypted;

/*!
 *  @property isSeekcyBeacon
 *
 *  @discussion 是否是寻息iBeacon，0表示关闭，1表示开启
 *
 */
@property (nonatomic) BOOL isSeekcyBeacon;

/*!
 *  @property timestampMillisecond
 *
 *  @discussion iBeacon的扫描时间戳
 *
 */
@property (nonatomic) long int timestampMillisecond;


/*!
 *  @property isLedOn
 *
 *  @discussion led是否点亮
 *
 */
@property (nonatomic) BOOL isLedOn;


/*!
 *  @property lightSensation
 *
 *  @discussion 光感信息，SKYLightSensation对象
 *
 */
@property (nonatomic, strong) SKYLightSensation *lightSensation;


/*!
 *  @property lightVoltage
 *
 *  @discussion 光感信息，SKYLightSensation对象
 *
 */
@property (nonatomic, strong) NSString *lightVoltage;

/*!
 *  @method pushWeight
 *
 *  @discussion   推送权重
 *
 */
@property (nonatomic) float pushWeight;

//////////////////////
//  以下属性用于多id的情况
//////////////////////

/*!
 *  @property characteristicInfo
 *
 *  @discussion SKYBeaconMutipleIDCharacteristicInfo对象的集合。
 *                     在多id的情况下，用来记录多id的uuid，major，minor。（通过 isMutipleID 方法判断Beacon是否为多id）
 *
 */
@property (nonatomic, strong)  NSMutableDictionary *characteristicInfo;

/*!
 *  @property multiMACFlag
 *
 *  @discussion 多Mac标志位，1代表Beacon采用多MAC，0代表采用单MAC
 *
 */
@property (nonatomic) BOOL multiMACFlag;

/*!
 *  @property cellUseOf
 *
 *  @discussion 格子使用情况，count = 10 , 
 *                      index: 0 表示使用了多少个格子（即有几个id广播）
 *                                1 广播ID1
 *                                2 广播ID2
 *                                3 广播ID3
 *                                4 广播ID4
 *                                5 广播ID5
 *                                6 广播ID6
 *                                7 广播ID7
 *                                8 广播ID8
 *                                9 广播ID9
 */
@property (nonatomic, strong) NSMutableArray *cellUseOf;


/*!
 *  @method isMutipleID
 *
 *  @discussion   判断beacon是否是多id
 *
 */
- (BOOL)isMutipleID;


@end
