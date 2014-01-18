//
//  QuizViewController.m
//  Scavengers
//
//  Created by David Cottrell on 1/18/2014.
//  Copyright (c) 2014 David Cottrell. All rights reserved.
//

#import "QuizViewController.h"
#import <UIImageView+AFNetworking.h>
#import "AppDelegate.h"
#import "LocationTracker.h"

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

- (void)refresh
{
    _question.text = _questionText;
    NSURL *imageURL = [NSURL URLWithString:_imageUrl];
    DLog(@"text: %@", _questionText);
    [_image setImageWithURL:imageURL];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refresh];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeyboard
{
    [_answer resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Test Answer!
    
    
    
    AppDelegate *del = [UIApplication sharedApplication].delegate;
    LocationTracker *locationTracker = del.locationTracker;
    [locationTracker answerQuestion:textField.text];
    
    return YES;
}

- (IBAction)quit:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setQuestion:(NSString *)question imagePath:(NSString *)imagePath
{
    DLog(@"Here");
    _questionText = question;
    _imageUrl = imagePath;
    [self refresh];
}



@end
