//
//  LocationTracker.m
//  Scavengers
//
//  Created by David Cottrell on 1/18/2014.
//  Copyright (c) 2014 David Cottrell. All rights reserved.
//

#import "LocationTracker.h"

@interface LocationTracker () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, strong) NSTimer *timer;

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
        [self startTrackingLoop];
    }
    return self;
}

- (CLLocation *)getLatestLocation
{
    return [_locations lastObject];
}

- (void)stopTrackingLoop
{
    _isTracking = NO;
    [_timer invalidate];
}

- (void)startTrackingLoop
{
    _isTracking = YES;
    [self playTracking];
    _timer = [NSTimer timerWithTimeInterval:5*60.0 target:self selector:@selector(playTracking) userInfo:Nil repeats:YES];
}

- (void)pauseTracking
{
    [_locationManager stopUpdatingLocation];
}

- (void)playTracking
{
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [_locations addObjectsFromArray:locations];
    [self pauseTracking];
}

@end
