//
//  WelcomeViewController.m
//  Scavengers
//
//  Created by David Cottrell on 1/17/2014.
//  Copyright (c) 2014 David Cottrell. All rights reserved.
//

#import "WelcomeViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import "LocationTracker.h"
#import "SuccessViewController.h"

@interface WelcomeViewController () <FBLoginViewDelegate>

@property (nonatomic, copy) NSString *username;
@property (weak, nonatomic) IBOutlet FBLoginView *LoginView;

@end

@implementation WelcomeViewController

- (id)init
{
    self = [super initWithNibName:@"WelcomeViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
    
    AppDelegate *del = [UIApplication sharedApplication].delegate;
    LocationTracker *locationTracker = del.locationTracker;
    
    if (![locationTracker.username isEqualToString:@"alex"]) {
        _username = @"alex";
        DLog(@"Here w username: %@", _username);
        locationTracker.username = _username;
        [locationTracker playTracking];
        
        if (locationTracker.successController == nil) {
            locationTracker.successController = [[SuccessViewController alloc] init];
        }
        [self.navigationController pushViewController:locationTracker.successController animated:NO];
        
    }
    
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    
    AppDelegate *del = [UIApplication sharedApplication].delegate;
    LocationTracker *locationTracker = del.locationTracker;
    
    if (![locationTracker.username isEqualToString:user.username]) {
        _username = user.username;
        DLog(@"Here w username: %@", _username);
        locationTracker.username = _username;
        [locationTracker playTracking];
        
        if (locationTracker.successController == nil) {
            locationTracker.successController = [[SuccessViewController alloc] init];
        }
        [self.navigationController pushViewController:locationTracker.successController animated:NO];
        
    }
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    
}



@end
