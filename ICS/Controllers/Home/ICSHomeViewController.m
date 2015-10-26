//
//  ICSHomeViewController.m
//  ICS
//
//  Created by aqsa-fueled on 16/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "ICSHomeViewController.h"
#import "Event.h"
#import "EventDetailTableViewCell.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface ICSHomeViewController ()<UITableViewDelegate,
UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *eventArray;


@end

@implementation ICSHomeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  if (!self.eventArray) {
    [self initializeData];
  }
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)initializeData {
  NSString *token = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjIsImlzcyI6Imh0dHA6XC9cL2NzcHItd2ViLWRldi5lbGFzdGljYmVhbnN0YWxrLmNvbVwvdm9sdW50ZWVyXC9sb2dpbiIsImlhdCI6IjE0NDU0Mjk0NTgiLCJleHAiOiIxNDQ1NDMzMDU4IiwibmJmIjoiMTQ0NTQyOTQ1OCIsImp0aSI6IjdiOTE0MzJhY2E2OWRiNTdlN2M4YTU3MDI3YmI4OWY3In0.TYWBbzVOHG8EnLf0vHorTTkELKMVbRRavjwY6HXhCys";
  
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  [kDataSource fetchEventsWithToken:token
                    completionBlock:^(BOOL success, NSDictionary *result, NSError *error) {
                      if (success) {
                        self.eventArray = result;
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
    cell.eventNameLabel.text = [[self.eventArray objectAtIndex:indexPath.row] valueForKey:@"eventName"];
    cell.eventTypeLabel.text = [[self.eventArray objectAtIndex:indexPath.row] valueForKey:@"eventType"];
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UIViewController *patientListVC = [self.storyboard instantiateViewControllerWithIdentifier:kPatientsListVCIdentifier];
  [self.navigationController pushViewController:patientListVC animated:YES];
}

@end
