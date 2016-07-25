//
//  SKYBeaconManager.h
//  SeekcyBeaconSDK
//
//  Created by seekcy on 15/6/17.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SKYBeacon;
@class CLRegion;
@class SKYBeaconRegion;
@class SKYBeaconConfigSingleID;
@class SKYBeaconConfigMutipleID;
@class SKYBeaconManagerError;
@class SKYBeaconMutipleID;
#import "SKYBeaconEnumConstant.h"


FOUNDATION_EXPORT NSString *const modelTransitField_peripheral;
FOUNDATION_EXPORT NSString *const modelTransitField_macAddress;
FOUNDATION_EXPORT NSString *const modelTransitField_deviceName;
FOUNDATION_EXPORT NSString *const modelTransitField_hardwareVersion;
FOUNDATION_EXPORT NSString *const modelTransitField_firmwareVersionMajor;
FOUNDATION_EXPORT NSString *const modelTransitField_firmwareVersionMinor;
FOUNDATION_EXPORT NSString *const modelTransitField_uuidReplaceName;
FOUNDATION_EXPORT NSString *const modelTransitField_proximityUUID;
FOUNDATION_EXPORT NSString *const modelTransitField_major;
FOUNDATION_EXPORT NSString *const modelTransitField_minor;
FOUNDATION_EXPORT NSString *const modelTransitField_measuredPower;
FOUNDATION_EXPORT NSString *const modelTransitField_intervalMillisecond;
FOUNDATION_EXPORT NSString *const modelTransitField_txPower;
FOUNDATION_EXPORT NSString *const modelTransitField_rssi;
FOUNDATION_EXPORT NSString *const modelTransitField_distance;
FOUNDATION_EXPORT NSString *const modelTransitField_battery;
FOUNDATION_EXPORT NSString *const modelTransitField_temperature;
FOUNDATION_EXPORT NSString *const modelTransitField_isLocked;
FOUNDATION_EXPORT NSString *const modelTransitField_lockedKey;
FOUNDATION_EXPORT NSString *const modelTransitField_isEncrypted;
FOUNDATION_EXPORT NSString *const modelTransitField_isSeekcyBeacon;
FOUNDATION_EXPORT NSString *const modelTransitField_timestampMillisecond;
FOUNDATION_EXPORT NSString *const modelTransitField_multiMACFlag;
FOUNDATION_EXPORT NSString *const modelTransitField_isMutipleID;
FOUNDATION_EXPORT NSString *const modelTransitField_lightVoltage;

/** 连接beacon的返回block */
//typedef void(^SKYConnectCompletionBlock)(BOOL complete, NSError* error, id obj);

/** 用于推送beacon的block */
typedef void(^NotificationSKYBeaconsInRegionsCompletionBlock)(BOOL complete, NSError* error, NSArray *beacons);

/// SKYBeaconManagerScanDelegate
@protocol SKYBeaconManagerScanDelegate <NSObject>

/*!
 *  @method skyBeaconManagerCompletionScanWithBeacons:error
 *
 *  @param beascons  扫描到的寻息beacon数组
 *  @param error         错误， SKYBeaconManagerError 对象
 *
 *  @discussion      返回扫描结果的delegate
 *
 */
- (void)skyBeaconManagerCompletionScanWithBeacons:(NSArray *)beascons error:(NSError *)error;

/*!
 *  @method skyBeaconManagerCompletionScanWithSingleIDBeacons:error
 *
 *  @param beascons  扫描到的寻息beacon数组(单id)
 *  @param error         错误， SKYBeaconManagerError 对象
 *
 *  @discussion      返回扫描结果的delegate
 *
 */
- (void)skyBeaconManagerCompletionScanWithSingleIDBeacons:(NSArray *)beascons error:(NSError *)error;

/*!
 *  @method skyBeaconManagerCompletionScanWithMutipleIDBeacons:error
 *
 *  @param beascons  扫描到的寻息beacon数组（多id）
 *  @param error         错误， SKYBeaconManagerError 对象
 *
 *  @discussion      返回扫描结果的delegate
 *
 */
- (void)skyBeaconManagerCompletionScanWithMutipleIDBeacons:(NSArray *)beascons error:(NSError *)error;



@end

/// SKYBeaconManagerConfigurationDelegate 配置时的delegate
@protocol SKYBeaconManagerConfigurationDelegate <NSObject>

/*!
 *  @method skyBeaconManagerConnectResultSingleIDBeacon:error
 *
 *  @param beacon  SKYBeacon对象，针对单id beacon
 *  @param error   错误， NSError 对象
 *
 *  @discussion    返回连接单id beacon结果的delegate
 *
 */
