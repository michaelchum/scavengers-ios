//
//  HuntViewController.m
//  Scavengers
//
//  Created by Michael Ho on 1/18/2014.
//  Copyright (c) 2014 David Cottrell. All rights reserved.
//

#import "HuntViewController.h"

@interface HuntViewController ()

@end

@implementation HuntViewController

- (void)setDistance:(NSString *)distance
{
    NSString *previousDistance = _distance;

    float previousDistanceFloat = [previousDistance floatValue]*1000;
    float distanceFloat = [distance floatValue]*1000;
    float difference = (previousDistanceFloat - distanceFloat)*1000;
    
    _distance = [[NSNumber numberWithFloat:[distance floatValue]*1000] stringValue]; // Update property
    
    NSString *status;
    if (difference < 0) {
        [NSString stringWithFormat:@"Woops! Wrong way!"];
    } else if (distanceFloat > 50) {
        status = [NSString stringWithFormat:@"You're on good track,\nkeep going"];
    } else if (distanceFloat > 40) {
        status = [NSString stringWithFormat:@"You're getting closer"];
    } else if (distanceFloat > 30) {
        status = [NSString stringWithFormat:@"Keep it up,\nyou're very close"];
    } else if (distanceFloat > 20) {
        status = [NSString stringWithFormat:@"You're sooo close"];
    } else if (distanceFloat > 10) {
        status = [NSString stringWithFormat:@"It's right there!"];
    } else if (distanceFloat > 5) {
        status = [NSString stringWithFormat:@"One more step!"];
    }
    
    // Update labels
    self.unitsFromTarget.text = @"meters";
    self.infoFromTarget.text = status;
    self.distanceFromTarget.text = _distance;
}

- (void)setWin:(BOOL)win
{
    if (win) {
        _win = win;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.win = FALSE;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
