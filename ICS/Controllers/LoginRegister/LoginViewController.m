//
//  LoginRegisterViewController.m
//  ICS
//
//  Created by Aqsa on 23/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation LoginViewController

#pragma mark - View life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
//  [self addObservers];
    // Do any additional setup after loading the view.
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
//- (void)keyboardWillHide: (NSNotification*)notification{
//  
//  [self.tableView setContentOffset:CGPointZero animated:YES];
//}
//
//- (void)keyboardWillShow: (NSNotification*)notification{
//  self.tableView.scrollEnabled = YES;
//  NSDictionary *userInfo = [notification userInfo];
//  CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//  CGSize size = self.tableView.contentSize;
//  size.height = kFactor + kbSize.height;
//  self.tableView.contentSize = size;
//}

#pragma mark - IBActions
- (IBAction)signInButton:(UIButton *)sender {
}
- (IBAction)forgotPassword:(UIButton *)sender {
}
- (IBAction)registerButtonTapped:(id)sender {
 
}



@end
