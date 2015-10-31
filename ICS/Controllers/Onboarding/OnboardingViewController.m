//
//  OnboardingViewController.m
//  ICS
//
//  Created by Harshita on 22/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

//#import "PhoneVerificationViewController.h"
#import "RegisterVolunteerViewController.h"
#import "OnboardingViewController.h"
#import "PatientInformationViewController.h"
#import "ICSStyleGuide.h"
#import <DigitsKit/DigitsKit.h>
#import "VolunteerSignUpViewController.h"

@interface OnboardingViewController ()

@end

@implementation OnboardingViewController

- (void)viewDidLoad {
    
    self.welcomeLabel.alpha = kMinAlpha;
    
    [super viewDidLoad];
  [self setupNavigationBar];
    if([ICSDataManager isVolunteerRegistered]) {
//        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:kPatientRegistrationVCIndentifier] animated:NO];
    }
    else {
        [self addDigitsView];
        [UIView animateWithDuration:0.3 animations:^{
            self.welcomeLabel.alpha = kMaxAlpha;
        }];
        
    }
}
- (void)setupNavigationBar {
  [self.navigationController setNavigationBarHidden:NO animated:NO];
  [self.navigationController setTitle:@"SignUp"];
  UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:self action:nil];
  [self.navigationController.navigationItem setBackBarButtonItem:backItem];
}
-(void)addDigitsView{
    
    DGTAppearance *digitsAppearance  = [[DGTAppearance alloc] init];
    digitsAppearance.backgroundColor = self.view.backgroundColor;
//    digitsAppearance.accentColor = [ICSStyleGuide ICSRed];
  digitsAppearance.accentColor = [UIColor orangeColor];
    
    DGTAuthenticateButton *authenticateButton = [DGTAuthenticateButton buttonWithAuthenticationCompletion:^(DGTSession *session, NSError *error) {
      
        if(!error) {

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self createAlertForTitle:@"Success" withMessage:[NSString stringWithFormat:@"%@ verified successfully", session.phoneNumber]];
            });
            RegisterVolunteerViewController * registerVolunteerVC = [self.storyboard instantiateViewControllerWithIdentifier:kRegisterVCIdentifier];
            registerVolunteerVC.phoneNumber = session.phoneNumber;
            [self.navigationController pushViewController:registerVolunteerVC animated:YES];
        }
        else {
            if(error.code == 1) {
            
                VolunteerSignUpViewController * vs = [self.storyboard instantiateViewControllerWithIdentifier:kVolunteerSignUpVCIdentifier];
                vs.verifiedPhoneNumber = @"9654489706";
                [self.navigationController pushViewController:vs animated:YES];
            
                return ;
            } ;
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self createAlertForTitle:@"Error" withMessage:error.localizedDescription];
            });
        }
    }];
    authenticateButton.center = CGPointMake(self.view.center.x, CGRectGetHeight(self.view.frame) - 2*CGRectGetHeight(authenticateButton.frame));
    authenticateButton.digitsAppearance = digitsAppearance;
    [self.view addSubview:authenticateButton];
}


-(void)createAlertForTitle:(NSString*)title withMessage:(NSString*)message {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Lets get DIGITal

@end
