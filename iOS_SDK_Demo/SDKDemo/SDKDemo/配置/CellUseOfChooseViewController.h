//
//  CellUseOfChooseViewController.h
//  SeekcyBeaconSDKDemo
//
//  Created by seekcy on 15/7/1.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SKYBeaconConfigMutipleID;

@protocol CellUseOfChooseViewControllerDelegate <NSObject>

- (void)selectedIndex:(NSInteger)index;

@end

@interface CellUseOfChooseViewController : UITableViewController

@property (nonatomic, strong) SKYBeaconConfigMutipleID *configBeacon;

@property (nonatomic, weak) id<CellUseOfChooseViewControllerDelegate> delegate;

@end
