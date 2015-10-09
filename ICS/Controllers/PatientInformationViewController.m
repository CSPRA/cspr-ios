//
//  PatientInformationViewController.m
//  ICS
//
//  Created by aam-fueled on 09/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "PatientInformationViewController.h"
#import <XLForm/XLForm.h>

NSString *const kFullName = @"Full Name";
NSString *const kGender = @"Gender";
NSString *const kDOB = @"Date of birth";
NSString *const kPhoneNumber = @"PhoneNumber";
NSString *const kAddPhone = @"Add Phone Number";
NSString *const kEmail = @"Email";
NSString *const kAddEmail = @"Add Email";
NSString *const kAddress = @"Address";
NSString *const kEatingHabits = @"Eating Habits";
NSString *const kConsumeCigarettes = @"Consume Cigarettes";
NSString *const kConsumeAlcohal = @"ConsumeAlcohal";
NSString *const kNotes = @"notes";

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
  XLFormSectionDescriptor *phoneSection = [XLFormSectionDescriptor formSectionWithTitle:@""];
  [form addFormSection:phoneSection];
  
  [self addRowWithTag:kPhoneNumber
              rowType:XLFormRowDescriptorTypePhone
                title:kPhoneNumber
              section:phoneSection];
  
  [self addRowWithTag:kAddPhone
              rowType:XLFormRowDescriptorTypeButton
                title:kAddPhone
              section:phoneSection];
  
  //Email fields
  XLFormSectionDescriptor *emailSection = [XLFormSectionDescriptor formSectionWithTitle:@""];
  [form addFormSection:emailSection];
  
  [self addRowWithTag:kEmail
              rowType:XLFormRowDescriptorTypeEmail
                title:kEmail
              section:emailSection];
  
  [self addRowWithTag:kAddEmail
              rowType:XLFormRowDescriptorTypeButton
                title:kAddEmail
              section:emailSection];
  
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
  
  
  self.form = form;
}

@end
