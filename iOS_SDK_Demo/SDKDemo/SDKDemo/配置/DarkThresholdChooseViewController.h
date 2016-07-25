//
//  DarkThresholdChooseViewController.h
//  SeekcyIBeaconConfig
//
//  Created by seekcy on 15/8/3.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DarkThresholdChooseViewController : UITableViewController{
    void (^chooseDarkThresholdBlock)(NSString *);
}

@property (nonatomic, strong) NSString *selectedValue;

- (void)chooseDarkThresholdBlock:(void(^)(NSString *darkThresholdString))block;

@end
