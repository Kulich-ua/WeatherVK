//
//  WTHHourlyForecast.m
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/9/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#import "WTHHourlyForecast.h"

static NSString * const WTHHourlyForecastJSONValueKey = @"value";
static NSString * const WTHHourlyForecastJSONWeatherDescriptionKey = @"weatherDesc";
static NSString * const WTHHourlyForecastJSONWeatherIconURLKey = @"weatherIconUrl";
static NSString * const WTHHourlyForecastJSONTempratureCKey = @"tempC";
static NSString * const WTHHourlyForecastJSONTimeKey = @"time";

static NSString * const WTHHourlyJSONTimeFormatterKey = @"WTHHourlyJSONTimeFormatterKey";
static NSString * const WTHHourlyHumanTimeFormatterKey = @"WTHHourlyHumanTimeFormatterKey";


@implementation WTHHourlyForecast

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.weatherDescription = [dictionary[WTHHourlyForecastJSONWeatherDescriptionKey] firstObject][WTHHourlyForecastJSONValueKey];
        
        NSString *weatherIconURLString = [dictionary[WTHHourlyForecastJSONWeatherIconURLKey] firstObject][WTHHourlyForecastJSONValueKey];
        self.weatherIconURL = [NSURL URLWithString:weatherIconURLString];
        
        self.temperature = dictionary[WTHHourlyForecastJSONTempratureCKey];
        
        NSString *jsonTimeString = dictionary[WTHHourlyForecastJSONTimeKey];
        if (jsonTimeString.length < 4) jsonTimeString = [NSString stringWithFormat:@"%0*d", 4, [jsonTimeString intValue]];
        NSDate *date = [[WTHHourlyForecast jsonDateFormmatter] dateFromString:jsonTimeString];
        
        self.time = [[WTHHourlyForecast humanDateFormmatter] stringFromDate:date];
    }
    return self;
}

+ (instancetype)hourlyForecastWithDictionary:(NSDictionary *)dictionary
{
    return [[WTHHourlyForecast alloc] initWithDictionary:dictionary];
}


#pragma mark - Accessors

+ (NSDateFormatter *)jsonDateFormmatter
{
    return [WTHHourlyForecast cachedDateFormatterWithKey:WTHHourlyJSONTimeFormatterKey];
}

+ (NSDateFormatter *)humanDateFormmatter
{
    return [WTHHourlyForecast cachedDateFormatterWithKey:WTHHourlyHumanTimeFormatterKey];
}


+ (NSDateFormatter *)cachedDateFormatterWithKey:(NSString *)key
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = [threadDictionary objectForKey:key];
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
        if ([key isEqualToString:WTHHourlyJSONTimeFormatterKey]) dateFormatter.dateFormat = @"HHmm";
        if ([key isEqualToString:WTHHourlyHumanTimeFormatterKey]) dateFormatter.dateFormat = @"HH:mm";
        [threadDictionary setObject:dateFormatter forKey:key];
    }
    return dateFormatter;
}

@end
