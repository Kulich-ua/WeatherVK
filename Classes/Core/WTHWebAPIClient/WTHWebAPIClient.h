//
//  WTHWebAPIClient.h
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/8/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTHLocation.h"


typedef void(^WTHSuccessBlock)(NSArray *forecastsArray);
typedef void(^WTHFailureBlock)(NSError *error);


@interface WTHWebAPIClient : NSObject

+ (instancetype)sharedInstance;

- (void)requestWeatherWithLocation:(WTHLocation *)location success:(WTHSuccessBlock)success failure:(WTHFailureBlock)failure;


@end
