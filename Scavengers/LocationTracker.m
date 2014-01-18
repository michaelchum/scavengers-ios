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
//@property (nonatomic, strong) NSMutableArray *locations;

@property (nonatomic, strong) AFHTTPRequestOperationManager *reqManager;

@property (nonatomic, strong) NSNumber *lastTimeUploaded;
@end
@implementation LocationTracker

- (id)init
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDelegate:self];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        _reqManager = [AFHTTPRequestOperationManager manager];
        _reqManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _reqManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];

        _lastTimeUploaded = [NSNumber numberWithDouble:0.0];
    }
    return self;
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
    
    if (_username == nil || locations == nil) {
        return;
    }
    NSNumber *time = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
    if ([_lastTimeUploaded doubleValue] + 5.0 > [time doubleValue]) {
        return;
    }
    _lastTimeUploaded = time;
    
    CLLocation *location = [locations lastObject];

    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];

    [parameters setObject:[NSNumber numberWithDouble:location.coordinate.latitude] forKey:@"latitude"];
    [parameters setObject:[NSNumber numberWithDouble:location.coordinate.longitude] forKey:@"longitude"];
    
    [parameters setObject:_username forKey:@"username"];
    
    [parameters setObject:time forKey:@"time"];
    
    
    NSString *path = [NSString stringWithFormat:@"http://scavengers.herokuapp.com/location"];
    [_reqManager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"Here %@", responseObject);
        NSString *type = [responseObject objectForKey:@"type"];
        if ([type isEqualToString:@"PICK"]) {
            NSMutableArray *picks = [[NSMutableArray alloc] init];
//            for (NSDictionary *element in responseObject objectForKey:@"picks") {
//                
//            }
        }
        
        NSNumber *distance = [responseObject objectForKey:@"distance"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Failed with error: %@", error);
    }];
}

@end
