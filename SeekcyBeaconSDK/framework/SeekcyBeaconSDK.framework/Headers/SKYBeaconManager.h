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
- (void)skyBeaconManagerCompletionScanWithBeacons:(NSArray *)beascons error:(SKYBeaconManagerError *)error;

/*!
 *  @method skyBeaconManagerCompletionScanWithSingleIDBeacons:error
 *
 *  @param beascons  扫描到的寻息beacon数组(单id)
 *  @param error         错误， SKYBeaconManagerError 对象
 *
 *  @discussion      返回扫描结果的delegate
 *
 */
- (void)skyBeaconManagerCompletionScanWithSingleIDBeacons:(NSArray *)beascons error:(SKYBeaconManagerError *)error;

/*!
 *  @method skyBeaconManagerCompletionScanWithMutipleIDBeacons:error
 *
 *  @param beascons  扫描到的寻息beacon数组（多id）
 *  @param error         错误， SKYBeaconManagerError 对象
 *
 *  @discussion      返回扫描结果的delegate
 *
 */
- (void)skyBeaconManagerCompletionScanWithMutipleIDBeacons:(NSArray *)beascons error:(SKYBeaconManagerError *)error;

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
 *  @method sharedDefaults
 *
 *  @discussion 单例
 *
 */
+ (SKYBeaconManager *)sharedDefaults;

/*!
 *  @method startScanForSKYBeacon:uuids:distinctionMutipleID:
 *
 *  @param delegate SKYBeaconManagerScanDelegate, 用于返回扫描结果
 *  @param uuids    指定扫描的uuid列表
 *  @param distinctionMutipleID    返回结果的时候是否区分多id和单id。如果YES,单id Beacon在skyBeaconManagerCompletionScanWithSingleIDBeacons:error: 中返回，多id beacon在skyBeaconManagerCompletionScanWithMutipleIDBeacons:error: 中返。如果NO,全部beacon在skyBeaconManagerCompletionScanWithBeacons:error: 中返回。
 *
 *  @discussion 扫描寻息Beacon (默认1.5秒返回结果)
 */
- (void)startScanForSKYBeaconWithDelegate:(id<SKYBeaconManagerScanDelegate>)delegate uuids:(NSArray *)uuids distinctionMutipleID:(BOOL)distinctionMutipleID;


/*!
 *  @method stopScanSKYBeacon:
 *
 *  @discussion  停止扫描寻息Beacon
 */
- (void)stopScanSKYBeacon;

/*!
 *  @method connectBeacon:completion:
 *
 *  @param beacon       用于连接的寻息Beacon (目前有SKYBeacon、SKYBeaconMutipleID)
 *  @param completion   连接成功的block返回
 *
 *  @discussion 连接寻息Beacon
 *
 */
- (void)connectBeacon:(id)beacon completion:(void(^)(BOOL, NSError *))completion;

/*!
 *  @method cancelBeaconConnection:completion:
 *
 *  @param beacon       用于断开连接的寻息Beacon(目前有SKYBeacon、SKYBeaconMutipleID)
 *  @param completion   断开连接成功的block返回
 *
 *  @discussion 断开连接寻息Beacon
 *
 */
- (void)cancelBeaconConnection:(id)beacon completion:(void(^)(BOOL , NSError *))completion;

/*!
 *  @method writeSingleIDBeaconValues:completion:
 *
 *  @param values       SKYBeaconConfigSingleID对象
 *  @param completion   写入成功的block返回
 *
 *  @discussion 写数据到寻息Beacon
 */
- (void)writeSingleIDBeaconValues:(SKYBeaconConfigSingleID *)values completion:(void(^)(NSError*))completion;

/*!
 *  @method writeMutipleIDBeaconValues:completion:
 *
 *  @param values           SKYBeaconConfigMutipleID 对象
 *  @param completion   写入成功的block返回
 *
 *  @discussion 写数据到寻息Beacon
 */
- (void)writeMutipleIDBeaconValues:(SKYBeaconConfigMutipleID *)values completion:(void(^)(NSError*))completion;

/*!
 *  @method factoryResetMutipleIDBeaconValues:completion:
 *
 *  @param values           SKYBeaconConfigMutipleID 对象
 *  @param completion       写入成功的block返回
 *
 *  @discussion 恢复出厂设置
 *              values 传参例子：（key值参考 SKYBeaconConfigMutipleID.h 中）
 */
- (void)factoryResetMutipleIDBeaconValues:(SKYBeaconConfigMutipleID *)values completion:(void(^)(NSError*))completion;

/*!
 *  @method startRangingSKYBeaconsInRegions
 *
 *  @param  regions     范围扫描的区域集合 （由 SKYBeaconRegion 对象组成的数组）
 *  @param  delegate    回调
 *
 *  @discussion     范围扫描
 */
- (void)startRangingSKYBeaconsInRegions:(NSArray *)regions delegate:(id<SKYBeaconManagerRangingDelegate>)delegate;

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

@end
