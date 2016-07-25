//
//  AppDelegate.m
//  SDKDemo
//
//  Created by seekcy on 15/9/30.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "AppDelegate.h"
@import SeekcyBeaconSDK;

@interface AppDelegate ()<SKYBeaconManagerMonitorDelegate,SKYBeaconManagerScanDelegate,SKYBeaconManagerRangingDelegate>{
    int count;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setBarTintColor:kMainNavColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
//    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:@[@"1",@"2",@"3",@"4",@"5"]];
//    int aCount  =  2;
//    [array removeObjectsInRange:NSMakeRange(0, (array.count - aCount))];
    
    
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
    count = 0;
    [self testing];
    
    
//    NSMutableArray *scanUUIDArray = [[NSMutableArray alloc] init];
//    [scanUUIDArray addObject:[[SKYBeaconScan alloc] initWithuuid:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0" name:@"苹果默认"]];
//    [scanUUIDArray addObject:[[SKYBeaconScan alloc] initWithuuid:@"FDA50693-A4E2-4FB1-AFCF-C6EB07647825" name:@"微信摇一摇"]];
//    // 用于解密mac地址
//    [SKYBeaconManager sharedDefaults].seekcyDecryptKey = @""; // 你的解密密钥
//    [SKYBeaconManager sharedDefaults].scanBeaconTimeInterval = 1.2;
//    [[SKYBeaconManager sharedDefaults] startScanForSKYBeaconWithDelegate:self uuids:scanUUIDArray distinctionMutipleID:NO isReturnValueEncapsulation:NO];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)testing{
    BOOL notifyOnEntry = YES;
    BOOL notifyOnExit = YES;
    NSString *uuid = @"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0";//@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0";//@"FDA50693-A4E2-4FB1-AFCF-C6EB07647825";
    NSString *notifyIdentifier = @"monitor test";
    NSString *major = @"1";
    NSString *minor = @"2";
    
    SKYBeaconRegion *region = [[SKYBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:uuid] major:[major intValue] minor:[minor intValue]  identifier:notifyIdentifier];
    
//    SKYBeaconRegion *region = [[SKYBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:uuid] identifier:notifyIdentifier];
    
    
    if(region != nil){
        [[SKYBeaconManager sharedDefaults] stopMonitorForSKYBeaconRegions:@[region]];
    }
    
    if(notifyOnEntry || notifyOnExit){
        region = nil;
        
        if(uuid != nil && ![uuid isEqualToString:@""]){
            region = [[SKYBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:uuid] major:[major intValue] minor:[minor intValue]  identifier:notifyIdentifier];
        }
        
        if(region){
            
            region.notifyEntryStateOnDisplay = YES;
            region.notifyOnEntry = notifyOnEntry;
            region.notifyOnExit = notifyOnExit;
            
            [[SKYBeaconManager sharedDefaults] startMonitoringForSKYBeaconRegions:@[region] delegate:self];
        }
    }
    else{
        [[SKYBeaconManager sharedDefaults] stopMonitorForSKYBeaconRegions:@[region]];
    }
    
    
    //  NSTimer *timer =
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}


- (void)timerFired:(NSTimer *)timer{
    count ++;
    NSLog(@"%d",count);
}

#pragma mark - SKYBeaconManagerMonitorDelegate
- (void)skyBeaconManagerDidEnterRegion:(CLRegion *)region{
    NSLog(@"%@",[NSString stringWithFormat:@"您进入区域: %@",region.identifier]);
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = [NSString stringWithFormat:@"您进入区域: %@",region.identifier];
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    
    NSString *uuid = @"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0";//@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0";//@"FDA50693-A4E2-4FB1-AFCF-C6EB07647825";
    NSString *notifyIdentifier = @"aaaaaa test";
    NSString *major = @"1";
    NSString *minor = @"2";
    
    SKYBeaconRegion *regionnnn = [[SKYBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:uuid] identifier:notifyIdentifier];
    [[SKYBeaconManager sharedDefaults] startRangingSKYBeaconsInRegions:@[regionnnn] delegate:self];

}

- (void)skyBeaconManagerDidExitRegion:(CLRegion *)region{
    NSLog(@"%@",[NSString stringWithFormat:@"您离开区域: %@",region.identifier]);
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = [NSString stringWithFormat:@"您离开区域: %@",region.identifier];
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}


- (void)skyBeaconManagerDidRangeBeacons:(NSArray *)beacons inRegion:(SKYBeaconRegion *)region{
    
    NSLog(@"-- aaa  skyBeaconManagerDidRangeBeacons  --");
    NSLog(@"扫描到：%lu 个",(unsigned long)beacons.count);
}

#pragma mark - SKYBeaconManagerScanDelegate
- (void)skyBeaconManagerCompletionScanWithBeacons:(NSArray *)beascons error:(NSError *)error{
    
    if(error){
        
        if(error.code == SKYBeaconSDKErrorBlueToothPoweredOff){
//            [SVProgressHUD showErrorWithStatus:error.userInfo[@"error"] maskType:SVProgressHUDMaskTypeBlack];
            
        }
        return;
    }
    
    
    NSLog(@"--skyBeaconManagerCompletionScanWithBeacons--");
    NSLog(@"扫描到：%lu 个",(unsigned long)beascons.count);
    
}

@end
