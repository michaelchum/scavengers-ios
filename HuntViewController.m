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

@property (nonatomic, strong) NSNumber *distance;
@property (nonatomic, strong) NSNumber *oldDistance;


@end

@implementation HuntViewController

- (void)setDistance:(NSNumber *)distance
{
    _oldDistance = _distance;
    _distance = [NSNumber numberWithFloat: [distance floatValue]*1000];
    [self refreshFields];
}

- (void)refreshFields
{
    NSNumber *previousDistance = _oldDistance;
    NSNumber *distance = _distance;
    
    float previousDistanceFloat = [previousDistance floatValue];
    float distanceFloat = [distance floatValue];
    float difference = (previousDistanceFloat - distanceFloat);
    
    
    NSString *status;
    if (difference < 0) {
        [NSString stringWithFormat:@"Woops! Wrong way!"];
    } else if (distanceFloat > 50) {
        status = [NSString stringWithFormat:@"You're on the right track,\nkeep going"];
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
    DLog(@"distance: %d", [_distance integerValue]);
    
    _distanceFromTarget.text = [NSString stringWithFormat:@"%d", [_distance intValue] ];
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.win = FALSE;
    [self refreshFields];

}


@end
