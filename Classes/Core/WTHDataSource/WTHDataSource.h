//
//  WTHDataSource.h
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/8/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTHDataSource : NSObject

+ (instancetype)sharedInstance;

- (BOOL)saveAllLocations;
- (NSArray *)allLocations;
- (NSArray *)selectedLocations;

@end
