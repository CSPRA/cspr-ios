//
//  VolunteerSignUpViewController.m
//  ICS
//
//  Created by Harshita
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "VolunteerSignUpViewController.h"
#import "ICSStyleGuide.h"
#define verticalPadding     25
#define navBarHeight        50
#define horizontalPadding   15

@interface VolunteerSignUpViewController()<UITextFieldDelegate>
@property (nonatomic, strong) IBOutlet UITextField *volunteerFirstName;
@property (nonatomic, strong) IBOutlet UITextField *volunteerLastName;
@property (nonatomic, strong) IBOutlet UITextField *volunteerEmail;
@property (nonatomic, strong) IBOutlet UITextField *volunteerDateOfBirth;
@property (nonatomic, strong) IBOutlet UITextField *volunteerGender;
@property (nonatomic, strong) IBOutlet UITextField *volunteerMobile;

@property (nonatomic,strong) UIButton *saveButton;
@property (nonatomic,strong) UIView   *successOverlayView;
@end

@implementation VolunteerSignUpViewController
@synthesize volunteerFirstName;
@synthesize volunteerLastName;
@synthesize volunteerEmail;
@synthesize volunteerDateOfBirth;
@synthesize volunteerGender;
@synthesize volunteerMobile;
@synthesize saveButton;
@synthesize successOverlayView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [ICSStyleGuide backgroundGrey];
    
    [self prefillVolunteerDetails];
    [self addSuccessOverlay];
    [self addSaveButton];
    
}

#pragma mark - Actions

-(void)saveAction:(id)sender {

    if(![self isDataValid]) {
        return;
    }
    
    UIButton * btn = (UIButton*)sender;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [btn setTitle:@"✓" forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 50, 50);
        btn.layer.cornerRadius = 25;
        btn.center = self.view.center;
        successOverlayView.alpha = 0.5;
    }completion:^(BOOL finished) {
    }];
}

-(BOOL)isDataValid {
    NSString * alertMessage = @"";
    
    if(volunteerFirstName.text.length == 0) {
        alertMessage = @"Please enter your first name";
    }
    else if(volunteerLastName.text.length == 0) {
        alertMessage = @"Please enter your last name";
    }
    else if(volunteerEmail.text.length == 0) {
        alertMessage = @"Please enter your email id";
    }
    
    if(alertMessage.length == 0) {
        return YES;
    }
    else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:alertMessage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return NO;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationItem.hidesBackButton = YES;
}

#pragma mark -

-(void)prefillVolunteerDetails {
    volunteerMobile.text = self.verifiedPhoneNumber;
    volunteerMobile.userInteractionEnabled = NO;
}

#pragma mark - view

-(void)addSaveButton {
    saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 50, CGRectGetWidth(self.view.frame), 50)];
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    saveButton.backgroundColor = [ICSStyleGuide ICSRed];
    [saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
}

-(void)addSuccessOverlay {
    successOverlayView = [[UIView alloc] initWithFrame:self.view.bounds];
    successOverlayView.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
    successOverlayView.alpha = 0.0f;
    [self.view addSubview:successOverlayView];
}


@end