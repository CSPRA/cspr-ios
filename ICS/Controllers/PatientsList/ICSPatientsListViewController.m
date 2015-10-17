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

@interface ICSPatientsListViewController ()<UITableViewDataSource,
UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *patientListArray;

@end

@implementation ICSPatientsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  [self initializeDummyData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Dummy data
- (void)initializeDummyData {

  Patient *p1 = [kDataSource patientWithId:123];
  p1.firstName = @"aaa";
  p1.lastName = @"bbbb";
  
  Patient *p2 = [kDataSource patientWithId:123];
  p2.firstName = @"aaa";
  p2.lastName = @"bbbb";

  Patient *p3 = [kDataSource patientWithId:123];
  p3.firstName = @"aaa";
  p3.lastName = @"bbbb";

  Patient *p4 = [kDataSource patientWithId:123];
  p4.firstName = @"aaa";
  p4.lastName = @"bbbb";

  self.patientListArray = [NSArray arrayWithObjects:p1,p2,p3,p4, nil];
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
  UIViewController *patientInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:kPatientInforamtionVCIndentifier];
  [self.navigationController pushViewController:patientInfoVC animated:YES];
}

@end
