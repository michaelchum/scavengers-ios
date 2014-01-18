//
//  QuizViewController.m
//  Scavengers
//
//  Created by David Cottrell on 1/18/2014.
//  Copyright (c) 2014 David Cottrell. All rights reserved.
//

#import "QuizViewController.h"
#import <AFNetworking.h>

@interface QuizViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *question;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextField *answer;

@property (nonatomic, copy) NSString *questionText;
@property (nonatomic, copy) NSString *imageUrl;

@end

@implementation QuizViewController

- (id)initWithQuestion:(NSString *)question imageUrl:(NSString *)imageUrl
{
    self = [super initWithNibName:@"QuizViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _question.text = _questionText;
    NSURL *imageURL = [NSURL URLWithString:_imageUrl];
    //[_image setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"Empty"]];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
