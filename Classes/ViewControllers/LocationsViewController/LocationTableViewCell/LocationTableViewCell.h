//
//  LocationTableViewCell.h
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/8/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTHLocation.h"

FOUNDATION_EXPORT NSString * const LocationTableViewCellReuseIdentifier;


@interface LocationTableViewCell : UITableViewCell

@property (strong, nonatomic) WTHLocation *location;

@end
