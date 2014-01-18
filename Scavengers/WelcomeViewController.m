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
    
}



- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    LocationTracker *locationTracker = ((AppDelegate *)[UIApplication sharedApplication].delegate).locationTracker;
    locationTracker.username = _username;
    [locationTracker playTracking];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    NSLog(@"Hi");
}



@end
