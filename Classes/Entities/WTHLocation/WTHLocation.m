//
//  WTHLocation.m
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/8/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#import "WTHLocation.h"


const struct WTHLocationAttributes WTHLocationAttributes = {
    .locationId = @"locationId",
    .name = @"name",
    .isSeleceted = @"isSeleceted",
};

static NSString * const WTHLocationIdKey = @"LocationId";
static NSString * const WTHLocationNameKey = @"LocationName";
static NSString * const WTHLocationIsSelectedKey = @"LocationIsSelected";


@implementation WTHLocation

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.locationId = dictionary[WTHLocationIdKey];
        self.name = dictionary[WTHLocationNameKey];
        self.isSeleceted = [dictionary[WTHLocationIsSelectedKey] boolValue];
    }
    return self;
}

+ (instancetype)locationWithDictionary:(NSDictionary *)dictionary
{
    return [[WTHLocation alloc] initWithDictionary:dictionary];
}

- (NSDictionary *)dictionary
{
    NSDictionary *dictionary = @{WTHLocationIdKey         : self.locationId,
                                 WTHLocationNameKey       : self.name,
                                 WTHLocationIsSelectedKey : @(self.isSeleceted)};
    return dictionary;
}

@end
