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
@property (weak, nonatomic) IBOutlet UILabel *goFromTarget;
@property (weak, nonatomic) IBOutlet UILabel *moveTowardsTarget;


@property (nonatomic, strong) NSNumber *distance;
@property (nonatomic, strong) NSNumber *oldDistance;

@property (nonatomic, assign) int colorDelta;
@property (weak, nonatomic) IBOutlet UIView *colorBorder;

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
    float difference = abs(previousDistanceFloat - distanceFloat);
    
    NSString *status;
    if (difference < 0) {
        [NSString stringWithFormat:@"Woops! Wrong way!"];
        [self setColor:[UIColor greenColor]];
    } else if (distanceFloat > 80) {
        [self setColor:[UIColor greenColor]];
        status = [NSString stringWithFormat:@"You're right on track"];
    } else if (distanceFloat > 70) {
        [self setColor:[UIColor yellowColor]];
        status = [NSString stringWithFormat:@"You're getting closer"];
    } else if (distanceFloat > 60) {
        [self setColor:[UIColor yellowColor]];
        status = [NSString stringWithFormat:@"Keep it up! You're very close"];
    } else if (distanceFloat > 50) {
        [self setColor:[UIColor orangeColor]];
        status = [NSString stringWithFormat:@"You're sooo close"];
    } else if (distanceFloat > 40) {
        [self setColor:[UIColor orangeColor]];
        status = [NSString stringWithFormat:@"It's right there!"];
    } else if (distanceFloat > 30) {
        [self setColor:[UIColor redColor]];
        status = [NSString stringWithFormat:@"One more step!"];
    }
    
    // Update labels
    self.unitsFromTarget.text = @"meters";
    self.goFromTarget.text = status;
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
        _colorDelta = 50;
    }
    return self;
}

- (void)setColor:(UIColor *)color
{
    CALayer *imageLayer = _colorBorder.layer;
    [imageLayer setCornerRadius:_colorBorder.frame.size.width/2];
    [imageLayer setMasksToBounds:YES];
    _colorBorder.backgroundColor = color;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.win = FALSE;
    [self refreshFields];
    self.distanceFromTarget.font = [UIFont fontWithName:@"Quake & Shake" size:70];
    self.unitsFromTarget.font = [UIFont fontWithName:@"Quake & Shake" size:31];
    self.moveTowardsTarget.font = [UIFont fontWithName:@"Quake & Shake" size:21];
}


@end
