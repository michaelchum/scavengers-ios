//
//  LocationTracker.m
//  Scavengers
//
//  Created by David Cottrell on 1/18/2014.
//  Copyright (c) 2014 David Cottrell. All rights reserved.
//

#import "LocationTracker.h"
#import "MenuViewController.h"
#import <AFNetworking.h>
#import "SuccessViewController.h"
#import "QuizViewController.h"
#import "HuntViewController.h"

// TODO
enum {
    ModeTypePick,
    ModeTypeQuiz,
    ModeTypeHunt,
    ModeTypeMeetup,
};
typedef NSInteger ModeType;



@interface LocationTracker () <CLLocationManagerDelegate>

@property (nonatomic, assign) ModeType mode;

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) AFHTTPRequestOperationManager *reqManager;

@property (nonatomic, strong) NSNumber *lastTimeUploaded;

@property (nonatomic, strong) CLLocation *lastCheckedLocation;

@end
@implementation LocationTracker

- (id)init
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDelegate:self];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        
        _quizController = [[QuizViewController alloc] init];
        _huntController = [[HuntViewController alloc] init];
        
        _mode = ModeTypePick;
        
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
    NSNumber *time = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
    CLLocation *location;
    if (clmanager != nil) {
        if (_username == nil || locations == nil) {
            return;
        }
        if ([_lastTimeUploaded doubleValue] + 5.0 > [time doubleValue]) {
            return;
        }
        location = [locations lastObject];
        _lastTimeUploaded = time;
        _lastCheckedLocation = location;
    } else {
        location = _lastCheckedLocation;
    }
    
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    [parameters setObject:[NSNumber numberWithDouble:location.coordinate.latitude] forKey:@"latitude"];
    [parameters setObject:[NSNumber numberWithDouble:location.coordinate.longitude] forKey:@"longitude"];
    
    [parameters setObject:_username forKey:@"username"];
    
    [parameters setObject:time forKey:@"time"];
    
    NSString *path = [NSString stringWithFormat:@"http://scavengers.herokuapp.com/location"];
    [_reqManager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self handleResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Failed with error: %@", error);
    }];
    
}

- (void)handleResponse:(NSDictionary *)responseObject
{
    DLog(@"Here %@", responseObject);
    NSString *type = [responseObject objectForKey:@"type"];
    if ([type isEqualToString:@"PICK"]) {
        _mode = ModeTypePick;
        NSArray *picks = [responseObject objectForKey:@"picks"];
        [_menuController setPicks:picks];
    } else if ([type isEqualToString:@"DISTANCE"]) {
        if (_mode != ModeTypeHunt) {
            [_menuController.navigationController pushViewController:_huntController animated:NO];
            _mode = ModeTypeHunt;
        }
        NSNumber *distance = [responseObject objectForKey:@"distance"];
        [_huntController setDistance:distance];
    } else if ([type isEqualToString:@"QUESTION"]) {
        if (_mode == ModeTypeHunt) {
            [_menuController.navigationController popViewControllerAnimated:YES];
        }
        
        if (_mode != ModeTypeQuiz) {
            DLog(@"Pushing");
            [_menuController.navigationController pushViewController:_quizController animated:NO];
            _mode = ModeTypeQuiz;
        }
        
        
        
        NSString *text = [responseObject objectForKey:@"text"];
        NSString *imageUrl = [responseObject objectForKey:@"img"];
        DLog(@"text: %@", text);
        [_quizController setQuestion:text imagePath:imageUrl];
        
    } else if ([type isEqualToString:@"WIN"]) {
        [_menuController.navigationController popViewControllerAnimated:NO];
        [_menuController.navigationController popViewControllerAnimated:NO];
    }
}

- (void)pickHunt:(NSString *)identifier
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    
    
    NSNumber *time = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    [parameters setObject:_username forKey:@"username"];
    [parameters setObject:identifier forKey:@"text"];
    [parameters setObject:time forKey:@"time"];
    [parameters setObject:@"PICK" forKey:@"actionType"];
    DLog(@"here w params %@", parameters);
    
    NSString *path = [NSString stringWithFormat:@"http://scavengers.herokuapp.com/action"];
    
    [manager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self locationManager:nil didUpdateLocations:nil];
        DLog(@"Here %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Failed with error: %@", error);
    }];
}

- (void)answerQuestion:(NSString *)answer
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    
    
    NSNumber *time = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    [parameters setObject:_username forKey:@"username"];
    [parameters setObject:answer forKey:@"text"];
    [parameters setObject:time forKey:@"time"];
    [parameters setObject:@"ANSWER" forKey:@"actionType"];
    DLog(@"here w params %@", parameters);
    
    NSString *path = [NSString stringWithFormat:@"http://scavengers.herokuapp.com/action"];
    
    [manager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSNumber *correctAnswerNum = [responseObject objectForKey:@"answer"];
        BOOL correctAnswer = YES;
        
        if (correctAnswerNum)
            correctAnswer = [correctAnswerNum boolValue];
        if (!correctAnswer) {
            [self locationManager:nil didUpdateLocations:nil];
            [_quizController wrongAnswer];
            return;
        }
        
        NSString *type = [responseObject objectForKey:@"type"];
        if ([type isEqualToString:@"WIN"]) {
            //            DLog(@"booya");
            NSNumber *points = [responseObject objectForKey:@"points"];
            [_successController setPoints:points];
            [_menuController.navigationController popViewControllerAnimated:NO];
            [_menuController.navigationController popViewControllerAnimated:NO];
        }
        
        [self locationManager:nil didUpdateLocations:nil];
        
        
        DLog(@"Here %@", responseObject);
        //        [self handleResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Failed with error: %@", error);
    }];
}

- (void)skipQuestion
{
    NSNumber *time = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    ;
    
    [parameters setObject:_username forKey:@"username"];
    [parameters setObject:time forKey:@"time"];
    [parameters setObject:@"SKIP" forKey:@"actionType"];
    DLog(@"here w params %@", parameters);
    
    NSString *path = [NSString stringWithFormat:@"http://scavengers.herokuapp.com/action"];
    [_reqManager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self handleResponse:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Failed with error: %@", error);
    }];
    
}



@end
