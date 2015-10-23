//
//  PatientInformationViewController.m
//  ICS
//
//  Created by aam-fueled on 09/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "PatientInformationViewController.h"
#import <XLForm/XLForm.h>
#import "DoctorInformationCell.h"
#import "Doctor.h"
#import "CustomFormButtonCell.h"

static NSString *const kFullName = @"Full Name";
static NSString *const kGender = @"Gender";
static NSString *const kDOB = @"Date of birth";
static NSString *const kPhoneNumber = @"Phone Number";
static NSString *const kAddPhone = @"Add Phone Number";
static NSString *const kEmail = @"Email";
static NSString *const kAddEmail = @"Add Email";
static NSString *const kAddress = @"Address";
static NSString *const kEatingHabits = @"Eating Habits";
static NSString *const kConsumeCigarettes = @"Consume Cigarettes";
static NSString *const kConsumeAlcohal = @"ConsumeAlcohal";
static NSString *const kConsumePanMasala = @"Consume Pan Masala";
static NSString *const kAddOtherAdiction = @"Add Other Adiction";
static NSString *const kMedicalHistory = @"Medical History";
static NSString *const kDoctorBasicInfo = @"Doctor Basic Info";
static NSString *const kAssignDoctor = @"Assign Doctor";
static NSString * const kCustomRowFirstRatingTag = @"CustomRowFirstRatingTag";
static NSString * const kCustomRowSecondRatingTag = @"CustomRowSecondRatingTag";
static NSString * const khidesection = @"tag1";
static NSString * const token = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjIsImlzcyI6Imh0dHA6XC9cL2NzcHItd2ViLWRldi5lbGFzdGljYmVhbnN0YWxrLmNvbVwvdm9sdW50ZWVyXC9sb2dpbiIsImlhdCI6IjE0NDU0Mjk0NTgiLCJleHAiOiIxNDQ1NDMzMDU4IiwibmJmIjoiMTQ0NTQyOTQ1OCIsImp0aSI6IjdiOTE0MzJhY2E2OWRiNTdlN2M4YTU3MDI3YmI4OWY3In0.TYWBbzVOHG8EnLf0vHorTTkELKMVbRRavjwY6HXhCys";

@interface PatientInformationViewController ()<DoctorInformationCellDelegate>
@property (nonatomic, strong) NSArray *doctorList;
@end

@implementation PatientInformationViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  [self setupNavigationBar];
  [self setupForm];
  
  return self;
}
- (void)setupNavigationBar {
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(nextTapped:)];
}
- (void)nextTapped:(UIBarButtonItem*)sender {
  UIViewController *patientHabitsVC = [self.storyboard instantiateViewControllerWithIdentifier:kPatientHabitsVCIdentifier];
  [self.navigationController pushViewController:patientHabitsVC animated:YES];
}

#warning dummy data: remove when api integrated.
- (void)initializeDummyData {
  Doctor *doc1 = [[Doctor alloc] init];
  doc1.doctorId = 1;
  doc1.firstName= @"Arun";
  doc1.lastName = @"Jain";
  doc1.address = @"Bangalore";
  doc1.specialization = @"Cancer Specialist";
  doc1.ratingValue = 3;
  
  Doctor *doc2 = [[Doctor alloc] init];
  doc2.doctorId = 2;
  doc2.firstName= @"Biswas";
  doc2.lastName = @"Rao";
  doc2.address = @"Delhi";
  doc2.specialization = @"Cancer Specialist";
  doc2.ratingValue = 2;
  
  
  Doctor *doc3 = [[Doctor alloc] init];
  doc3.doctorId = 3;
  doc3.firstName= @"Arun";
  doc3.lastName = @"Jain";
  doc3.address = @"Bangalore";
  doc3.specialization = @"Cancer Specialist";
  doc3.ratingValue = 4;
  
  
  NSMutableArray *doctorArray = [[NSMutableArray alloc] initWithObjects:doc1,doc2,doc3, nil];
  self.doctorList = doctorArray;
}

#pragma mark - row configuration
- (void)didTappedButtonRow:(XLFormRowDescriptor*)sender {
  if (sender.tag == kAddEmail) {
    [self addRowWithTag:kEmail
                rowType:XLFormRowDescriptorTypeEmail
                  title:kEmail
                section:sender.sectionDescriptor
              beforeRow:sender];
  }
  if (sender.tag == kAddPhone) {
    [self addRowWithTag:kPhoneNumber
                rowType:XLFormRowDescriptorTypePhone
                  title:kPhoneNumber
                section:sender.sectionDescriptor
              beforeRow:sender];
    
  }
  
  NSIndexPath *index = [self.tableView indexPathForSelectedRow];
  [self.tableView deselectRowAtIndexPath:index animated:YES];
}

