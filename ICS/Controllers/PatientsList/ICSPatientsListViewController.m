//
//  ICSPatientsListViewController.m
//  ICS
//
//  Created by aqsa-fueled on 17/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "ICSPatientsListViewController.h"
#import "Patient.h"
#import "SharedModel.h"
#import "PatientInformationViewController.h"

@interface ICSPatientsListViewController ()<UITableViewDataSource,
UITabBarDelegate,
UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *patientListArray;

@end

@implementation ICSPatientsListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self offlineData];
}
- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self initialSetup];
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)offlineData {
  
    NSDictionary *patient1 = @{
    @"name":@"Patient 1",
    @"dob":@"1985-10-01",
    @"gender":@"male",
    @"maritalStatus":@"married",
    @"address":@"Lorem ipsum",
    @"homePhoneNumber":@(12334335),
    @"mobileNumber":@(12345678),
    @"email":@"abc@gmail.com",
    @"annualIncome":@(300000),
    @"occupation":@"bussiness",
    @"education":@"Secondary School",
    @"religion":@"Hindu",
    @"aliveChildrenCount":@(0),
    @"deceasedChildrenCount":@(0),
    @"voterId":@"1234A59",
    @"adharId":@"12343545",
    @"updated_at":@"2015-10-13 12:19:11",
    @"created_at":@"2015-10-13 12:19:11",
    @"id":@(1)
    };
  self.patientListArray = [NSArray arrayWithObjects:patient1, nil];
}
  
- (void)initialSetup {
  if (!self.patientListArray) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops!!"
                                                    message:@"No patient registered yet."
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Register", nil];
    [alert show];
  }
}

- (void)fetchPAtientList {
  
}

#pragma mark - TableView Delegate and DataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.patientListArray.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *Cell = [self.tableView dequeueReusableCellWithIdentifier:kPatieltDetailsCellIdentifier forIndexPath:indexPath];
  return Cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

  UITabBarController *tabBarController = [mainStoryboard instantiateViewControllerWithIdentifier:ktabBarViewControllerIdentifier];
//  [tabBarController setModalTransitionStyle:UIModalTransitionStylePartialCurl];
  [self.navigationController pushViewController:tabBarController animated:YES];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  switch (buttonIndex) {
    case 0:
      [self.navigationController popViewControllerAnimated:YES];
      break;
    case 1:{
      UIViewController *registerPatientVC = [self.storyboard instantiateViewControllerWithIdentifier:ktabBarViewControllerIdentifier];
      
      [self.navigationController pushViewController:registerPatientVC animated:YES];
    }
      break;
    default:
      break;
  }
  
}

@end
