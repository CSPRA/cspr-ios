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

static NSString *const kFirstName = @"firstname";
static NSString *const kLastName = @"lastname";
static NSString *const kUsername = @"username";
static NSString *const kPassword = @"password";
static NSString *const kPhoneNumber = @"contactNumber";
static NSString *const kEmail = @"email";
static NSString *const kDoneButton = @"Done";
static NSString *const kPasswordRegx = @"^(?=.*\\d)(?=.*[A-Za-z]).{6,32}$";

@interface RegisterViewController ()
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self addObservers];
  
  [self.navigationController setNavigationBarHidden:NO animated:NO];
  UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
  self.navigationItem.backBarButtonItem = backItem;
  self.navigationItem.title = @"Volunteer Registration";
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

- (void)addObservers {
  self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endViewEditing:)];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter]addObserver:self
                                          selector:@selector(keyboardWillShow:)
                                              name:UIKeyboardWillShowNotification
                                            object:nil];
  
}
- (void)keyboardWillHide: (NSNotification*)notification{
  
  [self.tableView setContentOffset:CGPointZero animated:YES];
}

- (void)keyboardWillShow: (NSNotification*)notification{
  self.tableView.scrollEnabled = YES;
  NSDictionary *userInfo = [notification userInfo];
  CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  CGSize size = self.tableView.contentSize;
  size.height += kbSize.height;
  self.tableView.contentSize = size;
}


- (void)addRowWithTag:(NSString *)tag rowType:(NSString *)rowType title:(NSString *)title section:(XLFormSectionDescriptor*)section {
  XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:tag
                                                                   rowType:rowType
                                                                     title:title];
  [section addFormRow:row];
}
- (void)endViewEditing:(UITapGestureRecognizer*)tap
{
  [self.view endEditing:YES];
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
  
  //phone
  row = [XLFormRowDescriptor formRowDescriptorWithTag:kPhoneNumber rowType:XLFormRowDescriptorTypePhone];
  [row.cellConfigAtConfigure setObject:@"Phone Number" forKey:@"textField.placeholder"];
  row.required = YES;
  [section addFormRow:row];
  // Email
  row = [XLFormRowDescriptor formRowDescriptorWithTag:kEmail rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:kEmail];
  row.required = YES;
  [row addValidator:[XLFormValidator emailValidator]];
  [section addFormRow:row];
  
  // Password
  row = [XLFormRowDescriptor formRowDescriptorWithTag:kPassword rowType:XLFormRowDescriptorTypePassword];
 
  [row.cellConfigAtConfigure setObject:@"Password" forKey:@"textField.placeholder"];
  [row.cellConfigAtConfigure setObject:@(NSTextAlignmentLeft) forKey:@"textField.textAlignment"];
  
  row.required = YES;
  [row addValidator:[XLFormRegexValidator formRegexValidatorWithMsg:@"At least 6, max 32 characters" regex:kPasswordRegx]];
  [section addFormRow:row];
  [row addValidator:[XLFormRegexValidator formRegexValidatorWithMsg:@"At least 6, max 32 characters" regex:kPasswordRegx]];
  [section addFormRow:row];[row addValidator:[XLFormRegexValidator formRegexValidatorWithMsg:@"At least 6, max 32 characters" regex:kPasswordRegx]];
  [section addFormRow:row];
  row = [XLFormRowDescriptor formRowDescriptorWithTag:kDoneButton rowType:XLFormRowDescriptorTypeButton title:kDoneButton];
  row.action.formSelector = @selector(didTappedDoneButton:);
  [section addFormRow:row];
  
  self.form = form;
}


#pragma mark - actions
- (void)didTappedDoneButton: (XLFormRowDescriptor*)row {
  NSLog(@"@form data %@", self.form.formValues);
  if ([self validateForm]) {
    [self processEntries];
//    UIViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:kHomeVCIdentifier];
//    [self presentViewController:homeViewController animated:YES completion:nil];
  }
//  [self validateForm];
  [self.tableView endEditing:YES];
}

- (void)processEntries {
  NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:self.formValues];
  [params removeObjectForKey:@"Done"];
  [kDataSource registerVolunteerWithParameters:params
                              completeionBlock:^(BOOL success, NSDictionary *result, NSError *error) {
                                if (success) {
                                  NSLog(@"Volunteer = %@",[result valueForKey:@"result"]);                                }
                                else if (error){
                                  NSLog(@"%@",error);
                                }
                                
    
  }];
}
- (BOOL)validateForm
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
  return array.count == 0;
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
