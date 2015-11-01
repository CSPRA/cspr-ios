//
//  ICSHomeViewController.m
//  ICS
//
//  Created by aqsa-fueled on 16/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "ICSHomeViewController.h"
#import "EventDetailTableViewCell.h"
#import "PatientInformationViewController.h"
#import "Volunteer.h"
#import "ICSPatientsListViewController.h"
#import "ICSUtilities.h"
#import "Form.h"

static NSString *const RegisterEvent = @"register";
static NSString *const RegisterScreeningEvent = @"register_screen";
static NSString *const ScreenEvents = @"screen";

@interface ICSHomeViewController ()<UITableViewDelegate,
UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *eventArray;

@end

@implementation ICSHomeViewController

#pragma mark - View cycle
- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupNavigationBar];
  [self loadEvents];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Initalization
- (void)loadEvents {
  Volunteer *volunteer = [Volunteer fetchVolunteer];
  self.token = volunteer.token;
  NSLog(@"%@",volunteer.volunteerId);
  self.eventArray = [[NSMutableArray alloc] init];
  NSArray *savedEventList = [kSharedModel fetchObjectsWithEntityName:kEventEntityName];
  if ([ICSUtilities hasActiveConnection]) {
    [self fetchLatestEvents];
  }else if(savedEventList){
    [self.eventArray addObjectsFromArray:savedEventList];
  }
}

- (void)setupNavigationBar {
  self.navigationItem.title = @"ICS Events";

}

- (void)fetchLatestEvents {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [kDataSource fetchEventsWithToken:self.token
                      completionBlock:^(BOOL success, NSDictionary *result, NSError *error) {
                        if (success) {
                          [self.eventArray addObjectsFromArray:[result objectForKey:@"results"]];
                          [self.tableView reloadData];
                        }else if (error){
                          NSLog(@"%@",error);
                        }
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                      }];
}


#pragma mark - TableView Delegate and DataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.eventArray.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  EventDetailTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kEventDetailCellIdentifier forIndexPath:indexPath];
  if(self.eventArray)
  {
    cell.event = [self.eventArray objectAtIndex:indexPath.row];
//    cell.eventDict = [self.eventArray objectAtIndexedSubscript:indexPath.row];
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  EventDetailTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
  NSString *eventType = cell.event.eventType;
  if ([eventType isEqualToString:RegisterEvent]) {
    [self showRegisterPatientVCAtCell:cell];
  }
  else if ([eventType isEqualToString:RegisterScreeningEvent]){
    [self showRegisterPatientVCAtCell:cell];
  }
  else if ([eventType isEqualToString:ScreenEvents]){
    [self showPatientListVCAtCell:cell];
  }

}

- (void)showRegisterPatientVCAtCell: (EventDetailTableViewCell*)cell {
  PatientInformationViewController *patientInfoVC = [kMainStoryBoard instantiateViewControllerWithIdentifier:kPatientInfoVCIndetifier];
  patientInfoVC.token = _token;
  patientInfoVC.formType = kPatientRegistratinFormType;
  Form *form = cell.event.form;
  patientInfoVC.formId = form.formId;
  patientInfoVC.event = cell.event;
  [self.navigationController pushViewController:patientInfoVC animated:YES];
}

- (void)showPatientListVCAtCell: (EventDetailTableViewCell*)cell {
  ICSPatientsListViewController *patientListVC = [kMainStoryBoard
            instantiateViewControllerWithIdentifier:kPatientsListVCIdentifier];
  patientListVC.token = _token;
  patientListVC.eventId = cell.event.eventId;
  [self.navigationController pushViewController:patientListVC animated:YES];
}
@end