- (void)skyBeaconManagerConnectResultSingleIDBeacon:(SKYBeacon *)beacon error:(NSError *)error;

/*!
 *  @method skyBeaconManagerConnectResultMutipleIDBeacon:error
 *
 *  @param beacon  SKYBeaconMutipleID对象，针对多id beacon
 *  @param error   错误， NSError 对象
 *
 *  @discussion    返回连接多id beacon结果的delegate
 *
 */
- (void)skyBeaconManagerConnectResultMutipleIDBeacon:(SKYBeaconMutipleID *)beacon error:(NSError *)error;

/*!
 *  @method skyBeaconManagerDisconnectSingleIDBeaconError:error
 *
 *  @param error   错误， NSError 对象
 *
 *  @discussion    返回取消连接单id beacon
 *
 */
- (void)skyBeaconManagerDisconnectSingleIDBeaconError:(NSError *)error;

/*!
 *  @method skyBeaconManagerDisconnectMutipleIDBeaconError:error
 *
 *  @param error   错误， NSError 对象
 *
 *  @discussion    返回取消连接多id beacon
 *
 */
- (void)skyBeaconManagerDisconnectMutipleIDBeaconError:(NSError *)error;

@end

/// SKYBeaconManagerMonitorDelegate
@protocol SKYBeaconManagerMonitorDelegate <NSObject>

/*!
 *  @method skyBeaconManagerDidEnterRegion:
 *
 *  @param region   进入的区域对象
 *
 *  @discussion     当你进入一个受监听的区域时的回调
 *
 */
- (void)skyBeaconManagerDidEnterRegion:(CLRegion *)region;

/*!
 *  @method skyBeaconManagerDidExitRegion:
 *
 *  @param region   退出的区域对象
 *
 *  @discussion     当你退出一个受监听的区域时的回调
 *
 */
- (void)skyBeaconManagerDidExitRegion:(CLRegion *)region;

@end

/// SKYBeaconManagerRangingDelegate
@protocol SKYBeaconManagerRangingDelegate <NSObject>

/*!
 *  @method skyBeaconManagerDidRangeBeacons:region
 *
 *  @param beacons  返回的beacons (CLBeacon对象的数组)
 *  @param region   SKYBeaconRegion区域对象
 *
 *  @discussion     ranging接收的回调
 *
 */
- (void)skyBeaconManagerDidRangeBeacons:(NSArray *)beacons inRegion:(SKYBeaconRegion *)region;

@end

/// SKYBeaconManager
@interface SKYBeaconManager : NSObject

/*!
 *  @property seekcyDecryptKey
 *
 *  @discussion  寻息解密密钥
 */
@property (nonatomic, strong) NSString *seekcyDecryptKey;

/*!
 *  @property scanBeaconTimeInterval
 *
 *  @discussion  扫描beacon时，返回数据间隔，默认1.5秒
 */
@property (nonatomic) float scanBeaconTimeInterval;

/*!
 *  @property skyBeaconManagerScanDelegate
 *
 *  @discussion  用于 startScanForSKYBeacon:uuids:distinctionMutipleID:isReturnValueEncapsulation 方法时的delegate返回
 */
@property (nonatomic, weak) id<SKYBeaconManagerScanDelegate> skyBeaconManagerScanDelegate;

/*!
 *  @property skyBeaconManagerMonitorDelegate
 *
 *  @discussion  用于 startMonitoringForSKYBeaconRegions:delegate 方法时的delegate返回
 */
@property (nonatomic, weak) id<SKYBeaconManagerMonitorDelegate> skyBeaconManagerMonitorDelegate;

/*!
 *  @property skyBeaconManagerRangingDelegate
 *
 *  @discussion  用于 startRangingSKYBeaconsInRegions:delegate 方法时的delegate返回
 */
@property (nonatomic, weak) id<SKYBeaconManagerRangingDelegate> skyBeaconManagerRangingDelegate;

/*!
 *  @method sharedDefaults
 *
 *  @discussion 单例
 *
 */
+ (SKYBeaconManager *)sharedDefaults;


