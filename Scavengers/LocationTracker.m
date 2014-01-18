//
//  LocationTracker.m
//  Scavengers
//
//  Created by David Cottrell on 1/18/2014.
//  Copyright (c) 2014 David Cottrell. All rights reserved.
//

#import "LocationTracker.h"
#import <AFNetworking.h>


@interface LocationTracker () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) AFHTTPRequestOperationManager *reqManager;

@end
@implementation LocationTracker

- (id)init
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDelegate:self];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        _locations = [[NSMutableArray alloc] init];
        _reqManager = [AFHTTPRequestOperationManager manager];
        _reqManager.responseSerializer = [AFJSONResponseSerializer serializer];

        [self playTracking];
    }
    return self;
}

- (CLLocation *)getLatestLocation
{
    return [_locations lastObject];
}

- (void)pauseTracking
{
    [_locationManager stopUpdatingLocation];
}

- (void)playTracking
{
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)clmanager didUpdateLocations:(NSArray *)locations
{
    if (_username == nil) {
        return;
    }
    [_locations addObjectsFromArray:locations];
    CLLocation *location = [self getLatestLocation];
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    [parameters setObject:[NSNumber numberWithDouble:location.coordinate.latitude] forKey:@"latitude"];
    [parameters setObject:[NSNumber numberWithDouble:location.coordinate.longitude] forKey:@"longitude"];
    
    [parameters setObject:_username forKey:@"username"];
    
    NSNumber *time = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
    
    
    [parameters setObject:time forKey:@"time"];
    

    NSString *path = [NSString stringWithFormat:@"http://scavengers.herokuapp.com/location/"];
    [_reqManager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Here");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed with error: %@", error);
    }];
}

@end
