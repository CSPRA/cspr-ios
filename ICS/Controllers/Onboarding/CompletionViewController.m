//
//  CompletionViewController.m
//  ICS
//
//  Created by aqsa-fueled on 03/12/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "CompletionViewController.h"

@interface CompletionViewController ()

@end

@implementation CompletionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backToEventsTapped:(id)sender {
	[self.navigationController popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
