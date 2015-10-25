//
//  RegisterViewController.m
//  ICS
//
//  Created by Aqsa on 23/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "RegisterViewController.h"
#import <XLForm/XLForm.h>
#import "ICSFloatLabeledTextFieldCell.h"

static NSString *const kFirstName = @"First Name";
static NSString *const kLastName = @"Last Name";
static NSString *const kUsername = @"Username";
static NSString *const kPassword = @"Password";
static NSString *const kPhoneNumber = @"Phone Number";
static NSString *const kEmail = @"Email";
static NSString *const kDoneButton = @"Done";

static NSString *const kPasswordRegx = @"^(?=.*\\d)(?=.*[A-Za-z]).{6,32}$";

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.navigationController setNavigationBarHidden:NO animated:NO];
  UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
  self.navigationItem.backBarButtonItem = backItem;
  self.navigationItem.title = @"Volunteer Registration";
//  [self initializeForm];
  // Do any additional setup after loading the view.
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    [self initializeForm];
  }
  return self;
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
-(void)initializeForm
{
  XLFormDescriptor * form = [XLFormDescriptor formDescriptor];
  XLFormSectionDescriptor * section;
  XLFormRowDescriptor * row;
  
  section = [XLFormSectionDescriptor formSection];
  [form addFormSection:section];
  
  //First Name field
  row = [XLFormRowDescriptor formRowDescriptorWithTag:kFirstName rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:kFirstName];
  [section addFormRow:row];
  
  row = [XLFormRowDescriptor formRowDescriptorWithTag:kLastName rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:kLastName];
  [section addFormRow:row];
  
  row = [XLFormRowDescriptor formRowDescriptorWithTag:kUsername rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:kUsername];
  row.required = YES;
  [section addFormRow:row];
  
  // Email
  row = [XLFormRowDescriptor formRowDescriptorWithTag:kEmail rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:kEmail];
  row.required = YES;
  [row addValidator:[XLFormValidator emailValidator]];
  [section addFormRow:row];
  
  
  NSString *footerTitle = @"between 6 and 32 charachers, 1 alphanumeric and 1 numeric";
  
  // Password
  row = [XLFormRowDescriptor formRowDescriptorWithTag:kPassword rowType:XLFormRowDescriptorTypePassword];
 
  [row.cellConfigAtConfigure setObject:@"Password" forKey:@"textField.placeholder"];
  [row.cellConfigAtConfigure setObject:@(NSTextAlignmentLeft) forKey:@"textField.textAlignment"];
  
  row.required = YES;
  [row addValidator:[XLFormRegexValidator formRegexValidatorWithMsg:@"At least 6, max 32 characters" regex:kPasswordRegx]];
  [section addFormRow:row];
  
  
  row = [XLFormRowDescriptor formRowDescriptorWithTag:kDoneButton rowType:XLFormRowDescriptorTypeButton title:kDoneButton];
  row.action.formSelector = @selector(didTappedDoneButton:);
  [section addFormRow:row];
  
  self.form = form;
}


#pragma mark - actions
- (void)didTappedDoneButton: (XLFormRowDescriptor*)row {
  NSLog(@"@form data %@", self.form.formValues);
  [self validateForm];
  [self.tableView endEditing:YES];
}

-(void)validateForm
{
  NSArray * array = [self formValidationErrors];
  [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    XLFormValidationStatus * validationStatus = [[obj userInfo] objectForKey:XLValidationStatusErrorKey];
    if ([validationStatus.rowDescriptor.tag isEqualToString:kUsername]){
      UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:[self.form indexPathOfFormRow:validationStatus.rowDescriptor]];
      cell.backgroundColor = [UIColor redColor];
      [UIView animateWithDuration:0.3 animations:^{
        cell.backgroundColor = [UIColor whiteColor];
        [self animateCell:cell];
      }];
    }
    else if ([validationStatus.rowDescriptor.tag isEqualToString:kEmail]){
      UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:[self.form indexPathOfFormRow:validationStatus.rowDescriptor]];
      cell.backgroundColor = [UIColor redColor];
      [UIView animateWithDuration:0.3 animations:^{
        cell.backgroundColor = [UIColor whiteColor];
        [self animateCell:cell];
      }];
    }
    else if ([validationStatus.rowDescriptor.tag isEqualToString:kPassword]){
      UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:[self.form indexPathOfFormRow:validationStatus.rowDescriptor]];
      cell.backgroundColor = [UIColor redColor];
      [UIView animateWithDuration:0.3 animations:^{
        cell.backgroundColor = [UIColor whiteColor];
        [self animateCell:cell];

      }];
    }
    
  }];
}


#pragma mark - Helper

-(void)animateCell:(UITableViewCell *)cell
{
  CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
  animation.keyPath = @"position.x";
  animation.values =  @[ @0, @20, @-20, @10, @0];
  animation.keyTimes = @[@0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1];
  animation.duration = 0.3;
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  animation.additive = YES;
  
  [cell.layer addAnimation:animation forKey:@"shake"];
}


@end
