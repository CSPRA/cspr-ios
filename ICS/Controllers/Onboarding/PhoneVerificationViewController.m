//
//  PhoneVerificationViewController.m
//  ICS
//
//  Created by Harshita
//  Copyright (c) 2015 Meraki. All rights reserved.
//

#import "PhoneVerificationViewController.h"
#import "VolunteerSignUpViewController.h"
#import "PatientInformationViewController.h"
#import "ICSStyleGuide.h"
#import <DigitsKit/DigitsKit.h>

@interface PhoneVerificationViewController ()

@end

@implementation PhoneVerificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ICSStyleGuide backgroundGrey];

    [self addDigitsView];
}

-(void)addDigitsView{
    
    DGTAppearance *digitsAppearance =
    [[DGTAppearance alloc] init];
    // Change color properties to customize the look:
    digitsAppearance.backgroundColor = [ICSStyleGuide backgroundGrey];
    digitsAppearance.accentColor = [ICSStyleGuide ICSRed];
    
    
    DGTAuthenticateButton *authenticateButton = [DGTAuthenticateButton buttonWithAuthenticationCompletion:^(DGTSession *session, NSError *error) {
        if(!error) {

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self createAlertForTitle:@"Success" withMessage:[NSString stringWithFormat:@"%@ verified successfully", session.phoneNumber]];
            });
            VolunteerSignUpViewController * vs = [self.storyboard instantiateViewControllerWithIdentifier:@"VolunteerSignUp"];
            vs.verifiedPhoneNumber = session.phoneNumber;
            [self.navigationController pushViewController:vs animated:YES];
        }
        else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self createAlertForTitle:@"Error" withMessage:error.localizedDescription];
            });
        }
    }];
    authenticateButton.center = self.view.center;
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

- (IBAction)registerButtonTapped:(id)sender {
  UIViewController *patientInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:kPatientInforamtionVCIndentifier];
  [self.navigationController pushViewController:patientInfoVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
