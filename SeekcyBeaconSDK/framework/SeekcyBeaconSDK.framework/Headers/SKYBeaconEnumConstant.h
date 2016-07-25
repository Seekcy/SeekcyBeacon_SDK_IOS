//
//  SKYBeaconEnumConstant.h
//  SeekcyBeaconSDK
//
//  Created by seekcy on 15/7/14.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#ifndef SeekcyBeaconSDK_SKYBeaconEnumConstant_h
#define SeekcyBeaconSDK_SKYBeaconEnumConstant_h

enum BeaconConfigState{
    beaconConfigState_wating,
    beaconConfigState_connecting,
    beaconConfigState_connectSuccess,
    beaconConfigState_connectFaild,
    beaconConfigState_configSuccess,
    beaconConfigState_configfaild,
    beaconConfigState_configfaild_noPasskey,
    beaconConfigState_configfaild_unfinished,
    beaconConfigState_configfaild_passkeyVerifyFailed,
    beaconConfigState_configfaild_SOFVerifyFailed
};

enum BeaconConfigStateMutipleID{
    beaconConfigStateMutipleID_wating,
    beaconConfigStateMutipleID_connecting,
    beaconConfigStateMutipleID_connectSuccess,
    beaconConfigStateMutipleID_connectFaild,
    beaconConfigStateMutipleID_configSuccess,
    beaconConfigStateMutipleID_configfaild,
    beaconConfigStateMutipleID_configfaild_noPasskey,
    beaconConfigStateMutipleID_configfaild_unfinished,
    beaconConfigStateMutipleID_configfaild_passkeyVerifyFailed,
    beaconConfigStateMutipleID_configfaild_SOFVerifyFailed
};

// 配置防蹭用类型
enum SKYBeaconEncryptedConfigType{
    SKYBeaconEncryptedConfigTypeNotConfig = -1,
    SKYBeaconEncryptedConfigTypeOff = 0,
    SKYBeaconEncryptedConfigTypeOn = 1
};

/*!
 * 配置时txPower的值
 * 注意：不同版本的beacon对txPower有不同允许范围
        2640 允许范围是:0,1,2,3,4,5,-3,-6,-9,-12,-15,-18,-21
        2541 允许范围是：0,-2,-4,-6,-8,-10
        (单位dBm)
 */
enum SKYBeaconConfigTxPowerValue{
    SKYBeaconConfigTxPowerValue_invalidValue = -99,
    SKYBeaconConfigTxPowerValue_negative_21 = -21,
    SKYBeaconConfigTxPowerValue_negative_20 = -20,
    SKYBeaconConfigTxPowerValue_negative_18 = -18,
    SKYBeaconConfigTxPowerValue_negative_15 = -15,
    SKYBeaconConfigTxPowerValue_negative_12 = -12,
    SKYBeaconConfigTxPowerValue_negative_10 = -10,
    SKYBeaconConfigTxPowerValue_negative_9 = -9,
    SKYBeaconConfigTxPowerValue_negative_8 = -8,
    SKYBeaconConfigTxPowerValue_negative_6 = -6,
    SKYBeaconConfigTxPowerValue_negative_4 = -4,
    SKYBeaconConfigTxPowerValue_negative_3 = -3,
    SKYBeaconConfigTxPowerValue_negative_2 = -2,
    SKYBeaconConfigTxPowerValue_0 = 0,
    SKYBeaconConfigTxPowerValue_1 = 1,
    SKYBeaconConfigTxPowerValue_2 = 2,
    SKYBeaconConfigTxPowerValue_3 = 3,
    SKYBeaconConfigTxPowerValue_4 = 4,
    SKYBeaconConfigTxPowerValue_5 = 5,
};

enum SKYBeaconVersion{
    SKYBeaconVersion_0_1_0_S0 = 0,
    SKYBeaconVersion_1_1_0_M0,
    SKYBeaconVersion_2_1_0_S0P,
    SKYBeaconVersion_3_1_0_M0L,   // 2640
    SKYBeaconVersion_3_1_1_M0L,   // 2640
    SKYBeaconVersion_3_3_0_M0L,   // 多id 2640
    SKYBeaconVersion_5_1_0_S0L,
    SKYBeaconVersion_5_1_1_S0L,   // 2640
    SKYBeaconVersion_6_1_0_K1,    // 2640
    SKYBeaconVersion_0_2_0_S0,    // 多id
    SKYBeaconVersion_0_2_1_S0,    // 多id
    SKYBeaconVersion_5_2_0_S1L,   // 多id 2640
    SKYBeaconVersion_5_3_0_S1L,   // 多id 2640 新的加密算法
    SKYBeaconVersion_6_2_0_K1L,   // 多id 2640
    SKYBeaconVersion_7_1_0_Dialog,
    SKYBeaconVersion_7_3_0_Dialog,
    SKYBeaconVersion_8_1_0_Dialog,
    SKYBeaconVersion_9_1_0_Dialog,
    SKYBeaconVersion_18_1_0_Dialog_T1U
};


// 靠近触发门限枚举
typedef NS_ENUM(NSUInteger, SKYBeaconNearbyThreshold){
    SKYBeaconNearbyThresholdNEAR_1_METER    = 1,    // 1米触发
    SKYBeaconNearbyThresholdNEAR_3_METER,   // 3米触发
    SKYBeaconNearbyThresholdMIDDLE, // 中距离触发
    SKYBeaconNearbyThresholdFAR // 远距离触发
};


#endif
