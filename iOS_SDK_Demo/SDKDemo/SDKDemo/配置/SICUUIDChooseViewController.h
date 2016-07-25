//
//  SICUUIDChooseViewController.h
//  SeekcyIBeaconConfig
//
//  Created by metRooooo on 15/6/12.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SICBaseViewController.h"

@interface SICUUIDChooseViewController : SICBaseViewController{
    void (^chooseUUIDBlock)(NSString *);
}

- (void)chooseUUIDBlock:(void(^)(NSString *uuidString))block;

@property (nonatomic, strong) NSString *selectedUUIDString;

@end
