//
//  VolunteerSignUpViewController.m
//  ICS
//
//  Created by Harshita
//  Copyright (c) 2015 Paytm. All rights reserved.
//

#define verticalPadding     25
#define nav_bar_height      50
#define horizontalPadding   15

#import "AppDelegate.h"
#import "ClumsyAlertView.h"
#import "IQUIView+Hierarchy.h"
#import "ICSTabsViewController.h"
#import "ICSTabsViewController.h"
#import "ActionSheetStringPicker.h"
#import "VolunteerSignUpViewController.h"

@interface VolunteerSignUpViewController ()<UITextFieldDelegate> {
    CGFloat keyboardHeight;
    BOOL    isUserInvalid;
    BOOL    isChangingUnverifiedMobile;
}

@property (nonatomic, strong) UITextField *firstNameTextField;
@property (nonatomic, strong) UITextField *lastNameTextField;
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *dobTextField;
@property (nonatomic, strong) UITextField *genderTextField;
@property (nonatomic, strong) UITextField *mobileTextField;

@property (nonatomic,strong) UIButton *saveButton;
@end

@implementation VolunteerSignUpViewController

@synthesize editProfileView;
@synthesize sepView1;
@synthesize sepView2;
@synthesize firstNameTextField;
@synthesize lastNameTextField;
@synthesize emailTextField;
@synthesize dobTextField;
@synthesize genderTextField;
@synthesize mobileTextField;
@synthesize enterOtpTextField;
@synthesize mobileOTPButton;
@synthesize changeMobileButton;

@synthesize oldPasswordTextField;
@synthesize changedPasswordTextField;
@synthesize confirmPasswordTextField;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];//[UIColor colorWithRed:249.0f/255.0f green:246.0f/255.0f blue:235.0f/255.0f alpha:1]];

    switch (self.changeType) {
        case ProfileChangeType_Details:
            [ICSHelper pushGTMForEvent:@"screen_loaded_profile_edit" screenName:@"Profile_edit"];
            [self createValidateUserForSignup];
            break;
        case ProfileChangeType_Password:
            [self createResetPasswordForm];
            break;
        case ProfileChangeType_Validate:
            isUserInvalid = YES;
            [self createCompleteProfileForm];
            break;
        case ProfileChangeType_Verify:
            [self sendRequestForVerifyUserPhone];
            [self createCompleteProfileForm];
            break;
        default:
            break;
    }
    
    [self addViewHeader];
    [self addProfileActionButton];
    
}

-(void)addViewHeader {
    
    NSString * headingTxt;
    switch (self.changeType) {
        case ProfileChangeType_Details:
            headingTxt = @"Edit Profile";
            break;
        case ProfileChangeType_Password:
            headingTxt = @"Change Password";
            break;
        case ProfileChangeType_Validate:
        case ProfileChangeType_Verify:
            headingTxt = @"Complete Your Profile";
            break;
    }
    //Header
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, nav_bar_height)];
    self.headerView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.9f];
    [self.view addSubview:self.headerView];
    
    UILabel* chatHeaderLbl = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, CGRectGetWidth(self.view.frame)-140, 45)];
    chatHeaderLbl.text = headingTxt;
    chatHeaderLbl.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    chatHeaderLbl.textColor = ICSBrownColor;
    chatHeaderLbl.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:chatHeaderLbl];
    

    UIButton *crossBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    crossBtn.frame = CGRectMake(15, 10, 45, 45);
    [crossBtn setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
    [crossBtn addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:crossBtn];
}

-(void)backButtonClicked {

    if((self.changeType == ProfileChangeType_Details)|(self.changeType == ProfileChangeType_Password)) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [ICSUtills logoutICS];
    }
}

