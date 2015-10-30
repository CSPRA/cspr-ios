//
//  RegisterViewController.m
//  ICS
//
//  Created by Aqsa on 23/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "RegisterVolunteerViewController.h"
#import <XLForm/XLForm.h>
#import "ICSFloatLabeledTextFieldCell.h"

static NSString *const kDoneButton = @"Done";
static NSString *const kPasswordRegx = @"^(?=.*\\d)(?=.*[A-Za-z]).{6,32}$";
#define kFactor 50

@interface RegisterVolunteerViewController()
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@end

@implementation RegisterVolunteerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initializeForm];

  [self addObservers];
  [self setupNavigationBar];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
  }
  return self;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)setupNavigationBar {
  [self.navigationController setNavigationBarHidden:NO animated:NO];
  [self.navigationController setTitle:@"Volunteer Registration"];
  UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:self action:nil];
  [self.navigationController.navigationItem setBackBarButtonItem:backItem];
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
  size.height = kFactor + kbSize.height;
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
  //Phone Name field
  row = [XLFormRowDescriptor formRowDescriptorWithTag:kPhoneNumber rowType:XLFormRowDescriptorTypePhone];
//  row.disabled = @(YES);
  row.value = self.phoneNumber;
  [section addFormRow:row];
  
  //First Name field
  row = [XLFormRowDescriptor formRowDescriptorWithTag:kFirstName rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"First Name"];
  [section addFormRow:row];
  
  row = [XLFormRowDescriptor formRowDescriptorWithTag:kLastName rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Last Name"];
  [section addFormRow:row];
  
  row = [XLFormRowDescriptor formRowDescriptorWithTag:kUsername rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Username"];
  row.required = YES;
  [section addFormRow:row];
  
  // Email
  row = [XLFormRowDescriptor formRowDescriptorWithTag:kEmail rowType:XLFormRowDescriptorTypeEmail];
  [row.cellConfigAtConfigure setObject:@"Email" forKey:@"textField.placeholder"];
  [row.cellConfigAtConfigure setObject:@(NSTextAlignmentLeft) forKey:@"textField.textAlignment"];
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
  }
  [self.tableView endEditing:YES];
}

- (void)processEntries {
  NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:self.formValues];
  [params removeObjectForKey:@"Done"];
  NSLog(@"parameters = %@",params);
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  [kDataSource registerVolunteerWithParameters:params
                              completeionBlock:^(BOOL success, NSDictionary *result, NSError *error) {
                                if (success) {
                                  NSLog(@"Volunteer = %@",[result valueForKey:@"result"]);
                                  UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                  UINavigationController *navController = [mainStoryboard instantiateInitialViewController];
                                  [self presentViewController:navController animated:YES completion:nil];

                                  
                                }
                                else if (error){
                                  NSLog(@"%@",error);
                                }
                                [MBProgressHUD hideHUDForView:self.view animated:YES];
    
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
