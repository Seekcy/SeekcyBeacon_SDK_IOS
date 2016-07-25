//
//  SKYLightSensation.h
//  SeekcyBeaconSDK
//
//  Created by seekcy on 15/8/3.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKYLightSensation : NSObject

/*!
 *  @property isOn
 *
 *  @discussion 光感是否开启
 *
 */
@property (nonatomic) BOOL isOn;

/*!
 *  @property darkThreshold
 *
 *  @discussion 黑暗阈值, 取值范围1~5,值越大代表判定为黑暗的亮度越高
 *
 */
@property (nonatomic, strong) NSString *darkThreshold;

/*!
 *  @property darkBroadcastFrequency
 *
 *  @discussion 黑暗广播频率,单位 50ms,配置范围为2~200（100ms~10s）
 *
 */
@property (nonatomic, strong) NSString *darkBroadcastFrequency;

/*!
 *  @property voltage
 *
 *  @discussion 光感电压值
 *
 */
@property (nonatomic, strong) NSString *voltage;

/*!
 *  @property updateFrequency
 *
 *  @discussion 光感值更新频率,单位s
 *
 */
@property (nonatomic, strong) NSString *updateFrequency;


@end
