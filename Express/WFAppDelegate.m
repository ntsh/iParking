//
//  WFAppDelegate.m
//  Express
//
//  Created by NG on 20/09/14.
//  Copyright (c) 2014 Neetesh Gupta. All rights reserved.
//

#import "WFAppDelegate.h"
#import <AudioToolbox/AudioServices.h>
#import "WFViewController.h"

@implementation WFAppDelegate
{
    CLLocationManager *locationManager;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"App launched");
        //[self playSound];
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    [self registerBeaconWithId:@"WestField Blue" andMinor:30];
    [self registerBeaconWithId:@"WestField Black" andMinor:29];
    [self registerBeaconWithId:@"WestField White" andMinor:31];

    /*CLBeaconRegion *region, *region1;
    region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"61687109-905F-4436-91F8-E602F514C96D"] major:3 minor:3330 identifier: @"WestField Blue"];
    region.notifyEntryStateOnDisplay = YES;
    [locationManager startMonitoringForRegion:region];
    [locationManager startRangingBeaconsInRegion:region];

    region1 = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"61687109-905F-4436-91F8-E602F514C96D"] major:3 minor:3329 identifier: @"WestField Black"];
    region1.notifyEntryStateOnDisplay = YES;
    [locationManager startMonitoringForRegion:region1];
    [locationManager startRangingBeaconsInRegion:region1];*/


    /*CLBeaconRegion *region1 = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"F7826DA6-AFA2-4E98-8024-BC5B71E0893E"] identifier: @"kontakt"];
     region1.notifyEntryStateOnDisplay = YES;
     [locationManager startMonitoringForRegion:region1];
     [locationManager startRangingBeaconsInRegion:region1];*/

    return YES;
}

- (void)registerBeaconWithId:(NSString*)identifier andMinor:(int)minor
{
    CLBeaconRegion *region;
    region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"00000000-0000-0000-0000-000000000000"] major:3 minor:minor identifier: identifier];
    region.notifyEntryStateOnDisplay = YES;
    [locationManager startMonitoringForRegion:region];
    [locationManager startRangingBeaconsInRegion:region];
}

- (void)locationManager:(CLLocationManager *)manager
      didDetermineState:(CLRegionState)state
              forRegion:(CLRegion *)region
{

    if(state == CLRegionStateInside) {
        NSLog(@"didDetermineState INSIDE for %@", region.identifier);
    }
    else if(state == CLRegionStateOutside) {
        NSLog(@"didDetermineState OUTSIDE for %@", region.identifier);
    }
    else {
        NSLog(@"didDetermineState OTHER for %@", region.identifier);
    }
}

- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLBeaconRegion *)region
{
    NSLog(@"Did Enter Region for %@, minor:%@", region.identifier, region.minor);
    NSString* str = [NSString stringWithFormat:@"You are parked at %@, Gate No. %d. ",
                     region.identifier, ([region.minor intValue]%10) +1];
    [self showNotif:str];
    NSLog(@"%@",str);
    [self loadWebPage:@"page8"];

}

- (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLBeaconRegion *)region
{
    NSString *str = [NSString stringWithFormat:@"Thank you for visiting %@.",region.identifier];
    [self showNotif:str];
    NSLog(@"%@",str);
}


- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    for(int i=0; i<[beacons count]; i++) {
        [self playSound];
        CLBeacon *beacon = beacons[i];
        NSLog(@"%@,major:%@,minor:%@,Acc:%f,Prox:%d,RSSID:%ld", region.identifier, beacon.major, beacon.minor, beacon.accuracy, (int)beacon.proximity, (long)beacon.rssi);
            //[self syncToServer:beacon];
    }
}

- (void)playSound
{
    AudioServicesPlaySystemSound(0x450);
}

- (void) showNotif:(NSString *)notif
{
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    notification.alertBody = notif;
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber++;
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)loadWebPage:(NSString*)page
{
    WFViewController *homeView = (WFViewController*)self.window.rootViewController;
    [homeView loadWebPage:page];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
