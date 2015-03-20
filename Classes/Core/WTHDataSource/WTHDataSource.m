//
//  WTHDataSource.m
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/8/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#import "WTHDataSource.h"
#import "WTHMacroDefinitions.h"
#import "WTHLocation.h"

static NSString * const WTHDataSourceFile = @"Locations.plist";


@interface WTHDataSource ()

@property (strong, nonatomic) NSArray *allLocations;

@end


@implementation WTHDataSource

SYNTHESIZE_SINGLETON_FOR_CLASS(WTHDataSource);

- (BOOL)saveAllLocations
{
    NSString *path = [self dataSourcePath];
    NSMutableArray *dictionariesArray = [NSMutableArray arrayWithCapacity:self.allLocations.count];
    for (WTHLocation *location in self.allLocations) {
        NSDictionary *dictionary = [location dictionary];
        [dictionariesArray addObject:dictionary];
    }
    return [dictionariesArray writeToFile:path atomically:YES];
}

- (NSArray *)allLocations
{
    if (!_allLocations) {
        NSString *path = [self dataSourcePath];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            path = [[NSBundle mainBundle] pathForResource:WTHDataSourceFile ofType:nil];
        }
        NSArray *dictionariesArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *locations = [NSMutableArray arrayWithCapacity:[dictionariesArray count]];
        
        for (NSDictionary *dictionary in dictionariesArray) {
            WTHLocation *location = [WTHLocation locationWithDictionary:dictionary];
            [locations addObject:location];
        }
        
        NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:WTHLocationAttributes.name ascending:YES selector:@selector(caseInsensitiveCompare:)];
        [locations sortUsingDescriptors:@[sortByName]];
        
        _allLocations = locations;
    }
    return _allLocations;
}

- (NSArray *)selectedLocations
{
    NSPredicate *selectedLocationsPredicate = [NSPredicate predicateWithFormat:@"%K == %@", WTHLocationAttributes.isSeleceted, @YES];
    NSArray *selectedLocations = [self.allLocations filteredArrayUsingPredicate:selectedLocationsPredicate];
    return selectedLocations;
}

- (NSString *)dataSourcePath
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:WTHDataSourceFile];
    return path;
}


@end