-(void)addProfileActionButton {
    NSString * buttonTxt;
    switch (self.changeType) {
        case ProfileChangeType_Details:
            buttonTxt = @"Save Changes";
            break;
        case ProfileChangeType_Password:
            buttonTxt = @"Save Changes";
            break;
        case ProfileChangeType_Validate:
        case ProfileChangeType_Verify:
            buttonTxt = @"Confirm";
            break;
    }

    float fontSize = IS_IPHONE5_OR_SMALLER ? 15 : 18;
    self.actionButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.actionButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"buyBG"]];
    self.actionButton.frame=CGRectMake(0, CGRectGetHeight(self.view.frame)-70, CGRectGetWidth(self.view.frame), 70);
    [self.actionButton setTitle:buttonTxt forState:UIControlStateNormal];
    [self.actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [self.actionButton.titleLabel setFont: [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize]];
    [self.actionButton addTarget:self action:@selector(updateBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.actionButton];
}



-(void)createValidateUserForSignup {
    
    [editProfileView removeFromSuperview];
    editProfileView = nil;
    
    editProfileView = [[UIScrollView alloc] initWithFrame:CGRectMake(horizontalPadding, nav_bar_height + verticalPadding, CGRectGetWidth(self.view.frame) - 15, CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.actionButton.frame) - nav_bar_height - verticalPadding)];
    
    [editProfileView setBounces:NO];
    editProfileView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:editProfileView];
    
    float yRef = 15;
    
    float widthRef = CGRectGetWidth(self.editProfileView.frame) - 70;
    
    firstNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(35, yRef, widthRef, 45)];
    firstNameTextField.delegate = self;
    firstNameTextField.floatingLabelFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
    firstNameTextField.floatingLabelTextColor = ICSBrownColor;
    firstNameTextField.floatingLabelActiveTextColor = ICSBrownColor;
    firstNameTextField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    firstNameTextField.textColor = ICSBrownColor;
    firstNameTextField.attributedPlaceholder = [ICSUtills setLineCharSpacingForCapitalLetters:@"First Name" withFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16] withColor:ICSBrownColor lineSpace:5 andCharSpace:@1];
    [editProfileView addSubview:firstNameTextField];
    
    yRef += 45 + 30;
    
    UIView *sep1 = [[UIView alloc] initWithFrame:CGRectMake(0, yRef-15.5, CGRectGetWidth(self.editProfileView.frame), 0.5)];
    sep1.backgroundColor = [UIColor colorWithRed:191.0f/255.0f green:185.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    [editProfileView addSubview: sep1];
    
    lastNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(35, yRef, widthRef, 45)];
    lastNameTextField.delegate = self;
    lastNameTextField.floatingLabelFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
    lastNameTextField.floatingLabelTextColor = ICSBrownColor;
    lastNameTextField.floatingLabelActiveTextColor = ICSBrownColor;
    lastNameTextField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    lastNameTextField.textColor = ICSBrownColor;
    //    lastNameTextField.keyboardType = UIKeyboardTypeNumberPad;
    lastNameTextField.attributedPlaceholder = [ICSUtills setLineCharSpacingForCapitalLetters:@"Last Name" withFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16] withColor:ICSBrownColor lineSpace:5 andCharSpace:@1];
    [editProfileView addSubview:lastNameTextField];
    
    yRef += 45 + 30;
    
    UIView *sepp = [[UIView alloc] initWithFrame:CGRectMake(0, yRef-15.5, CGRectGetWidth(self.editProfileView.frame), 0.5)];
    sepp.backgroundColor = [UIColor colorWithRed:191.0f/255.0f green:185.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    [editProfileView addSubview: sepp];
    
    genderTextField = [[UITextField alloc] initWithFrame:CGRectMake(35, yRef, widthRef, 45)];
    genderTextField.placeholder = @"Gender";
    genderTextField.delegate = self;
    genderTextField.floatingLabelFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
    genderTextField.floatingLabelTextColor = ICSBrownColor;
    genderTextField.floatingLabelActiveTextColor = ICSBrownColor;
    genderTextField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    genderTextField.textColor = ICSBrownColor;
    genderTextField.attributedPlaceholder = [ICSUtills setLineCharSpacingForCapitalLetters:@"Gender" withFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16] withColor:ICSBrownColor lineSpace:5 andCharSpace:@1];
    
    [editProfileView addSubview:genderTextField];
    yRef += 45 + 30;

    
    UIView *sep4 = [[UIView alloc] initWithFrame:CGRectMake(0, yRef-15.5, CGRectGetWidth(self.editProfileView.frame), 0.5)];
    sep4.backgroundColor = [UIColor colorWithRed:191.0f/255.0f green:185.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    [editProfileView addSubview: sep4];
    
    dobTextField = [[UITextField alloc] initWithFrame:CGRectMake(35, yRef, widthRef, 45)];
    dobTextField.delegate = self;
    dobTextField.placeholder = @"Date of Birth (dd/mm/yyyy)";
    dobTextField.floatingLabelFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
    dobTextField.floatingLabelTextColor = ICSBrownColor;
    dobTextField.floatingLabelActiveTextColor = ICSBrownColor;
    dobTextField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    dobTextField.textColor = ICSBrownColor;
    dobTextField.attributedPlaceholder = [ICSUtills setLineCharSpacingForCapitalLetters:@"Date of Birth (dd/mm/yyyy)" withFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16] withColor:ICSBrownColor lineSpace:5 andCharSpace:@1];
    [editProfileView addSubview:dobTextField];
    
    yRef += 45 + 30;
    
    UIView *sep5 = [[UIView alloc] initWithFrame:CGRectMake(0, yRef-15.5, CGRectGetWidth(self.editProfileView.frame), 0.5)];
    sep5.backgroundColor = [UIColor colorWithRed:191.0f/255.0f green:185.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    [editProfileView addSubview: sep5];
    
    yRef += 71;
    
    [self.editProfileView setContentSize:CGSizeMake(CGRectGetWidth(self.view.frame) - horizontalPadding, yRef)];
    self.editProfileView.alpha = 0;
    
    [self populateUserDetailForm];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.editProfileView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}


