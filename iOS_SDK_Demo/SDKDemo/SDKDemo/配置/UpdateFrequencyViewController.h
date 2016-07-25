//
//  UpdateFrequencyViewController.h
//  SeekcyIBeaconConfig
//
//  Created by seekcy on 15/8/3.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateFrequencyViewController : UITableViewController{
    void (^chooseValueBlock)(NSString *);
}

@property (nonatomic, strong) NSString *selectedValue;

- (void)chooseValueBlock:(void(^)(NSString *valueString))block;

@end