/*!
 *  @method startScanForSKYBeacon:uuids:distinctionMutipleID:isReturnValueEncapsulation
 *
 *  @param delegate SKYBeaconManagerScanDelegate, 用于返回扫描结果
 *  @param uuids    指定扫描的uuid列表
 *  @param distinctionMutipleID    返回结果的时候是否区分多id和单id。如果YES,单id Beacon在skyBeaconManagerCompletionScanWithSingleIDBeacons:error: 中返回，多id beacon在skyBeaconManagerCompletionScanWithMutipleIDBeacons:error: 中返。如果NO,全部beacon在skyBeaconManagerCompletionScanWithBeacons:error: 中返回。
 *  @param isReturnValueEncapsulation 当distinctionMutipleID = NO ，返回数据是否封装成SKYBeacon对象，或者SKYBeaconMutipleID对象。当为YES时，单id Beacon的数据放入SKYBeacon对象中，多id Beacon的数据放入SKYBeaconMutipleID对象。
     当为NO时，由NSDictionary数组返回，对应key可参考类似modelTransitField_peripheral。
 *
 *  @discussion 扫描寻息Beacon (默认1.5秒返回结果)
 */
- (void)startScanForSKYBeaconWithDelegate:(id<SKYBeaconManagerScanDelegate>)delegate uuids:(NSArray *)uuids distinctionMutipleID:(BOOL)distinctionMutipleID isReturnValueEncapsulation:(BOOL)isReturnValueEncapsulation;

/*!
 *  @method stopScanSKYBeacon
 *
 *  @discussion  停止扫描寻息Beacon
 */
- (void)stopScanSKYBeacon;

/*!
 *  @method clearScanedData
 *
 *  @discussion  清除数据
 */
- (void)clearScanedData;

/*!
 *  @method connectSingleIDBeacon:delegate:
 *
 *  @param beacon       用于连接的寻息Beacon,SKYBeacon对象
 *  @param delegate     连接成功的delegate返回
 *
 *  @discussion 连接寻息Beacon
 *
 */
- (void)connectSingleIDBeacon:(SKYBeacon *)beacon delegate:(id<SKYBeaconManagerConfigurationDelegate>)delegate;

@property (nonatomic, strong) NSString *lockedKeyForConnectDialog;

/*!
 *  @method connectMutipleIDBeacon:delegate:
 *
 *  @param beacon       用于连接的寻息Beacon,SKYBeaconMutipleID对象
 *  @param delegate     连接成功的delegate返回
 *
 *  @discussion 连接寻息Beacon
 *
 */
- (void)connectMutipleIDBeacon:(SKYBeaconMutipleID *)beacon delegate:(id<SKYBeaconManagerConfigurationDelegate>)delegate;

/*!
 *  @method cancelBeaconConnection:completion:
 *
 *  @param beacon       用于断开连接的寻息Beacon(目前有SKYBeacon、SKYBeaconMutipleID)
 *  @param completion   断开连接成功的block返回
 *
 *  @discussion 断开连接寻息Beacon
 *
 */
- (void)cancelBeaconConnection:(id)beacon completion:(void(^)(BOOL complete, NSError *error))completion;

/*!
 *  @method cancelSingleIDBeaconConnection:delegate
 *
 *  @param beacon       寻息单id beacon，SKYBeacon对象
 *  @param delegate     SKYBeaconManagerConfigurationDelegate
 *
 *  @discussion 断开连接寻息单id Beacon
 *
 */
- (void)cancelSingleIDBeaconConnection:(SKYBeacon *)beacon delegate:(id<SKYBeaconManagerConfigurationDelegate>)delegate;

/*!
 *  @method cancelMutipleIDBeaconConnection:delegate
 *
 *  @param beacon       寻息多id beacon，SKYBeaconMutipleID对象
 *  @param delegate     SKYBeaconManagerConfigurationDelegate
 *
 *  @discussion 断开连接寻息单id Beacon
 *
 */
- (void)cancelMutipleIDBeaconConnection:(SKYBeaconMutipleID *)beacon delegate:(id<SKYBeaconManagerConfigurationDelegate>)delegate;

/*!
 *  @method writeSingleIDBeaconValues:completion:
 *
 *  @param values       SKYBeaconConfigSingleID对象
 *  @param completion   写入成功的block返回
 *
 *  @discussion 写数据到寻息Beacon
 */
- (void)writeSingleIDBeaconValues:(SKYBeaconConfigSingleID *)values completion:(void(^)(NSError *error))completion;

/*!
 *  @method writeMutipleIDBeaconValues:completion:
 *
 *  @param values           SKYBeaconConfigMutipleID 对象
 *  @param completion   写入成功的block返回
 *
 *  @discussion 写数据到寻息Beacon
 */
- (void)writeMutipleIDBeaconValues:(SKYBeaconConfigMutipleID *)values completion:(void(^)(NSError *error))completion;

