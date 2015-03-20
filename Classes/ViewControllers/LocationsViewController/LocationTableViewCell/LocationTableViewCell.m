//
//  LocationTableViewCell.m
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/8/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#import "LocationTableViewCell.h"

NSString * const LocationTableViewCellReuseIdentifier = @"LocationTableViewCell";


@interface LocationTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end


@implementation LocationTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)setLocation:(WTHLocation *)location
{
    _location = location;
    
    self.titleLabel.text = location.name;
}


@end
