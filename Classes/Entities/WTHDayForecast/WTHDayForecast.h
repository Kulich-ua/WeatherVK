//
//  WTHForecast.h
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/9/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTHLocation.h"


@interface WTHDayForecast : NSObject

@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSArray *hourlyForecasts;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)dayForecastWithDictionary:(NSDictionary *)dictionary;

@end
