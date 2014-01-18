//
//  AppDelegate.h
//  Scavengers
//
//  Created by David Cottrell on 1/17/2014.
//  Copyright (c) 2014 David Cottrell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocationTracker;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) LocationTracker *locationTracker;

@end
