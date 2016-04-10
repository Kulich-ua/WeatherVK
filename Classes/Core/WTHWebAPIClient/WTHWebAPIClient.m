//
//  WTHWebAPIClient.m
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/8/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#import "WTHWebAPIClient.h"
#import "WTHMacroDefinitions.h"
#import "WTHConfiguration.h"
#import "WTHDayForecast.h"
#import "WTHHourlyForecast.h"


static NSString * const WTHWebAPIBaseURL = @"http://api.worldweatheronline.com/free/v2/weather.ashx";
static NSString * const WTHWebAPIKey = @"8864a48fd39ae8b0c741aac8672f9";

static NSString * const WTHWebAPIJSONDataKey = @"data";
static NSString * const WTHWebAPIJSONWeatherKey = @"weather";


@implementation WTHWebAPIClient

SYNTHESIZE_SINGLETON_FOR_CLASS(WTHWebAPIClient);

- (void)requestWeatherWithLocation:(WTHLocation *)location success:(WTHSuccessBlock)success failure:(WTHFailureBlock)failure;
{
    NSURL *url = [WTHWebAPIClient urlWithLocation:location];
    NSURLSessionDataTask *dataTask = [self.urlSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
        
        NSError *jsonParsingError = nil;
        NSMutableArray *forecastsArray = nil;
        
        if (data) {
            
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:&jsonParsingError];
            NSDictionary *dataDictionary = responseDictionary[WTHWebAPIJSONDataKey];
            NSArray *forecastDictionariesArray = dataDictionary[WTHWebAPIJSONWeatherKey];
            
            forecastsArray = [NSMutableArray arrayWithCapacity:[forecastDictionariesArray count]];
            
            for (NSDictionary *forecastDictionary in forecastDictionariesArray) {
                
                WTHDayForecast *dayForecast = [WTHDayForecast dayForecastWithDictionary:forecastDictionary];
                [forecastsArray addObject:dayForecast];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (connectionError) {
                failure(connectionError);
            } else {
                if (jsonParsingError) {
                    failure(connectionError);
                } else {
                    success(forecastsArray);
                }
            }
        });
    }];
    [dataTask resume];
}

+ (NSURL *)urlWithLocation:(WTHLocation *)loaction
{
    WTHConfiguration *configuration = [WTHConfiguration sharedInstance];
    NSString *urlString = [NSString stringWithFormat:@"%@?q=%@&format=json&num_of_days=%ld&cc=no&tp=%ld&key=%@", WTHWebAPIBaseURL, loaction.locationId, (long)configuration.numberOfDays, (long)configuration.timeInterval, WTHWebAPIKey];
    return [NSURL URLWithString:urlString];
}

#pragma mark - Accessors

- (NSURLSession *)urlSession
{
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.URLCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
        session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    });
    return session;
}


@end
