//
//  WelcomeViewController.m
//  Scavengers
//
//  Created by David Cottrell on 1/17/2014.
//  Copyright (c) 2014 David Cottrell. All rights reserved.
//

#import "WelcomeViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <AFNetworking.h>

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
    
    
//    LocationTracker *locationTracker = ((AppDelegate *)[UIApplication sharedApplication].delegate).locationTracker;
//    CLLocation *location = [locationTracker getLatestLocation];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
//    [parameters setObject:[NSNumber numberWithDouble:location.coordinate.latitude] forKey:@"latitude"];
//    [parameters setObject:[NSNumber numberWithDouble:location.coordinate.longitude] forKey:@"longitude"];
    
    
    
    [parameters setObject:_username forKey:@"username"];
    
    
    
    NSString *path = [NSString stringWithFormat:@"http://scavengers.herokuapp.com/location/"];
    [manager POST:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    NSLog(@"Hi");
}



@end
