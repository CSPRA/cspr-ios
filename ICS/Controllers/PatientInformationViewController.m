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
static NSString *const kAddPhone = @"Add Phone Number";
static NSString *const kAddEmail = @"Add Email";
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
@property (nonatomic, strong) NSDictionary *personalInfoDict;
@end

@implementation PatientInformationViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self setupNavigationBar];
  [self fetchPatientPersonalInfo];
  
    return self;
}
- (void)setupNavigationBar {
  self.navigationItem.title = @"Patient Info";
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(nextTapped:)];
}
- (void)nextTapped:(UIBarButtonItem*)sender {
//  UIViewController *patientHabitsVC = [self.storyboard instantiateViewControllerWithIdentifier:kPatientHabitsVCIdentifier];
//  [self.navigationController pushViewController:patientHabitsVC animated:YES];
}
- (void)fetchPatientPersonalInfo {
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  [kDataSource fetchPatientPersonalInfoWith:_token patienttId:_pId completionBlock:^(BOOL success, NSDictionary *result, NSError *error) {
    self.personalInfoDict = result;
    [self setupForm];
  }];
}
#warning dummy data: remove when api integrated.
- (void)initializeDummyData {

//    Doctor *doc1 = [[Doctor alloc] init];
//    doc1.doctorId = @"doc1";
//    doc1.firstName= @"Arun";
//    doc1.lastName = @"Jain";
//    doc1.location = @"Bangalore";
//    doc1.specialization = @"Cancer Specialist";
//    doc1.doctorRatingValue = @(3);
//    
//    Doctor *doc2 = [[Doctor alloc] init];
//    doc2.doctorId = @"doc2";
//    doc2.firstName= @"Biswas";
//    doc2.lastName = @"Rao";
//    doc2.location = @"Delhi";
//    doc2.specialization = @"Cancer Specialist";
//    doc2.doctorRatingValue = @(3);
//    
//    
//    Doctor *doc3 = [[Doctor alloc] init];
//    doc3.doctorId = @"doc3";
//    doc3.firstName= @"Arun";
//    doc3.lastName = @"Jain";
//    doc3.location = @"Bangalore";
//    doc3.specialization = @"Cancer Specialist";
//    doc3.doctorRatingValue = @(3);
//    
//    
//    Doctor *doc4 = [[Doctor alloc] init];
//    doc4.doctorId = @"doc4";
//    doc4.firstName= @"Sunil";
//    doc4.lastName = @"Jain";
//    doc4.location = @"Bangalore";
//    doc4.specialization = @"Cancer Specialist";
//    doc1.doctorRatingValue = @(3);
//    
//    NSMutableArray *doctorArray = [[NSMutableArray alloc] initWithObjects:doc1,doc2,doc3,doc4, nil];
//    self.doctorList = doctorArray;
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

- (XLFormRowDescriptor*)addRowWithTag:(NSString *)tag rowType:(NSString *)rowType title:(NSString *)title {
    XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:tag
                                                                     rowType:rowType
                                                                       title:title];
    row = [self customizationOFRow:row];
    if ([rowType isEqualToString:XLFormRowDescriptorTypeButton]) {
        row.action.formSelector = @selector(didTappedButtonRow:);
    }
    
  return row;
}

#pragma mark - form intialization
- (void)setupForm {
    XLFormDescriptor *form = [XLFormDescriptor formDescriptorWithTitle:@"Patient Information"];
    XLFormSectionDescriptor *section = [XLFormSectionDescriptor formSectionWithTitle:@""];
    XLFormRowDescriptor *row;
    [form addFormSection:section];
    
    //name field
    row = [self addRowWithTag:kFirstName
                rowType:XLFormRowDescriptorTypeName
                  title:kFullName];
//  row.value = [self.parentViewController valueForKey:kFirstName];
  [section addFormRow:row];
  row = [self addRowWithTag:kLastName
                    rowType:XLFormRowDescriptorTypeName
                      title:kLastName];
  //  row.value = [self.parentViewController valueForKey:kFirstName];
  [section addFormRow:row];

    
    //gender field
   row = [self addRowWithTag:kGender
                rowType:XLFormRowDescriptorTypeText
                  title:kGender];
//  row.value = [self.parentViewController valueForKey:kGender];
  [section addFormRow:row];

    
    //date of birth field
   row = [self addRowWithTag:kDOB
                rowType:XLFormRowDescriptorTypeDate
                  title:kDOB];
//  row.value = [self.parentViewController valueForKey:kDOB];
  [section addFormRow:row];

    
    //phone number fields
    
   row = [self addRowWithTag:kPhoneNumber
                rowType:XLFormRowDescriptorTypePhone
                  title:kPhoneNumber];
//  row.value = [self.parentViewController valueForKey:kPhoneNumber];
  [section addFormRow:row];
  
    //Email fields
    
  row =  [self addRowWithTag:kEmail
                rowType:XLFormRowDescriptorTypeEmail
                  title:kEmail];
//   row.value = [self.parentViewController valueForKey:kEmail];
  [section addFormRow:row];

    
    //address field
   row = [self addRowWithTag:kAddress
                rowType:XLFormRowDescriptorTypeTextView
                  title:kAddress];
//  row.value = [self.parentViewController valueForKey:kAddress];
  [section addFormRow:row];

 
  row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Done" rowType:XLFormRowDescriptorTypeButton title:@"Done"];
      row.action.formSelector = @selector(didTappedDone:);

  [section addFormRow:row];
  
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kAssignDoctor rowType:XLFormRowDescriptorTypeCustomButton title:kAssignDoctor];
//    row.value = kButtonTypeAssignDoctor;
//    row.action.formSelector = @selector(didTappedAssignDoctor:);
//    [section addFormRow:row];
  
    self.form = form;
}

- (void)didTappedDone: (XLFormRowDescriptor*)row {
  NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:self.formValues];
  [params removeObjectForKey:@"Done"];
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  [kDataSource registerPatientWithParameters:params completionBlock:^(BOOL success, NSDictionary *result, NSError *error) {
    
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
  section.hidden = [NSString stringWithFormat:@"$%@==0", khidesection];
  [self.form addFormSection:section];
  [doctorsArray enumerateObjectsUsingBlock:^(Doctor *doctor, NSUInteger idx, BOOL * _Nonnull stop) {
    [self addDoctorInfoCell:doctor section:section];
  }];
  
}

- (void)didTappedAssignDoctor:(XLFormRowDescriptor*)sender {
  NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
  [param setObject:_token forKey:@"token"];
  [param setObject:self.formValues forKey:@"formValues"];
  
  [kDataSource registerPatientWithParameters:param
                             completionBlock:^(BOOL success, NSDictionary *result, NSError *error) {
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
  

}

#pragma DoctorInformationCellDelegate
- (void)didAssignedDoctor:(DoctorInformationCell *)cell {
    NSLog(@"doctor assigned %@",cell.nameLabel.text);
}


@end
