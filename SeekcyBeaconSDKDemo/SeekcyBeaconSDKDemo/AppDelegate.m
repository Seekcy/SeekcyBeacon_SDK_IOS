//
//  AppDelegate.m
//  SeekcyBeaconSDKDemo
//
//  Created by seekcy on 15/6/17.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "AppDelegate.h"
@import CoreLocation;
//#import <SeekcyBeaconSDK/SeekcyBeaconSDK.h>

@interface AppDelegate ()<CLLocationManagerDelegate>

@property CLLocationManager *locationManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    //[SKYBeaconSDK registerAPP:@""];
    
    
//    self.locationManager = [[CLLocationManager alloc] init];
//    self.locationManager.delegate = self;
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
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



//- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
//{
//    /*
//     A user can transition in or out of a region while the application is not running. When this happens CoreLocation will launch the application momentarily, call this delegate method and we will let the user know via a local notification.
//     */
//    UILocalNotification *notification = [[UILocalNotification alloc] init];
//    
//    if(state == CLRegionStateInside)
//    {
//        notification.alertBody = NSLocalizedString(@"You're inside the region", @"");
//    }
//    else if(state == CLRegionStateOutside)
//    {
//        notification.alertBody = NSLocalizedString(@"You're outside the region", @"");
//    }
//    else
//    {
//        return;
//    }
//    
//    /*
//     If the application is in the foreground, it will get a callback to application:didReceiveLocalNotification:.
//     If it's not, iOS will display the notification to the user.
//     */
//    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
//}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // If the application is in the foreground, we will notify the user of the region's state via an alert.
    NSString *cancelButtonTitle = NSLocalizedString(@"OK", @"Title for cancel button in local notification");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:notification.alertBody message:nil delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    [alert show];
}


@end
