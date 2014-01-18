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
    _username = user.username;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSString *path = [NSString stringWithFormat:@"http://scavengers.herokuapp.com/?username=%@", _username];
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.0];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    // Allowing any connections
    operation.securityPolicy.allowInvalidCertificates = YES;
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    DLog(@"Calling: %@", path);
    DLog(@"Path: %@", path);
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *data = [responseObject objectForKey:@"data"];
        NSArray *storyJSONs = [[data objectForKey:@"mystories"] objectForKey:@"stories"];
        
        NSInteger userId = ((NSNumber *)[data objectForKey:@"uid"]).integerValue;
        Story *story;
        NSMutableArray *friendStories = [[NSMutableArray alloc] init];
        DLog(@"storyJSONS: %@", storyJSONs);
        for (NSDictionary *storyJSON in storyJSONs) {
            story =[[Story alloc] initWithJSON:storyJSON];
            story.userId = userId;
            story.isPublic = YES;
            
            [friendStories addObject:story];
        }
        
        // Sort by date
        _friendStories = [NSArray arrayWithArray:friendStories];
        NSNotification *notification = [[NSNotification alloc] initWithName:_myStoriesLoadedNotificationName object:self userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Failed with error: %@", error);
        // TODO
        NSNotification *notification = [[NSNotification alloc] initWithName:_myStoriesLoadedNotificationName object:self userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }];
    [operation start];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    NSLog(@"Hi");
}



@end
