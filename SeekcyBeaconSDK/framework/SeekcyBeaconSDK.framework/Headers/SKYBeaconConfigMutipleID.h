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

enum BeaconConfigStateMutipleID{
    beaconConfigStateMutipleID_wating,
    beaconConfigStateMutipleID_connecting,
    beaconConfigStateMutipleID_connectSuccess,
    beaconConfigStateMutipleID_connectFaild,
    beaconConfigStateMutipleID_configSuccess,
    beaconConfigStateMutipleID_configfaild,
    beaconConfigStateMutipleID_configfaild_noPasskey,
    beaconConfigStateMutipleID_configfaild_8628,
    beaconConfigStateMutipleID_configfaild_8629,
    beaconConfigStateMutipleID_configfaild_862a
};

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
 *  @discussion 开启防窜改模式时设置的key值,开启防窜改后，所有写入动作都会使用这个key，否则使用寻息提供的默认key。 (初始化的时候默认为@"")
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

//
///*!
// *  @property uuidStringToWrite
// *
// *  @discussion uuid的写入值
// *
// */
//@property (nonatomic, strong) NSString *uuidStringToWrite;
//
///*!
// *  @property majorStringToWrite
// *
// *  @discussion major的写入值
// *
// */
//@property (nonatomic, strong) NSString *majorStringToWrite;
//
///*!
// *  @property minorStringToWrite
// *
// *  @discussion minor的写入值
// *
// */
//@property (nonatomic, strong) NSString *minorStringToWrite;
//
///*!
// *  @property measurePowerStringToWrite
// *
// *  @discussion measuredPower的写入值
// *
// */
//@property (nonatomic, strong) NSString *measuredPowerStringToWrite;
//
///*!
// *  @property txPowerStringToWrite
// *
// *  @discussion txPower的写入值
// *
// */
//@property (nonatomic, strong) NSString *txPowerStringToWrite;
//
///*!
// *  @property intervalStringToWrite
// *
// *  @discussion interval的写入值
// *
// */
//@property (nonatomic, strong) NSString *intervalStringToWrite;

//
///*!
// *  @property mutipleIDsIsEncryptedToWrite
// *
// *  @discussion 是否开启防蹭用模式，0表示关闭，1表示开启
// *                      index:  0 ID3的防蹭用
// *                                 1 ID2的防蹭用
// *                                 2 ID1的防蹭用
// */
//@property (nonatomic) NSMutableArray *mutipleIDsIsEncryptedToWrite;

/*!
 *  @method initWithBeacon:
 *
 *  @param beacon SKYBeacon对象
 *
 *  @discussion   初始化，根据传入的SKYBeacon对象进行初始化
 *
 */
- (instancetype)initWithBeacon:(SKYBeaconMutipleID *)beacon;

@end
