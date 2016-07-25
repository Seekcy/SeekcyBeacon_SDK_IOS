//
//  SKYPosition.h
//  SeekcyBeaconSDK
//
//  Created by seekcy on 15/8/10.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKYPosition : NSObject

@property (nonatomic, strong) NSString *accuracy;

@property (nonatomic, strong) NSString *buildID;

@property (nonatomic) int errorCode;

@property (nonatomic, strong) NSString *info;

@property (nonatomic) int floorID;

@property (nonatomic) long timeStampMillisecond;

@property (nonatomic) double x;

@property (nonatomic) double y;

@property (nonatomic, strong) NSString *userID;

@property (nonatomic) BOOL sensorValid;

@property (nonatomic) double compass;

@end
