//
//  ICSHomeViewController.m
//  ICS
//
//  Created by aqsa-fueled on 16/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "ICSHomeViewController.h"
#import "Event.h"
#import "SharedModel.h"

@interface ICSHomeViewController ()<UITableViewDelegate,
UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *eventArray;


@end

@implementation ICSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  [self initializeData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeData {
  
  Event *event1 = [kDataSource eventWithId:1];
  event1.eventName = @"Registration";
  event1.eventType = @"Throat Cancer";
  
  Event *event2 = [kDataSource eventWithId:2];
  event1.eventType = @"Throat Cancer";
  event2.eventName = @"Screening";
  
  self.eventArray = [NSArray arrayWithObjects:event1,event2, nil];

}

#pragma mark - TableView Delegate and DataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.eventArray.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *Cell = [self.tableView dequeueReusableCellWithIdentifier:kEventDetailCellIdentifier forIndexPath:indexPath];
  return Cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UIViewController *patientListVC = [self.storyboard instantiateViewControllerWithIdentifier:kPatientsListVCIdentifier];
  [self.navigationController pushViewController:patientListVC animated:YES];
}

@end