/*!
 *  @method factoryResetMutipleIDBeaconValues:completion:
 *
 *  @param values           SKYBeaconConfigMutipleID 对象
 *  @param completion       写入成功的block返回
 *
 *  @discussion 恢复出厂设置
 *              values 传参例子：（key值参考 SKYBeaconConfigMutipleID.h 中）
 */
- (void)factoryResetMutipleIDBeaconValues:(SKYBeaconConfigMutipleID *)values completion:(void(^)(NSError *error))completion;

/*!
 *  @method startRangingSKYBeaconsInRegions:delegate
 *
 *  @param  regions     范围扫描的区域集合 （由 SKYBeaconRegion 对象组成的数组）
 *  @param  delegate    回调
 *
 *  @discussion     范围扫描
 */
- (void)startRangingSKYBeaconsInRegions:(NSArray *)regions delegate:(id<SKYBeaconManagerRangingDelegate>)delegate;


/*!
 *  @method startRangedNearBySKYBeaconsInRegions
 *
 *  @param  regions     范围扫描的区域集合 （由 SKYBeaconRegion 对象组成的数组）
 *  @param  completion  block回调
 *
 *  @discussion     扫描beacon，并且做推送过滤返回结果。
 */
- (void)startRangedNearBySKYBeaconsInRegions:(NSArray *)regions completion:(NotificationSKYBeaconsInRegionsCompletionBlock)completion;

/*!
 *  @method setRangedNearByPhoneMeasuredPower
 *
 *  @param  phoneMeasuredPower  1米处的rssi值
 *
 *  @discussion     在调用startRangedNearBySKYBeaconsInRegions之前，设置需要的MeasuredPower, 默认 -59
 */
- (void)setRangedNearByPhoneMeasuredPower:(NSInteger)phoneMeasuredPower;

/*!
 *  @method setRangedNearByTriggerThreshold
 *
 *  @param  triggerThreshold  触发门限
 *
 *  @discussion     在调用startRangedNearBySKYBeaconsInRegions之前，设置触发推送的门限值, SKYBeaconNearbyThreshold类型 ,默认SKYBeaconNearbyThresholdNEAR_1_METER，1米触发
 */
- (void)setRangedNearByTriggerThreshold:(SKYBeaconNearbyThreshold)triggerThreshold;

/*!
 *  @method stopRangingSKYBeaconsInRegions
 *
 *  @param  regions     范围扫描的区域集合 （由 SKYBeaconRegion 对象组成的数组）
 *
 *  @discussion     停止范围扫描
 */
- (void)stopRangingSKYBeaconsInRegions:(NSArray *)regions;

/*!
 *  @method startMonitoringForSKYBeaconRegions:delegate
 *  
 *  @param  regions     想要监听的区域集合 （由 SKYBeaconRegion 对象组成的数组）
 *  @param  delegate    回调
 *
 *  @discussion     开启监听区域，进、出某区域会接收到 skyBeaconManagerDidEnterRegion、skyBeaconManagerDidExitRegion 的回调
 */
- (void)startMonitoringForSKYBeaconRegions:(NSArray *)regions delegate:(id<SKYBeaconManagerMonitorDelegate>)delegate;

/*!
 *  @method stopMonitorForSKYBeaconRegions:
 *
 *  @param  regions     想要停止监听的区域集合 （由 SKYBeaconRegion 对象组成的数组）
 *
 *  @discussion     停止监听区域
 */
- (void)stopMonitorForSKYBeaconRegions:(NSArray *)regions;

/*!
 *  @method isConnect
 *
 *  @discussion     是否连接设备
 */
- (BOOL)isConnect;

/*!
 *  @method connectBeacon:completion:
 *
 *  @param beacon       用于连接的寻息Beacon (目前有SKYBeacon、SKYBeaconMutipleID)
 *  @param completion   连接成功的block返回
 *
 *  @discussion 连接寻息Beacon,（暂时弃用,后期会加上）
 *
 */
//- (void)connectBeacon:(id)beacon completion:(BOOL complete, NSError* error, id obj)completion;


/*!
 *  @method getBeaconTypeWithhardwareVersion:firmwareVersionMajor:firmwareVersionMinor
 *
 *  @param 获取beacon版本号
 *
 *  @return beacon版本号的枚举值
 *
 *  @discussion 根据硬件版本号，软件版本号（主，次），判断beacon版本号
 *
 */
- (enum SKYBeaconVersion)getBeaconTypeWithhardwareVersion:(NSString *)hardwareVersion firmwareVersionMajor:(NSString *)firmwareVersionMajor firmwareVersionMinor:(NSString *)firmwareVersionMinor;



@end
