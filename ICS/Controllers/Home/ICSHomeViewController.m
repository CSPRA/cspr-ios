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

static NSString *const RegisterEvent = @"register";
static NSString *const RegisterScreeningEvent = @"register_screen";

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
  self.eventArray = [[NSMutableArray alloc] init];
  NSArray *savedEventList = [kSharedModel fetchObjectWithEntityName:kEventEntityName];

  if ([ICSUtilities hasActiveConnection]) {
    [self.eventArray addObjectsFromArray: [self fetchLatestEvents]];
    [self.tableView reloadData];
  }else if(savedEventList){
    [self.eventArray addObjectsFromArray:savedEventList];
  }
}

- (void)setupNavigationBar {
  self.navigationItem.title = @"ICS Events";

}

- (void)offlineData{
  NSDictionary *cancer1 = @{
                            @"cancerId":@(1),
                            @"cancerName":@"Throat Cancer",
                            @"description":@"Throat cancer refers to cancerous tumors that develop in your throat (pharynx), voice box (larynx) or tonsils.hroat cancer refers to cancerous tumors that develop in your throat (pharynx), voice box (larynx) or tonsils.hroat cancer refers to cancerous tumors that develop in your throat (pharynx), voice box (larynx) or tonsils.hroat cancer refers to cancerous tumors that develop in your throat (pharynx), voice box (larynx) or tonsils."
                            };
  NSDictionary *form1 = @{
                          @"formId":@(1),
                          @"formName":@"Throat Cancer Detection Form",
                          @"formDescription":@"This form contains ragarding diagnosis of Throat Cancer"
                          };
  
  NSDictionary *event1 = @{
    @"eventId": @(1),
    @"eventName":@"Spot Registration For Throat Cancer",
    @"eventType":@"register",
    @"startingDate":@"0000-00-00",
    @"endingDate":@"0000-00-00",
    @"form": @{},
    @"cancerType":cancer1
    };
  
  NSDictionary *event2 = @{
                           @"eventId":@(4),
                           @"eventName":@"Registration cum Screening camp for Throat Cancer",
                           @"eventType":@"register_screen",
                           @"startingDate":@"2015-12-01",
                           @"endingDate":@"2015-12-10",
                           @"form":form1,
                           @"cancerType":cancer1
                           };
  
  NSArray *results = @[event1, event2];
  [self.eventArray addObject:results];
 }

- (NSArray*)fetchLatestEvents {
   __block NSArray *fetchedEvents;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [kDataSource fetchEventsWithToken:self.token
                      completionBlock:^(BOOL success, NSDictionary *result, NSError *error) {
                        if (success) {
                          fetchedEvents = [result objectForKey:@"results"];
                        }else if (error){
                          NSLog(@"%@",error);
                        }
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                      }];
  return fetchedEvents;
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
    [self showPatientListVCAtCell:cell];
  }
}

- (void)showRegisterPatientVCAtCell: (EventDetailTableViewCell*)cell {
  PatientInformationViewController *patientInfoVC = [kMainStoryBoard instantiateViewControllerWithIdentifier:kPatientInfoVCIndetifier];
  patientInfoVC.token = _token;
  patientInfoVC.formType = kPatientRegistratinFormType;
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
