//
//  MenuViewController.m
//  Scavengers
//
//  Created by David Cottrell on 1/18/2014.
//  Copyright (c) 2014 David Cottrell. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableCell.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation MenuViewController

- (id)initWithPicks:(NSArray *)picks
{
    self = [super initWithNibName:@"MenuViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CoverCellIdentifier = @"MenuTableViewCell";
    MenuTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CoverCellIdentifier];
    if (cell == nil) {
        cell = [[MenuTableCell alloc] initWithReuseIdentifier:CoverCellIdentifier];
    }
    
    cell.name.text = @"Da best";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}





@end
