//
//  ICSHomeViewController.m
//  ICS
//
//  Created by aqsa-fueled on 16/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "ICSHomeViewController.h"
#import "EventDetailTableViewCell.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "Volunteer.h"

@interface ICSHomeViewController ()<UITableViewDelegate,
UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *eventArray;
@property (nonatomic, strong) Volunteer *volunteer;

@end

@implementation ICSHomeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = @"ICS Events";
  if (!self.eventArray) {
    [self offlineData];
  }
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)offlineData{
  NSDictionary *cancer1 = @{
                            @"cancerId":@(1),
                            @"cancerName":@"Throat Cancer",
                            @"description":@"Throat cancer refers to cancerous tumors that develop in your throat (pharynx), voice box (larynx) or tonsils."
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
  self.eventArray = results;
 }

- (void)initializeData {
  NSString *token = self.volunteer.token;
  
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  [kDataSource fetchEventsWithToken:token
                    completionBlock:^(BOOL success, NSDictionary *result, NSError *error) {
                      if (success) {
                        self.eventArray = [NSArray arrayWithObject:result];
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
//    cell.eventNameLabel.text = [[self.eventArray objectAtIndex:indexPath.row] valueForKey:@"eventName"];
//    cell.eventTypeLabel.text = [[self.eventArray objectAtIndex:indexPath.row] valueForKey:@"eventType"];
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UIViewController *patientListVC = [self.storyboard instantiateViewControllerWithIdentifier:kPatientsListVCIdentifier];
  [self.navigationController pushViewController:patientListVC animated:YES];
}

@end
