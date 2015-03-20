//
//  WeatherCollectionViewController.m
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/8/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#import "WeatherViewController.h"
#import "ForecastTableViewCell.h"
#import "WTHMacroDefinitions.h"
#import "WTHWebAPIClient.h"
#import "WTHDayForecast.h"
#import "WTHHourlyForecast.h"


@interface WeatherViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) NSArray *forecasts;

@end


@implementation WeatherViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:ForecastTableViewCellReuseIdentifier bundle:nil] forCellReuseIdentifier:ForecastTableViewCellReuseIdentifier];
}


#pragma mark - IBActions

- (IBAction)refreshButtonTouched:(UIBarButtonItem *)sender
{
    [self reloadWeatherData];
}


#pragma mark - Public Interface

- (void)setLocation:(WTHLocation *)location
{
    _location = location;
    
    self.title = location.name;
    
    [self reloadWeatherData];
}

- (void)setForecasts:(NSArray *)forecasts
{
    _forecasts = forecasts;
    
    [self.tableView reloadData];
}


#pragma mark - Internal functionality

- (void)reloadWeatherData
{
    if (self.activityIndicator.isAnimating || !self.location) return;
    
    [self.activityIndicator startAnimating];
    
    __weak typeof(self) weakSelf = self;
    
    [[WTHWebAPIClient sharedInstance] requestWeatherWithLocation:self.location success:^(NSArray *forecasts) {
        weakSelf.forecasts = forecasts;
        [weakSelf.activityIndicator stopAnimating];
    } failure:^(NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:TR(@"general.connection.error") message:error.localizedDescription delegate:nil cancelButtonTitle:TR(@"general.ok") otherButtonTitles:nil];
        [alertView show];
        [weakSelf.activityIndicator stopAnimating];
        NSLog(@"Error: %@", error.localizedDescription);
    }];
}


#pragma mark - UITableViewDelegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.forecasts.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WTHDayForecast *forecast = self.forecasts[section];
    return forecast.hourlyForecasts.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    WTHDayForecast *forecast = self.forecasts[section];
    return forecast.date;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WTHDayForecast *forecast = self.forecasts[indexPath.section];
    WTHHourlyForecast *hourlyForecast = forecast.hourlyForecasts[indexPath.row];

    ForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ForecastTableViewCellReuseIdentifier forIndexPath:indexPath];
    cell.hourlyForecast = hourlyForecast;
    return cell;
}

@end