- (XLFormRowDescriptor*)customizationOFRow:(XLFormRowDescriptor*)row {
  [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
  [row.cellConfig setObject:[UIFont fontWithName:@"Helvetica" size:12] forKey:@"textLabel.font"];
  [row.cellConfig setObject:@(NSTextAlignmentLeft) forKey:@"textLabel.textAlignment"];
  
  if ([row.cellConfig valueForKey:@"textField"]) {
    
    [row.cellConfig setObject:[UIColor lightGrayColor] forKey:@"textField.backgroundColor"];
    [row.cellConfig setObject:[UIFont fontWithName:@"Helvetica" size:20] forKey:@"textField.font"];
    [row.cellConfig setObject:@(NSTextAlignmentLeft) forKey:@"textField.textAlignment"];
  }
  
  return row;
}
- (void)addRowWithTag:(NSString *)tag rowType:(NSString *)rowType title:(NSString *)title section:(XLFormSectionDescriptor*)section beforeRow:(XLFormRowDescriptor*)beforeRow{
  XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:tag
                                                                   rowType:rowType
                                                                     title:title];
  row = [self customizationOFRow:row];
  if ([rowType isEqualToString:XLFormRowDescriptorTypeButton]) {
    row.action.formSelector = @selector(didTappedButtonRow:);
  }
  
  [section addFormRow:row beforeRow:beforeRow];
}

- (void)addRowWithTag:(NSString *)tag rowType:(NSString *)rowType title:(NSString *)title section:(XLFormSectionDescriptor*)section {
  XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:tag
                                                                   rowType:rowType
                                                                     title:title];
  row = [self customizationOFRow:row];
  if ([rowType isEqualToString:XLFormRowDescriptorTypeButton]) {
    row.action.formSelector = @selector(didTappedButtonRow:);
  }
  
  [section addFormRow:row];
}

#pragma mark - form intialization
- (void)setupForm {
  XLFormDescriptor *form = [XLFormDescriptor formDescriptorWithTitle:@"Patient Information"];
  XLFormSectionDescriptor *section = [XLFormSectionDescriptor formSectionWithTitle:@""];
  
  [form addFormSection:section];
  
  //name field
  [self addRowWithTag:kFullName
              rowType:XLFormRowDescriptorTypeName
                title:kFullName
              section:section];
  
  //gender field
  [self addRowWithTag:kGender
              rowType:XLFormRowDescriptorTypeText
                title:kGender
              section:section];
  
  //date of birth field
  [self addRowWithTag:kDOB
              rowType:XLFormRowDescriptorTypeDate
                title:kDOB
              section:section];
  
  //phone number fields
  
  [self addRowWithTag:kPhoneNumber
              rowType:XLFormRowDescriptorTypePhone
                title:kPhoneNumber
              section:section];
  
  [self addRowWithTag:kAddPhone
              rowType:XLFormRowDescriptorTypeButton
                title:kAddPhone
              section:section];
  
  //Email fields
  
  [self addRowWithTag:kEmail
              rowType:XLFormRowDescriptorTypeEmail
                title:kEmail
              section:section];
  
  [self addRowWithTag:kAddEmail
              rowType:XLFormRowDescriptorTypeButton
                title:kAddEmail
              section:section];
  
  //address field
  [self addRowWithTag:kAddress
              rowType:XLFormRowDescriptorTypeTextView
                title:kAddress
              section:section];
  
  //Eating habits field
  [self addRowWithTag:kEatingHabits
              rowType:XLFormRowDescriptorTypeText
                title:kEatingHabits
              section:section];
  
  [self addRowWithTag:kConsumeCigarettes
              rowType:XLFormRowDescriptorTypeBooleanSwitch
                title:kConsumeCigarettes
              section:section];
  
  [self addRowWithTag:kConsumeAlcohal
              rowType:XLFormRowDescriptorTypeBooleanSwitch
                title:kConsumeAlcohal
              section:section];
  
  XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:kAssignDoctor rowType:XLFormRowDescriptorTypeCustomButton title:kAssignDoctor];
  row.value = kButtonTypeAssignDoctor;
  row.action.formSelector = @selector(didTappedAssignDoctor:);
  [section addFormRow:row];
  
  self.form = form;
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
  section.hidden = [NSString stringWithFormat:@"$%@==0", khidesection];
  [self.form addFormSection:section];
  [doctorsArray enumerateObjectsUsingBlock:^(Doctor *doctor, NSUInteger idx, BOOL * _Nonnull stop) {
    [self addDoctorInfoCell:doctor section:section];
  }];
  
}

- (void)didTappedAssignDoctor:(XLFormRowDescriptor*)sender {
  NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
  [param setObject:token forKey:@"token"];
  [param setObject:self.formValues forKey:@"formValues"];
  
  [kDataSource registerPatientWithParameters:param completionBlock:^(BOOL success, NSArray *result, NSError *error) {
    if (success) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                      message:@"Patient Registered succesfully"
                                                     delegate:self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil, nil];
      [alert show];
    }
    else if (error){
      NSLog(@"%@",error);
    }
  }];
  
  //  if (!self.doctorList) {
  //    [self initializeDummyData];
  //    [self addAssignDoctorSectionWithDoctorList:self.doctorList];
  //  }
  //  else{
  //    return;
  //  }
}

#pragma DoctorInformationCellDelegate
- (void)didAssignedDoctor:(DoctorInformationCell *)cell {
  NSLog(@"doctor assigned %@",cell.nameLabel.text);
}


@end
