//
//  SuccessViewController.m
//  Scavengers
//
//  Created by David Cottrell on 1/18/2014.
//  Copyright (c) 2014 David Cottrell. All rights reserved.
//

#import "SuccessViewController.h"
#import "AppDelegate.h"
#import "LocationTracker.h"
#import "MenuViewController.h"

@interface SuccessViewController ()

@property (nonatomic, weak) LocationTracker *locationTracker;

@end

@implementation SuccessViewController

- (id)init
{
    self = [super initWithNibName:@"SuccessViewController" bundle:nil];
    if (self) {
        // Custom initialization
        AppDelegate *del = [UIApplication sharedApplication].delegate;
        _locationTracker = del.locationTracker;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_locationTracker.menuController == nil) {
        _locationTracker.menuController = [[MenuViewController alloc] init];
    }
    [self.navigationController pushViewController:_locationTracker.menuController animated:NO];
    
    
}



@end
