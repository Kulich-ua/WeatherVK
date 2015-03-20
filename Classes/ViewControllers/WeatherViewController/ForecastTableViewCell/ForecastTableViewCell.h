//
//  ForecastTableViewCell.h
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/9/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTHHourlyForecast.h"

FOUNDATION_EXPORT NSString * const ForecastTableViewCellReuseIdentifier;


@interface ForecastTableViewCell : UITableViewCell

@property (strong, nonatomic) WTHHourlyForecast *hourlyForecast;

@end
