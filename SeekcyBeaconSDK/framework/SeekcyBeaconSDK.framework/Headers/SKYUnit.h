//
//  SKYUnit.h
//  SeekcyBeaconSDK
//
//  Created by seekcy on 16/1/12.
//  Copyright (c) 2016年 com.seekcy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKYUnit : NSObject


+ (int)convertDialogIntervalToShowFormat:(int)writeFormatInterval;


+ (int)convertDialogIntervalToWriteFormat:(int)showFormatInterval;

@end
