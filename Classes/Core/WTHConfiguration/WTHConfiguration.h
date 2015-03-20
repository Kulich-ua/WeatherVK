//
//  WTHConfiguration.h
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/9/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTHConfiguration : NSObject

@property (assign, nonatomic) NSInteger timeInterval;
@property (assign, nonatomic) NSInteger numberOfDays;

+ (instancetype)sharedInstance;

@end
