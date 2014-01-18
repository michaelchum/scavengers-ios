//
//  LocationTracker.h
//  Scavengers
//
//  Created by David Cottrell on 1/18/2014.
//  Copyright (c) 2014 David Cottrell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface LocationTracker : NSObject

//- (CLLocation *)getLatestLocation;
- (void)playTracking;
- (void)pauseTracking;

@property (nonatomic, assign) BOOL isTracking;

@property (nonatomic, copy) NSString *username;

@end
