//
//  QuizViewController.h
//  Scavengers
//
//  Created by David Cottrell on 1/18/2014.
//  Copyright (c) 2014 David Cottrell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizViewController : UIViewController

- (void)setQuestion:(NSString *)question imagePath:(NSString *)imagePath;
- (void)wrongAnswer;

@end
