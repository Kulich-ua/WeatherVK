//
//  AppDelegate.m
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/8/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#import "AppDelegate.h"
#import "WTHConstants.h"


@interface AppDelegate ()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:WTHNotificationAppBecomeActive object:nil];
}

@end
