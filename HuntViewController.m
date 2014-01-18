//
//  HuntViewController.m
//  Scavengers
//
//  Created by Michael Ho on 1/18/2014.
//  Copyright (c) 2014 David Cottrell. All rights reserved.
//

#import "HuntViewController.h"

@interface HuntViewController ()

@property (weak, nonatomic) IBOutlet UILabel *instructionsFromTarget;
@property (weak, nonatomic) IBOutlet UILabel *distanceFromTarget;
@property (weak, nonatomic) IBOutlet UILabel *unitsFromTarget;
@property (weak, nonatomic) IBOutlet UILabel *infoFromTarget;

@end

@implementation HuntViewController

- (void)setDistance:(NSNumber *)distance
{
    NSNumber *previousDistance = _distance;

    float previousDistanceFloat = [previousDistance floatValue]*1000;
    float distanceFloat = [distance floatValue]*1000;
    float difference = (previousDistanceFloat - distanceFloat)*1000;
    
    _distance = [NSNumber numberWithFloat:[distance floatValue]*1000]; // Update property
    
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
    self.distanceFromTarget.text = [_distance stringValue];
}

- (void)setWin:(BOOL)win
{
    if (win) {
        _win = win;
    }
}

- (id)init
{
    self = [super initWithNibName:@"HuntViewController" bundle:nil];
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


@end
