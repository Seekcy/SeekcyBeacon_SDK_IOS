//
//  SKYBeaconConfigMutipleID.h
//  SeekcyBeaconSDK
//
//  Created by seekcy on 15/6/29.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SKYBeacon;
@class SKYBeaconConfigSingleID;
@class SKYBeaconMutipleIDCharacteristicInfo;
@class SKYBeaconMutipleID;
@class SKYLightSensation;

/// SKYBeaconConfigMutipleID
@interface SKYBeaconConfigMutipleID : NSObject

/*!
 *  @property beaconModel
 *
 *  @discussion SKYBeacon对象，用于保存beacon配置前的原有数据
 *
 */
@property (nonatomic, strong) SKYBeaconMutipleID *beaconModel;


/*!
 *  @property deviceName
 *
 *  @discussion 设备名称
 *
 */
@property (nonatomic, strong) NSString *deviceName;

/*!
 *  @property beaconConfigID1ToWrite
 *
 *  @discussion SKYBeaconMutipleIDCharacteristicInfo对象，记录广播ID1的数据
 *
 */
@property (nonatomic, strong) SKYBeaconMutipleIDCharacteristicInfo *beaconConfigID1ToWrite;

/*!
 *  @property beaconConfigID2ToWrite
 *
 *  @discussion SKYBeaconMutipleIDCharacteristicInfo对象，记录广播ID2的数据
 *
 */
@property (nonatomic, strong) SKYBeaconMutipleIDCharacteristicInfo *beaconConfigID2ToWrite;

/*!
 *  @property beaconConfigID3ToWrite
 *
 *  @discussion SKYBeaconMutipleIDCharacteristicInfo对象，记录广播ID3的数据
 *
 */
@property (nonatomic, strong) SKYBeaconMutipleIDCharacteristicInfo *beaconConfigID3ToWrite;

/*!
 *  @property configState
 *
 *  @discussion 记录beacon的配置状态, 默认初始化的状态为 beaconConfigState_wating
 *
 */
@property (nonatomic) enum BeaconConfigStateMutipleID configState;

/*!
 *  @property isLockedToWrite
 *
 *  @discussion 是否打开防篡改模式，yes:关闭，no:开启
 *
 */
@property (nonatomic) BOOL isLockedToWrite;

/*!
 *  @property isConfigTime
 *
 *  @discussion 是否配置时间
 *
 */
@property (nonatomic) BOOL isConfigTime;

/*!
 *  @property factoryReset
 *
 *  @discussion 是否恢复出厂设置
 *
 */
@property (nonatomic) BOOL isFactoryReset;

/*!
 *  @property lockedKeyToWrite
 *
 *  @discussion 开启防篡改模式时设置的key值,开启防篡改后，所有写入动作都会使用这个key，否则使用寻息提供的默认key。 (初始化的时候默认为@"")
 *
 */
@property (nonatomic, strong) NSString *lockedKeyToWrite;

/*!
 *  @property resetConfigKeyToWrite
 *
 *  @discussion 恢复出厂设置时的key
 *
 */
@property (nonatomic, strong) NSString *resetConfigKeyToWrite;

/*!
 *  @property intervalToWrite
 *
 *  @discussion 发送间隔,单位:毫秒
 *
 */
@property (nonatomic, strong) NSString *intervalToWrite;


/*!
 *  @property cellUseOf
 *
 *  @discussion 格子使用情况，count = 10
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
@property (nonatomic, strong) NSMutableArray *cellUseOfToWrite;

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
 *  @method initWithBeacon:
 *
 *  @param beacon SKYBeacon对象
 *
 *  @discussion   初始化，根据传入的SKYBeacon对象进行初始化
 *
 */
- (instancetype)initWithBeacon:(SKYBeaconMutipleID *)beacon;

/*!
 *  @method configWithBeacon:
 *
 *  @param beacon SKYBeacon对象
 *
 *  @discussion   根据传入的SKYBeacon对象进行赋值
 *
 */
- (void)configWithBeacon:(SKYBeaconMutipleID *)beacon;

@end
