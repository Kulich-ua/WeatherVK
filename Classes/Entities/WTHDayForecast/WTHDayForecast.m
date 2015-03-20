//
//  WTHForecast.m
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/9/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#import "WTHDayForecast.h"
#import "WTHHourlyForecast.h"

static NSString * const WTHDayForecastJSONDateKey = @"date";
static NSString * const WTHDayForecastJSONHourlyKey = @"hourly";


@implementation WTHDayForecast

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.date = dictionary[WTHDayForecastJSONDateKey];
        
        NSArray *hourlyForecastsDictionaries = dictionary[WTHDayForecastJSONHourlyKey];
        NSMutableArray *hourlyForecasts = [NSMutableArray arrayWithCapacity:[hourlyForecastsDictionaries count]];
        for (NSDictionary *hourlyForecastsDictionary in hourlyForecastsDictionaries) {
            WTHHourlyForecast *hourlyForecast = [WTHHourlyForecast hourlyForecastWithDictionary:hourlyForecastsDictionary];
            [hourlyForecasts addObject:hourlyForecast];
        }
        self.hourlyForecasts = hourlyForecasts;
    }
    return self;
}

+ (instancetype)dayForecastWithDictionary:(NSDictionary *)dictionary
{
    return [[WTHDayForecast alloc] initWithDictionary:dictionary];
}


@end
