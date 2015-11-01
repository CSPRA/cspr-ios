//
//  DoctorsListViewController.m
//  ICS
//
//  Created by Aqsa on 01/11/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "DoctorsListViewController.h"
#import "DoctorInformationCell.h"
static NSString *const kDoctorBasicInfo = @"Doctor Basic Info";
static NSString *const kAssignDoctor = @"Assign Doctor";
static NSString * const kCustomRowFirstRatingTag = @"CustomRowFirstRatingTag";
static NSString * const kCustomRowSecondRatingTag = @"CustomRowSecondRatingTag";

@interface DoctorsListViewController ()

@end

@implementation DoctorsListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
//  [self initialSetup];
}
-(void)initializeForm
{
  XLFormDescriptor * form = [XLFormDescriptor formDescriptorWithTitle:@"Doctors"];
  XLFormSectionDescriptor * section;
  XLFormRowDescriptor * row;
  
  // Section Ratings
  section = [XLFormSectionDescriptor formSectionWithTitle:@"Ratings"];
  [form addFormSection:section];
  
  row = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFirstRatingTag rowType:XLFormRowDescriptorTypeRate title:@"First Rating"];
  row.value = @(3);
  [section addFormRow:row];
  
  row = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowSecondRatingTag rowType:XLFormRowDescriptorTypeRate title:@"Second Rating"];
  row.value = @(1);
  [section addFormRow:row];
  
   self.form = form;
}



- (void)initialSetup {
  [self initializeForm];
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
  //  section.hidden = [NSString stringWithFormat:@"$%@==0", khidesection];
  [self.form addFormSection:section];
  [doctorsArray enumerateObjectsUsingBlock:^(Doctor *doctor, NSUInteger idx, BOOL * _Nonnull stop) {
    [self addDoctorInfoCell:doctor section:section];
  }];
  
}

- (void)didTappedAssignDoctor:(XLFormRowDescriptor*)sender {
  NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
  [param setObject:self.formValues forKey:@"formValues"];
  
}

#pragma DoctorInformationCellDelegate
- (void)didAssignedDoctor:(DoctorInformationCell *)cell {
  NSLog(@"doctor assigned %@",cell.nameLabel.text);
}


@end
