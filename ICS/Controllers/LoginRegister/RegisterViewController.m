//
//  RegisterViewController.m
//  ICS
//
//  Created by Aqsa on 23/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "RegisterViewController.h"
#import <XLForm/XLForm.h>

static NSString *const kFirstName = @"First Name";
static NSString *const kLastName = @"Last Name";
static NSString *const kUsername = @"Username";
static NSString *const kPhoneNumber = @"Phone Number";
static NSString *const kEmail = @"Email";
static NSString *const kDoneButton = @"Done";

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupForm];
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (void)addRowWithTag:(NSString *)tag rowType:(NSString *)rowType title:(NSString *)title section:(XLFormSectionDescriptor*)section {
  XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:tag
                                                                   rowType:rowType
                                                                     title:title];
  [section addFormRow:row];
}

#pragma mark - form intialization
- (void)setupForm {
  XLFormDescriptor *form = [XLFormDescriptor formDescriptorWithTitle:@"Patient Information"];
  XLFormSectionDescriptor *section = [XLFormSectionDescriptor formSectionWithTitle:@""];
  
  [form addFormSection:section];
  
  //name field
  [self addRowWithTag:kFirstName
              rowType:XLFormRowDescriptorTypeName
                title:kFirstName
              section:section];
  
  //gender field
  [self addRowWithTag:kLastName
              rowType:XLFormRowDescriptorTypeName
                title:kLastName
              section:section];
  
  //date of birth field
  [self addRowWithTag:kUsername
              rowType:XLFormRowDescriptorTypeText
                title:kUsername
              section:section];
  
  //phone number fields
  
  [self addRowWithTag:kPhoneNumber
              rowType:XLFormRowDescriptorTypePhone
                title:kPhoneNumber
              section:section];
  
  //Email fields
  
  [self addRowWithTag:kEmail
              rowType:XLFormRowDescriptorTypeEmail
                title:kEmail
              section:section];
  
  
  XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:kDoneButton rowType:XLFormRowDescriptorTypeButton title:kDoneButton];
  row.action.formSelector = @selector(didTappedDoneButton:);
  [section addFormRow:row];
  
  self.form = form;
}

- (void)didTappedDoneButton: (XLFormRowDescriptor*)row {
  
}

@end
