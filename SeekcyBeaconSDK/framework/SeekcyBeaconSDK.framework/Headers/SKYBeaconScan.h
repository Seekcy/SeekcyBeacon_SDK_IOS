//
//  SKYBeaconScan.h
//  SeekcyBeaconSDK
//
//  Created by seekcy on 15/6/29.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import <Foundation/Foundation.h>

/// SKYBeaconScan
/*
 *  SKYBeaconScan
 *
 *  Discussion:
 *    用于扫描 SKYBeaconManager类中扫描寻息beacon方法 startScanForSKYBeaconWithDelegate:uuids: 时, uuids参数。
 *
 */
@interface SKYBeaconScan : NSObject

/*!
 *  @property uuid
 *
 *  @discussion 指定扫描uuid
 *
 */
@property (nonatomic, strong) NSString *uuid;

/*!
 *  @property name
 *
 *  @discussion 指定扫描后显示的name
 *
 */
@property (nonatomic, strong) NSString *name;

/*!
 *  @method initWithuuid:name:
 *
 *  @param uuid        扫描的uuid
 *  @param name     uuid对应显示的name
 *
 *  @discussion    初始化，指定 uuid，name 参数。
 *
 */
- (instancetype)initWithuuid:(NSString *)uuid name:(NSString *)name;

@end
