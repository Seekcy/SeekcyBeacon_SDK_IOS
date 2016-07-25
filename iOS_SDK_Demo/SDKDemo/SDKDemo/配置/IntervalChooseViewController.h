//
//  IntervalChooseViewController.h
//  SeekcyIBeaconConfig
//
//  Created by seekcy on 15/7/21.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SICBaseViewController.h"

@interface IntervalChooseViewController : SICBaseViewController{
    void (^chooseIntervalBlock)(NSString *);
}

- (void)chooseIntervalBlock:(void(^)(NSString *intervalString))block;

@property (nonatomic, strong) NSString *defaultInterval;

@end
