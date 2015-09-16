//
//  ViewController.m
//  ICS
//
//  Created by Harshita on 16/09/15.
//  Copyright (c) 2015 Meraki. All rights reserved.
//

#import "ViewController.h"
#import <DigitsKit/DigitsKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDigitsView];
}

-(void)addDigitsView{
    DGTAuthenticateButton *authenticateButton = [DGTAuthenticateButton buttonWithAuthenticationCompletion:^(DGTSession *session, NSError *error) {
        if(!error) {
            NSString * alertMessage = [NSString stringWithFormat:@"%@ verified successfully", session.phoneNumber];
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:alertMessage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            authenticateButton.hidden = YES;
        }
    }];
    authenticateButton.center = self.view.center;
    [self.view addSubview:authenticateButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