-(void)createCompleteProfileForm{
    
    [editProfileView removeFromSuperview];
    editProfileView = nil;

    float heightRef  = IS_IPHONE5_OR_SMALLER ? 40 : 52;
    float paddingRef = IS_IPHONE5_OR_SMALLER ? 12 : 18;

    editProfileView = [[UIScrollView alloc] initWithFrame:CGRectMake(horizontalPadding, nav_bar_height + verticalPadding, CGRectGetWidth(self.view.frame) - 15, CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.actionButton.frame) - nav_bar_height - verticalPadding)];
    
    [editProfileView setBounces:NO];
    editProfileView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:editProfileView];
    
    float yRef = 15;
    
    float widthRef = CGRectGetWidth(self.editProfileView.frame) - 70;
    
    firstNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(35, yRef, widthRef, 45)];
    firstNameTextField.delegate = self;
    firstNameTextField.floatingLabelFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
    firstNameTextField.floatingLabelTextColor = ICSBrownColor;
    firstNameTextField.floatingLabelActiveTextColor = ICSBrownColor;
    firstNameTextField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    firstNameTextField.textColor = ICSBrownColor;
    firstNameTextField.attributedPlaceholder = [ICSUtills setLineCharSpacingForCapitalLetters:@"First Name" withFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16] withColor:ICSBrownColor lineSpace:5 andCharSpace:@1];
    [editProfileView addSubview:firstNameTextField];
    
    yRef += 45 + 30;
    
    UIView *sep1 = [[UIView alloc] initWithFrame:CGRectMake(0, yRef-15.5, CGRectGetWidth(self.editProfileView.frame), 0.5)];
    sep1.backgroundColor = [UIColor colorWithRed:191.0f/255.0f green:185.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    [editProfileView addSubview: sep1];
    
    lastNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(35, yRef, widthRef, 45)];
    lastNameTextField.delegate = self;
    lastNameTextField.floatingLabelFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
    lastNameTextField.floatingLabelTextColor = ICSBrownColor;
    lastNameTextField.floatingLabelActiveTextColor = ICSBrownColor;
    lastNameTextField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    lastNameTextField.textColor = ICSBrownColor;
    //    lastNameTextField.keyboardType = UIKeyboardTypeNumberPad;
    lastNameTextField.attributedPlaceholder = [ICSUtills setLineCharSpacingForCapitalLetters:@"Last Name" withFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16] withColor:ICSBrownColor lineSpace:5 andCharSpace:@1];
    [editProfileView addSubview:lastNameTextField];
    
    yRef += 45 + 30;
    
    UIView *sep2 = [[UIView alloc] initWithFrame:CGRectMake(0, yRef-15.5, CGRectGetWidth(self.editProfileView.frame), 0.5)];
    sep2.backgroundColor = [UIColor colorWithRed:191.0f/255.0f green:185.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    [editProfileView addSubview: sep2];
    
    emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(35, yRef, widthRef, 45)];
    emailTextField.delegate = self;
    emailTextField.floatingLabelFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
    emailTextField.floatingLabelTextColor = ICSBrownColor;
    emailTextField.floatingLabelActiveTextColor = ICSBrownColor;
    emailTextField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    emailTextField.textColor = ICSBrownColor;
    //    lastNameTextField.keyboardType = UIKeyboardTypeNumberPad;
    emailTextField.attributedPlaceholder = [ICSUtills setLineCharSpacingForCapitalLetters:@"Email" withFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16] withColor:ICSBrownColor lineSpace:5 andCharSpace:@1];
    [editProfileView addSubview:emailTextField];
    
    yRef += 45 + 30;
    
    UIView *sep3 = [[UIView alloc] initWithFrame:CGRectMake(0, yRef-15.5, CGRectGetWidth(self.editProfileView.frame), 0.5)];
    sep3.backgroundColor = [UIColor colorWithRed:191.0f/255.0f green:185.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    [editProfileView addSubview: sep3];
    
    NSString * mobileHeadingText = (isUserInvalid) ? @"The entered mobile number is incorrect, update this & tap on 'Confirm' to verify the new mobile number." : [NSString stringWithFormat:@"Enter One Time Password(OTP) sent to your mobile number %@ or", [ICSUtills getUserInfo][@"mobile"]];
    
    if(isChangingUnverifiedMobile) {
        mobileHeadingText = @"Change your mobile number";
    }
    
    UILabel * mobileHeadingLabel = [[UILabel alloc] initWithFrame: CGRectMake(35, yRef, widthRef, 45)];
    [mobileHeadingLabel setAttributedText:[ICSUtills setLineCharSpacingForCapitalLetters:mobileHeadingText withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10] withColor:ICSBrownColor lineSpace:1 andCharSpace:@1]];
    mobileHeadingLabel.numberOfLines = 0;
    mobileHeadingLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [editProfileView addSubview: mobileHeadingLabel];
    
    yRef += 45;
    
    mobileTextField = [[UITextField alloc] initWithFrame:CGRectMake(35, yRef, widthRef, 45)];
    mobileTextField.delegate = self;
    mobileTextField.placeholder = @"Mobile";
    mobileTextField.floatingLabelFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
    mobileTextField.floatingLabelTextColor = ICSBrownColor;
    mobileTextField.floatingLabelActiveTextColor = ICSBrownColor;
    mobileTextField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    mobileTextField.textColor = ICSBrownColor;
    mobileTextField.attributedPlaceholder = [ICSUtills setLineCharSpacingForCapitalLetters:@"Mobile" withFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16] withColor:ICSBrownColor lineSpace:5 andCharSpace:@1];
    [editProfileView addSubview:mobileTextField];

    yRef += 45 + 30;

    UIView *sepp = [[UIView alloc] initWithFrame:CGRectMake(0, yRef-15.5, CGRectGetWidth(self.editProfileView.frame), 0.5)];
    sepp.backgroundColor = [UIColor colorWithRed:191.0f/255.0f green:185.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    [editProfileView addSubview: sepp];
    
    genderTextField = [[UITextField alloc] initWithFrame:CGRectMake(35, yRef, widthRef, 45)];
    genderTextField.placeholder = @"Gender";
    genderTextField.delegate = self;
    genderTextField.floatingLabelFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
    genderTextField.floatingLabelTextColor = ICSBrownColor;
    genderTextField.floatingLabelActiveTextColor = ICSBrownColor;
    genderTextField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    genderTextField.textColor = ICSBrownColor;
    genderTextField.attributedPlaceholder = [ICSUtills setLineCharSpacingForCapitalLetters:@"Gender" withFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16] withColor:ICSBrownColor lineSpace:5 andCharSpace:@1];
    
    [editProfileView addSubview:genderTextField];
    yRef += 45 + 30;
    
    
    UIView *sep4 = [[UIView alloc] initWithFrame:CGRectMake(0, yRef-15.5, CGRectGetWidth(self.editProfileView.frame), 0.5)];
    sep4.backgroundColor = [UIColor colorWithRed:191.0f/255.0f green:185.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    [editProfileView addSubview: sep4];
    
    dobTextField = [[UITextField alloc] initWithFrame:CGRectMake(35, yRef, widthRef, 45)];
    dobTextField.delegate = self;
    dobTextField.placeholder = @"Date of Birth (dd/mm/yyyy)";
    dobTextField.floatingLabelFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
    dobTextField.floatingLabelTextColor = ICSBrownColor;
    dobTextField.floatingLabelActiveTextColor = ICSBrownColor;
    dobTextField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    dobTextField.textColor = ICSBrownColor;
    dobTextField.attributedPlaceholder = [ICSUtills setLineCharSpacingForCapitalLetters:@"Date of Birth (dd/mm/yyyy)" withFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16] withColor:ICSBrownColor lineSpace:5 andCharSpace:@1];
    [editProfileView addSubview:dobTextField];
    
    yRef += 45 + 30;
    
    UIView *sep5 = [[UIView alloc] initWithFrame:CGRectMake(0, yRef-15.5, CGRectGetWidth(self.editProfileView.frame), 0.5)];
    sep5.backgroundColor = [UIColor colorWithRed:191.0f/255.0f green:185.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    [editProfileView addSubview: sep5];
    
    yRef += 71;
    
    [self.editProfileView setContentSize:CGSizeMake(CGRectGetWidth(self.view.frame) - horizontalPadding, yRef)];
    self.editProfileView.alpha = 0;
    
    [self populateUserDetailForm];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.editProfileView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)sendRequestForVerifyUserPhone {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)populateUserDetailForm {
    NSDictionary * volunteerDetails = [ICSUtills getUserInfo];
    firstNameTextField.text  = volunteerDetails[@"firstName"];
    lastNameTextField.text   = volunteerDetails[@"lastName"];
    mobileTextField.text     = [NSString stringWithFormat:@"%@", volunteerDetails[@"mobile"]];
    emailTextField.text      = (volunteerDetails[@"email"])           ? volunteerDetails[@"email"]      : @"";
    genderTextField.text     = (volunteerDetails[@"gender"])          ? volunteerDetails[@"gender"]      : @"";
    dobTextField.text        = (volunteerDetails[@"dateOfBirth"])     ? volunteerDetails[@"dateOfBirth"] : @"";
}

-(void)updateBtnClicked {

    [self.view endEditing:YES];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string length] == 0)
        return YES;

    if ([textField isEqual:firstNameTextField]||[textField isEqual:lastNameTextField]) {
        
        NSCharacterSet *strCharSet = [NSCharacterSet letterCharacterSet];
        return ([string rangeOfCharacterFromSet:strCharSet].location != NSNotFound);
    }
    else if ([textField isEqual:enterOtpTextField]) {
        
        if (textField.text.length == 6){
            return NO;
        }
    }
    
    return YES;
}


#pragma mark

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [ICSUtills registerForKeyboardNotificationsForClass:self];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [ICSUtills deregisterFromKeyboardNotificationsForClass:self];
}

@end