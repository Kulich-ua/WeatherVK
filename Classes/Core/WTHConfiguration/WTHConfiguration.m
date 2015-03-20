//
//  WTHConfiguration.m
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/9/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#import "WTHConfiguration.h"
#import "WTHMacroDefinitions.h"

static NSString * const WTHConfigurationTimeIntervalKey = @"WTHConfigurationTimeIntervalKey";
static NSString * const WTHConfigurationNumberOfDaysKey = @"WTHConfigurationNumberOfDaysKey";

static NSInteger const WTHConfigurationTimeIntervalDefaultValue = 6;
static NSInteger const WTHConfigurationNumberOfDaysDefaultValue = 5;


@interface WTHConfiguration ()

@property (strong, nonatomic) NSUserDefaults *userDefaults;

@end


@implementation WTHConfiguration

SYNTHESIZE_SINGLETON_FOR_CLASS(WTHConfiguration);

- (NSInteger)timeInterval
{
    NSString *key = WTHConfigurationTimeIntervalKey;
    if ([self.userDefaults integerForKey:key] <= 0) {
        [self.userDefaults setInteger:WTHConfigurationTimeIntervalDefaultValue forKey:key];
        [self.userDefaults synchronize];
    }
    return [self.userDefaults integerForKey:key];
}

- (void)setTimeInterval:(NSInteger)timeInterval
{
    NSString *key = WTHConfigurationTimeIntervalKey;
    [self.userDefaults setInteger:timeInterval forKey:key];
    [self.userDefaults synchronize];
}

- (NSInteger)numberOfDays
{
    NSString *key = WTHConfigurationNumberOfDaysKey;
    if ([self.userDefaults integerForKey:key] <= 0) {
        [self.userDefaults setInteger:WTHConfigurationNumberOfDaysDefaultValue forKey:key];
        [self.userDefaults synchronize];
    }
    return [self.userDefaults integerForKey:key];
}

- (void)setNumberOfDays:(NSInteger)numberOfDays
{
    NSString *key = WTHConfigurationNumberOfDaysKey;
    [self.userDefaults setInteger:numberOfDays forKey:key];
    [self.userDefaults synchronize];
}

#pragma mark - Accessors

- (NSUserDefaults *)userDefaults
{
    if (!_userDefaults) _userDefaults = [NSUserDefaults standardUserDefaults];
    return _userDefaults;
}

@end
