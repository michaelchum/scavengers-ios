//
//  LocationTracker.h
//  Scavengers
//
//  Created by David Cottrell on 1/18/2014.
//  Copyright (c) 2014 David Cottrell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class MenuViewController, SuccessViewController, QuizViewController, HuntViewController;
@interface LocationTracker : NSObject

@property (nonatomic, strong) MenuViewController *menuController;
@property (nonatomic, strong) SuccessViewController *successController;
@property (nonatomic, strong) QuizViewController *quizController;
@property (nonatomic, strong) HuntViewController *huntController;



- (void)pickHunt:(NSString *)identifier;

//- (CLLocation *)getLatestLocation;
- (void)playTracking;
- (void)pauseTracking;

@property (nonatomic, assign) BOOL isTracking;

@property (nonatomic, copy) NSString *username;

@end
