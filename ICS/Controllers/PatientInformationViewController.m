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

@interface PatientInformationViewController ()<DoctorInformationCellDelegate>
@property (nonatomic, strong) NSArray *doctorList;
@end

@implementation PatientInformationViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  [self setupForm];
  return self;
}

#warning dummy data: remove when api integrated.
- (void)initializeDummyData {
  Doctor *doc1 = [[Doctor alloc] init];
  doc1.doctorId = @"doc1";
  doc1.firstName= @"Arun";
  doc1.lastName = @"Jain";
  doc1.location = @"Bangalore";
  doc1.specialization = @"Cancer Specialist";
  doc1.doctorRatingValue = @(3);
  
  Doctor *doc2 = [[Doctor alloc] init];
  doc2.doctorId = @"doc2";
  doc2.firstName= @"Biswas";
  doc2.lastName = @"Rao";
  doc2.location = @"Delhi";
  doc2.specialization = @"Cancer Specialist";
  doc2.doctorRatingValue = @(3);

  
  Doctor *doc3 = [[Doctor alloc] init];
  doc3.doctorId = @"doc3";
  doc3.firstName= @"Arun";
  doc3.lastName = @"Jain";
  doc3.location = @"Bangalore";
  doc3.specialization = @"Cancer Specialist";
  doc3.doctorRatingValue = @(3);

  
  Doctor *doc4 = [[Doctor alloc] init];
  doc4.doctorId = @"doc4";
  doc4.firstName= @"Sunil";
  doc4.lastName = @"Jain";
  doc4.location = @"Bangalore";
  doc4.specialization = @"Cancer Specialist";
  doc1.doctorRatingValue = @(3);

  NSMutableArray *doctorArray = [[NSMutableArray alloc] initWithObjects:doc1,doc2,doc3,doc4, nil];
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
  if (!self.doctorList) {
    [self initializeDummyData];
    [self addAssignDoctorSectionWithDoctorList:self.doctorList];
  }
  else{
    return;
  }
}

#pragma DoctorInformationCellDelegate
- (void)didAssignedDoctor:(DoctorInformationCell *)cell {
  NSLog(@"doctor assigned %@",cell.nameLabel.text);
}
@end
