//
//  HuntViewController.h
//  Scavengers
//
//  Created by Michael Ho on 1/18/2014.
//  Copyright (c) 2014 David Cottrell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HuntViewController : UIViewController
@property (nonatomic) BOOL win;
@property (strong, nonatomic) NSString *distance;
@property (weak, nonatomic) IBOutlet UILabel *instructionsFromTarget;
@property (weak, nonatomic) IBOutlet UILabel *distanceFromTarget;
@property (weak, nonatomic) IBOutlet UILabel *unitsFromTarget;
@property (weak, nonatomic) IBOutlet UILabel *infoFromTarget;
@end
