//
//  DoctorsListViewController.m
//  ICS
//
//  Created by Aqsa on 01/11/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "DoctorsListViewController.h"
#import "DoctorInformationCell.h"
#import <XLForm/XLForm.h>
#import "ICSUtilities.h"
#import "UIView+ICSAdditions.h"

static NSString *const kDoctorBasicInfo = @"Doctor Basic Info";
static NSString *const kAssignDoctor = @"Assign Doctor";
static NSString * const kCustomRowFirstRatingTag = @"CustomRowFirstRatingTag";
static NSString * const kCustomRowSecondRatingTag = @"CustomRowSecondRatingTag";
static NSInteger const kCellHieght = 140.0;

@interface DoctorsListViewController ()
@property (nonatomic,strong) NSArray *doctorsList;
@end

@implementation DoctorsListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initialSetup];
}


-(void)initializeForm
{
  XLFormDescriptor * form = [XLFormDescriptor formDescriptorWithTitle:@"Doctors"];
  XLFormSectionDescriptor * section = [XLFormSectionDescriptor formSection];
  [self.doctorsList enumerateObjectsUsingBlock:^(Doctor *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [self addDoctorInfoCell:obj section:section];
  }];
  [form addFormSection:section];
  self.form = form;
}


- (void)initialSetup {
  [self.view ICSViewBackgroungColor];
  self.tableView.backgroundColor = [UIColor clearColor];
  self.tableView.allowsSelection = NO;
  self.doctorsList = [kSharedModel fetchObjectsWithEntityName:kDoctorEntityName];
  if(self.doctorsList){
    [self initializeForm];
  }
  if (![ICSUtilities hasActiveConnection]) {
    [self fetchDoctorsList];
  }
}
- (void)fetchDoctorsList {
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  [kDataSource fetchDoctorsWithToken:_token completionBlock:^(BOOL success, NSDictionary *result, NSError *error) {
    if (success) {
      self.doctorsList = [result objectForKey:@"result"];
    }else if (error){
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
      [alert show];
    }
    [self initializeForm];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
  }];
  
}
#pragma mark - Handling assign doctors section

- (void)addDoctorInfoCell:(Doctor*)doctor section:(XLFormSectionDescriptor*)section {
  XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFirstRatingTag rowType:XLFormRowDescriptorTypeRate title:@"Rating"];
  NSDictionary *value =[NSDictionary dictionaryWithObjects:@[doctor,self] forKeys:@[@"doctorInfo",@"delegateInfo"]];
  row.value = value;
  [section addFormRow:row];
}

- (void)addAssignDoctorSectionWithDoctorList:(NSArray*)doctorsArray {
  
  XLFormSectionDescriptor *section = [XLFormSectionDescriptor formSectionWithTitle:@"Assign Doctor From List"];
  [self.form addFormSection:section];
  [doctorsArray enumerateObjectsUsingBlock:^(Doctor *doctor, NSUInteger idx, BOOL * _Nonnull stop) {
    [self addDoctorInfoCell:doctor section:section];
  }];
  
}

- (void)didTappedAssignDoctor:(XLFormRowDescriptor*)sender {
  NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
  [param setObject:self.formValues forKey:@"formValues"];
  
}

#pragma mark - UITableViewCell delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return kCellHieght;
}



#pragma DoctorInformationCellDelegate
- (void)didAssignedDoctor:(DoctorInformationCell *)cell {
    NSLog(@"doctor assigned %@",cell.doctor.firstName);
  NSArray *visibleCells = [self.tableView visibleCells];
  
  [visibleCells enumerateObjectsUsingBlock:^(DoctorInformationCell *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [obj setSelected:NO];
  }];
  [cell setSelected:YES];
  
}


@end
