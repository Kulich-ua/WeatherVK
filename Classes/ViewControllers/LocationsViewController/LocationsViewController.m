//
//  ViewController.m
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/8/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#import "LocationsViewController.h"
#import "WeatherViewController.h"
#import "LocationTableViewCell.h"
#import "WTHMacroDefinitions.h"
#import "WTHDataSource.h"
#import "WTHLocation.h"

NSString * const ShowWeatherSegueIdentifier = @"ShowWeatherSegue";


@interface LocationsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBarButton;

@property (strong, nonatomic) NSArray *locations;

@property (assign, nonatomic, getter=isEditMode) BOOL editMode;

@end


@implementation LocationsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = TR(@"title.locations");
    self.editBarButton.possibleTitles = [NSSet setWithObjects:TR(@"general.edit"), TR(@"general.save"), nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:LocationTableViewCellReuseIdentifier bundle:nil] forCellReuseIdentifier:LocationTableViewCellReuseIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.editMode = NO;
}


#pragma mark - IBActions

- (IBAction)editButtonTouched:(UIBarButtonItem *)barButtonItem
{
    self.editMode = !self.isEditMode;
}


#pragma mark - UITableViewDelegate & DataSource

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WTHLocation *location = self.locations[indexPath.row];
    location.isSeleceted = NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isEditMode) {
        
        WTHLocation *location = self.locations[indexPath.row];
        location.isSeleceted = YES;
        
    } else {
        
        [self performSegueWithIdentifier:ShowWeatherSegueIdentifier sender:self];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.locations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:LocationTableViewCellReuseIdentifier forIndexPath:indexPath];
    WTHLocation *location = self.locations[indexPath.row];
    cell.location = location;
    
    if (self.isEditMode && location.isSeleceted) {
        
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }

    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WeatherViewController *weatherCollectionViewController = [segue destinationViewController];
    NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow] row];
    weatherCollectionViewController.location = self.locations[selectedIndex];
}


#pragma mark - Mutators

- (void)setEditMode:(BOOL)editMode
{
    _editMode = editMode;
    
    self.locations = nil;
    
    if (!editMode){
        [[WTHDataSource sharedInstance] saveAllLocations];
    }
    
    self.editBarButton.title = (editMode) ? TR(@"general.save") : TR(@"general.edit");
    self.tableView.allowsMultipleSelection = editMode;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Accessors

- (NSArray *)locations
{
    if (!_locations) {
        WTHDataSource *dataSource = [WTHDataSource sharedInstance];
        _locations = (self.isEditMode) ? [dataSource allLocations] : [dataSource selectedLocations];
    }
    return _locations;
}


@end
