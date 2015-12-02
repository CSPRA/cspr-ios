//
//  LoginRegisterViewController.m
//  ICS
//
//  Created by Aqsa on 23/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation LoginViewController

#pragma mark - View life cycle
- (void)viewDidLoad {
	[super viewDidLoad];
	[self.navigationController.navigationBar setHidden:NO];
	[self addObservers];
	self.scrollView.scrollEnabled = NO;
	[self.usernameField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
- (IBAction)forgotPwdClicked:(id)sender {
	NSString * alertMessage = @"Please contact IT admin with your email address.";
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:alertMessage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
	[alert show];
}

#pragma mark Observer and keyborad notification handling
- (void)addObservers {
	self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self.scrollView action:@selector(endViewEditing:)];
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
	self.scrollView.scrollEnabled = NO;
	[self.scrollView setContentOffset:CGPointZero animated:YES];
	
}

- (void)keyboardWillShow: (NSNotification*)notification{
	self.scrollView.scrollEnabled = YES;
	NSDictionary *userInfo = [notification userInfo];
	CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

	CGSize size = self.scrollView.contentSize;
	size.height = 100+kbSize.height;
	size.width = self.view.bounds.size.width;
	self.scrollView.contentSize = size;
}

- (void)endViewEditing: (UITapGestureRecognizer*)sender {
	[self.scrollView endEditing:YES];
}


#pragma mark - IBActions
- (IBAction)signInButton:(UIButton *)sender {
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
	[kDataSource loginVolunteerWithEmail:self.usernameField.text password:self.passwordField.text completionBlock:^(BOOL success, NSDictionary *result, NSError *error) {
		[MBProgressHUD hideHUDForView:self.view animated:YES];
		if (success) {
			UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
			[self presentViewController:[mainStoryboard instantiateInitialViewController]
							   animated:YES
							 completion:nil] ;
		}
		else if (error){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
															message:@"Invalid credentials"
														   delegate:self
												  cancelButtonTitle:@"OK"
												  otherButtonTitles:nil, nil];
			[alert show];
		}
	}];
}


- (IBAction)forgotPassword:(UIButton *)sender {
}

#pragma mark - UITextFieldDelegate Methods

//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//  [self.scrollView setContentOffset:CGPointMake(0,textField.frame.origin.y)
//                           animated:YES];
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	if ([textField isEqual:_usernameField]) {
		[_passwordField becomeFirstResponder];
	}
	else{
		[_passwordField resignFirstResponder];
		//    [self signInButton:Nil];
	}
	return YES;
}



#pragma mark - UIAlertViewDelegate


@end
