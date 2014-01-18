//
//  MenuViewController.m
//  Scavengers
//
//  Created by David Cottrell on 1/18/2014.
//  Copyright (c) 2014 David Cottrell. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"
#import "LocationTracker.h"
#import "MenuTableCell.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *picks;

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation MenuViewController

- (id)init
{
    self = [super initWithNibName:@"MenuViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _picks = [[NSArray alloc] init];
    }
    return self;
}

- (void)setPicks:(NSArray *)picks
{
    _picks = picks;
    [_table reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [_picks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CoverCellIdentifier = @"MenuTableViewCell";
    MenuTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CoverCellIdentifier];
    if (cell == nil) {
        cell = [[MenuTableCell alloc] initWithReuseIdentifier:CoverCellIdentifier];
    }
    
    cell.name.text = [[_picks objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.description.text = [[_picks objectAtIndex:indexPath.row] objectForKey:@"description"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *pickIdentifier = [[_picks objectAtIndex:indexPath.row] objectForKey:@"_id"];
    DLog(@"PickID: %@", pickIdentifier);
    AppDelegate *del = [UIApplication sharedApplication].delegate;
    LocationTracker *locationTracker = del.locationTracker;
    [locationTracker pickHunt:pickIdentifier];
    
}





@end
