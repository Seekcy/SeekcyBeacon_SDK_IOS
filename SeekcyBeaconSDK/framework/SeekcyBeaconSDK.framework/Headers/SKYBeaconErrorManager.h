//
//  SKYBeaconManagerScanError.h
//  SeekcyBeaconSDK
//
//  Created by seekcy on 15/7/2.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const SKYBeaconSDKErrorDomain;

enum SKYBeaconSDKError{
    // bluetooth
    SKYBeaconSDKErrorBlueToothUnknown = 1001,
    SKYBeaconSDKErrorBlueToothResetting,
    SKYBeaconSDKErrorBlueToothUnsupported,
    SKYBeaconSDKErrorBlueToothUnauthorized,
    SKYBeaconSDKErrorBlueToothPoweredOff,
    
    // 检查错误
    SKYBeaconSDKErrorCheckBeaconInvalid = 2000, // 传入beacon无效
    SKYBeaconSDKErrorCheckBeaconNone = 2001, // 无写入的Beacon，检查是否连接上Beacon
    SKYBeaconSDKErrorCheckMajorOutOfRange = 2002, // major超出最大允许范围(0~65535)
    SKYBeaconSDKErrorCheckMinorOutOfRange = 2003, // minor超出最大允许范围(0~65535)
    SKYBeaconSDKErrorChecktxPowerOutOfRange = 2004, // txPower必须是4、0、-2、-4、-6、-8、-10、-12、-14、-16、-18、-20、-23
    SKYBeaconSDKErrorCheckDeviceNameEmpty = 2005, // device name不能为空
    SKYBeaconSDKErrorCheckDeviceNameOutOfRange = 2006, // device name不能超过20个字符
    SKYBeaconSDKErrorCheckDeviceNameUnableParse = 2007, // device name无法解析
    SKYBeaconSDKErrorCheckUUIDEmpty = 2008, // uuid 为空
    SKYBeaconSDKErrorCheckPassCodeEmpty = 2009, // 防篡改密密钥为空，开启防篡改模式请填写防篡改密钥
    SKYBeaconSDKErrorCheckMeasuredPowerOutOfRange = 2010,
    SKYBeaconSDKErrorCheckCellUseOfMustContinuity, // 格子使用必须是连续的
    SKYBeaconSDKErrorCheckCellUseOfOutOfBroadcastID,
    // 写数据返回错误
    SKYBeaconSDKErrorConfigurationNotComplete = 3001, // 配置未完成
    SKYBeaconSDKErrorPasskeyValidationFailed = 3002,  // PassKey校验失败
    SKYBeaconSDKErrorSOFValidationFailed = 3003,// 帧头校验失败
    
    // other
    SKYBeaconSDKErrorWriteError = 99998,// 写入数据错误
    SKYBeaconSDKErrorNoneToWrite = 99999  // 无配置的东西
};

/// SKYBeaconManagerError
@interface SKYBeaconErrorManager : NSObject

/*!
 *  @method skyBeaconErrorWithErrorCode:errorString
 *
 *  @param errorCode    错误码
 *  @param errorString  错误信息
 *
 *  @return NSError对象
 *
 *  @discussion    根据错误码和错误信息，返回一个NSError对象
 *
 */
+ (NSError *)skyBeaconErrorWithErrorCode:(int)errorCode;

@end
