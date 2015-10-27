//
//  PatientRegistrationViewController.m
//  ICS
//
//  Created by Harshita on 27/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "PatientRegistrationViewController.h"
#import "WalkthroughViewController.h"

@interface PatientRegistrationViewController ()

@end

@implementation PatientRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(![ICSDataManager hasWalkthroughBeenShown]) {
        [self showVolunteerWalkthrough:nil];
        [ICSDataManager disableAutomaticWalkthroughPreview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)registerButtonTapped:(id)sender {
    UIViewController *patientInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:kPatientInforamtionVCIndentifier];
    [self.navigationController pushViewController:patientInfoVC animated:YES];
}

#pragma mark - 

-(void)viewWillAppear:(BOOL)animated {
    self.navigationItem.hidesBackButton = YES;
    [super viewWillAppear:animated];
}

#pragma mark - Walkthrough

-(IBAction)showVolunteerWalkthrough:(id)sender {
    WalkthroughViewController * wtVC = [[WalkthroughViewController alloc] init];
    [self presentViewController:wtVC animated:YES completion:NULL];
}


@end
