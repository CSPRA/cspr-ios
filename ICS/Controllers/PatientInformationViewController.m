//
//  PatientInformationViewController.m
//  ICS
//
//  Created by aam-fueled on 09/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "PatientInformationViewController.h"
#import <XLForm/XLForm.h>
#import "RatingViewCell.h"

NSString *const kFullName = @"Full Name";
NSString *const kGender = @"Gender";
NSString *const kDOB = @"Date of birth";
NSString *const kPhoneNumber = @"Phone Number";
NSString *const kAddPhone = @"Add Phone Number";
NSString *const kEmail = @"Email";
NSString *const kAddEmail = @"Add Email";
NSString *const kAddress = @"Address";
NSString *const kEatingHabits = @"Eating Habits";
NSString *const kConsumeCigarettes = @"Consume Cigarettes";
NSString *const kConsumeAlcohal = @"ConsumeAlcohal";
NSString *const kConsumePanMasala = @"Consume Pan Masala";
NSString *const kAddOtherAdiction = @"Add Other Adiction";
NSString *const kMedicalHistory = @"Medical History";
NSString *const kDoctorBasicInfo = @"Doctor Basic Info";
NSString *const kAssignDoctor = @"Assign Doctor";
static NSString * const kCustomRowFirstRatingTag = @"CustomRowFirstRatingTag";
static NSString * const kCustomRowSecondRatingTag = @"CustomRowSecondRatingTag";

@interface PatientInformationViewController ()
@end

@implementation PatientInformationViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  [self setupForm];
  return self;
}

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
  
 row = [self addRowWithTag:kAssignDoctor
              rowType:XLFormRowDescriptorTypeButton
                title:kAssignDoctor
              section:section];
  
  row.action.formSelector = @selector(didTappedAssignDoctor:);
  [section addFormRow:row];

  [section addFormRow:[self addRatingCell]];
  self.form = form;
}

- (XLFormRowDescriptor*)addRatingCell {
 
    XLFormRowDescriptor * row;
    
    // Section Ratings
  
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFirstRatingTag rowType:XLFormRowDescriptorTypeRate title:@"First Rating"];
    row.value = @(3);
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowSecondRatingTag rowType:XLFormRowDescriptorTypeRate title:@"Second Rating"];
    row.value = @(1);
  return row;
}
- (void)didTappedAssignDoctor:(XLFormRowDescriptor*)sender {
  
}
@end
