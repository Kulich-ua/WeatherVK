//
//  WTHHourlyForecast.h
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/9/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTHHourlyForecast : NSObject

@property (strong, nonatomic) NSString *weatherDescription;
@property (strong, nonatomic) NSURL *weatherIconURL;
@property (strong, nonatomic) NSString *temperature;
@property (strong, nonatomic) NSString *time;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)hourlyForecastWithDictionary:(NSDictionary *)dictionary;

@end
