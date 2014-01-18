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

#import "MenuViewController.h"

@interface WelcomeViewController () <FBLoginViewDelegate>

@property (nonatomic, copy) NSString *username;
@property (weak, nonatomic) IBOutlet FBLoginView *LoginView;

@property (nonatomic, strong) MenuViewController *menuController;



@end

@implementation WelcomeViewController

- (id)init
{
    self = [super initWithNibName:@"WelcomeViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _menuController = [[MenuViewController alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
        
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:_menuController];
        
        [del.window setRootViewController:navigation];
        //[self.navigationController pushViewController:_menuController animated:YES];
    }
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    
}



@end
