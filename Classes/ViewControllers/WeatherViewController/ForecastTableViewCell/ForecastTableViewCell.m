//
//  ForecastTableViewCell.m
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/9/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#import "ForecastTableViewCell.h"
#import "UIImageView+AFNetworking.h"

NSString * const ForecastTableViewCellReuseIdentifier = @"ForecastTableViewCell";


@interface ForecastTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

@end

@implementation ForecastTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setHourlyForecast:(WTHHourlyForecast *)hourlyForecast
{
    _hourlyForecast = hourlyForecast;
    
    self.timeLabel.text = hourlyForecast.time;
    self.descriptionLabel.text = hourlyForecast.weatherDescription;
    self.temperatureLabel.text = [NSString stringWithFormat:@"%@ °C", hourlyForecast.temperature];

    [self.weatherImageView setImageWithURL:hourlyForecast.weatherIconURL];
}

@end
