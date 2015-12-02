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
#import "UIView+ICSAdditions.h"
#import <XLForm/XLFormTextFieldCell.h>
#import "DiagnosisFormViewController.h"
#import "DoctorsListViewController.h"
#import "ICSUtilities.h"

static NSString *const kFullNameTag       = @"Full Name";
static NSString *const kDOBTag            = @"Date of birth";
static NSString *const kGenderTag         = @"Gender";
static NSString *const kAddressTag        = @"Address";
static NSString *const kMaritalStatusTag  = @"MatiralStatus";
static NSString *const kEmailTag          = @"Email";
static NSString *const kPhoneNumberTag    = @"Phone Number";
static NSString *const kAnnualIncomeTag   = @"Annunal Income";
static NSString *const kReligionTag       = @"Religion";
static NSString *const kOccuptionTag      = @"Occupation";
static NSString *const kEducationTag      = @"Educatiom";
static NSString *const kAliveChildTag     = @"Alive Child Count";
static NSString *const kDeceasedChildTag  = @"Deceased Children Count";
static NSString *const kVoterIdTag        = @"Voter ID";
static NSString *const kAdharIdTag        = @"Adhar ID";
static NSString *const kCreatedAtTag      = @"Created At";
static NSString *const kUpdatedAtTag      = @"Updated At";
static NSString *const kPatientIdTag      = @"Patient ID";
static NSString *const kAddPhone          = @"Add Phone Number";
static NSString *const kAddEmail          = @"Add Email";

@interface PatientInformationViewController ()
@property (nonatomic, strong) NSArray *doctorList;
@property (nonatomic, strong) NSDictionary *personalInfoDict;
@property (nonatomic, strong) XLFormDescriptor *PatientInfoForm;
@property (nonatomic, strong) XLFormSectionDescriptor *section;
@end

@implementation PatientInformationViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self setupNavigationBar];
	if (ICSUtilities.hasActiveConnection) {
		[self showQuickRegisterationAlert];
	}
	[self initialSetup];
}

- (void)showQuickRegisterationAlert {
	NSString * alertMessage = @"Quick Register using OCR detection.";
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@""
													 message:alertMessage
													delegate:self
										   cancelButtonTitle:@"Cancel"
										   otherButtonTitles: @"Continue", nil];
	alert.tag = 0;
	[alert show];
}

#pragma mark - Intitialization
- (void)initialSetup {
	_PatientInfoForm = [[XLFormDescriptor alloc] init];
	_section = [[XLFormSectionDescriptor alloc] init];
	self.tableView.backgroundColor = [UIColor clearColor];
	[self.view ICSViewBackgroungColor];

	switch (_formType) {
		case kRegisteredPatientFormType:{
			self.navigationItem.title = @"Patient Information";

			XLFormRowDescriptor *row;
			row = [self addRowWithTag:kPatientIdTag rowType:XLFormRowDescriptorTypeText title:kPatientIdTag];
			row.value = [[self patientOffile] valueForKey:@"id"];
			row = [self layoutTextFieldCell:row];
			[_section addFormRow:row];
			row = [self addRowWithTag:kCreatedAtTag rowType:XLFormRowDescriptorTypeText title:kCreatedAtTag];
			row = [self layoutTextFieldCell:row];
			row.value = [[self patientOffile] valueForKey:kCreatedAt];
			[_section addFormRow:row];
			row = [self addRowWithTag:kUpdatedAtTag rowType:XLFormRowDescriptorTypeText title:kUpdatedAtTag];
			row = [self layoutTextFieldCell:row];
			row.value = [[self patientOffile] valueForKey:kUpdatedAt];
			[_section addFormRow:row];
			[self setupForm];
		}break;
		case kPatientRegistratinFormType:
			self.navigationItem.title = @"Patient Registration";
			[self setupForm];
			break;
		default:
			break;
	}
}


- (void)setupNavigationBar {
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next"
																			  style:UIBarButtonItemStylePlain
																			 target:self
																			 action:@selector(nextTapped:)];
}
- (void)nextTapped:(UIBarButtonItem*)sender {
	[self performSegueWithIdentifier:kshowTabControllerSegue sender:self];
}


- (void)fetchPatientPersonalInfo {
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
	[kDataSource fetchPatientPersonalInfoWith:_token patienttId:_pId completionBlock:^(BOOL success, NSDictionary *result, NSError *error) {
		self.personalInfoDict = result;
		[self setupForm];
	}];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

	UITabBarController * vc = [segue destinationViewController];
	[vc.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if ([obj isKindOfClass:[DiagnosisFormViewController class]]) {
			DiagnosisFormViewController *vc = obj;
			vc.icsForm = _event.form;
		}
		else if ([obj isKindOfClass:[DoctorsListViewController class]]) {
			DoctorsListViewController *vc = obj;
			vc.token = _token;
		}
	}];
}

#warning dummy data: remove when api integrated.
- (NSDictionary*)patientOffile {
	NSDictionary *dict =
	@{
	  @"name":@"Patient 1",
	  @"dob":@"1985-10-01",
	  @"gender":@"male",
	  @"maritalStatus":@"married",
	  @"address":@"Lorem ipsum",
	  @"homePhoneNumber":@(12334335),
	  @"mobileNumber":@(12345678),
	  @"email":@"abc@gmail.com",
	  @"annualIncome":@(300000),
	  @"occupation":@"bussiness",
	  @"education":@"Secondary School",
	  @"religion":@"Hindu",
	  @"aliveChildrenCount":@(0),
	  @"deceasedChildrenCount":@(0),
	  @"voterId":@"1234A59",
	  @"adharId":@"12343545",
	  @"updated_at":@"2015-10-13 12:19:11",
	  @"created_at":@"2015-10-13 12:19:11",
	  @"id":@(1)
	  };
	return dict;
}


#pragma mark - row configuration
- (void)didTappedButtonRow:(XLFormRowDescriptor*)sender {
	if (sender.tag == kAddEmail) {
		[self addRowWithTag:kEmailTag
					rowType:XLFormRowDescriptorTypeEmail
					  title:kEmailTag
					section:sender.sectionDescriptor
				  beforeRow:sender];
	}
	if (sender.tag == kAddPhone) {
		[self addRowWithTag:kPhoneNumberTag
					rowType:XLFormRowDescriptorTypePhone
					  title:kPhoneNumberTag
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
	return row;
}
- (XLFormRowDescriptor*)layoutTextFieldCell: (XLFormRowDescriptor*)row {
	[row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"textField.backgroundColor"];
	[row.cellConfig setObject:[UIFont fontWithName:@"Helvetica" size:14.0] forKey:@"textField.font"];
	[row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
	return row;
}

- (void)addRowWithTag:(NSString *)tag rowType:(NSString *)rowType title:(NSString *)title
			  section:(XLFormSectionDescriptor*)section beforeRow:(XLFormRowDescriptor*)beforeRow{
	XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:tag
																	 rowType:rowType
																	   title:title];
	row = [self customizationOFRow:row];
	if ([rowType isEqualToString:XLFormRowDescriptorTypeButton]) {
		row.action.formSelector = @selector(didTappedButtonRow:);
	}

	[section addFormRow:row beforeRow:beforeRow];
}

- (XLFormRowDescriptor*)addRowWithTag:(NSString *)tag
							  rowType:(NSString *)rowType
								title:(NSString *)title {
	XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:tag
																	 rowType:rowType
																	   title:title];

	row = [self customizationOFRow:row];
	if ([rowType isEqualToString:XLFormRowDescriptorTypeButton]) {
		row.action.formSelector = @selector(didTappedButtonRow:);
	}
	if (![tag isEqual:@"dob"]) {
		row.value = [[self patientOffile] valueForKey:tag];
	}
	return row;
}

#pragma mark - form intialization
- (void)setupForm {

	XLFormRowDescriptor *row;
	[_PatientInfoForm addFormSection:_section];

	//first name field
	row = [self addRowWithTag:kName
					  rowType:XLFormRowDescriptorTypeName
						title:kFullNameTag];
	row = [self layoutTextFieldCell:row];
	[_section addFormRow:row];

	//gender field
	row = [self addRowWithTag:kGender
					  rowType:XLFormRowDescriptorTypeText
						title:kGenderTag];
	row = [self layoutTextFieldCell:row];
	[_section addFormRow:row];

	//date of birth field
	row = [self addRowWithTag:kDOB
					  rowType:XLFormRowDescriptorTypeDateInline
						title:kDOBTag];
	[_section addFormRow:row];

	//phone number fields
	row = [self addRowWithTag:kPhoneNumber
					  rowType:XLFormRowDescriptorTypePhone
						title:kPhoneNumberTag];
	row = [self layoutTextFieldCell:row];
	[_section addFormRow:row];

	row = [self addRowWithTag:kAddPhone
					  rowType:XLFormRowDescriptorTypeButton
						title:kAddPhone];
	[_section addFormRow:row];

	//Email fields

	row =  [self addRowWithTag:kEmail
					   rowType:XLFormRowDescriptorTypeEmail
						 title:kEmailTag];
	row = [self layoutTextFieldCell:row];
	[_section addFormRow:row];

	row = [self addRowWithTag:kAddEmail
					  rowType:XLFormRowDescriptorTypeButton
						title:kAddEmail];
	[_section addFormRow:row];



	//address field
	row = [self addRowWithTag:kAddress
					  rowType:XLFormRowDescriptorTypeTextView
						title:kAddressTag];
	[_section addFormRow:row];

	row =  [self addRowWithTag:kMaritalStatus
					   rowType:XLFormRowDescriptorTypeBooleanCheck
						 title:kMaritalStatusTag];
	[_section addFormRow:row];


	row =  [self addRowWithTag:kAliveChildrenCount
					   rowType:XLFormRowDescriptorTypeNumber
						 title:kAliveChildTag];
	row = [self layoutTextFieldCell:row];
	[_section addFormRow:row];

	row =  [self addRowWithTag:kDeceasedChildrenCount
					   rowType:XLFormRowDescriptorTypeNumber
						 title:kDeceasedChildTag];
	row = [self layoutTextFieldCell:row];
	[_section addFormRow:row];

	row =  [self addRowWithTag:kOccupation
					   rowType:XLFormRowDescriptorTypeText
						 title:kOccuptionTag];
	row = [self layoutTextFieldCell:row];
	[_section addFormRow:row];

	row =  [self addRowWithTag:kAnnualIncome
					   rowType:XLFormRowDescriptorTypeNumber
						 title:kAnnualIncomeTag];
	row = [self layoutTextFieldCell:row];
	[_section addFormRow:row];

	row =  [self addRowWithTag:kEducation
					   rowType:XLFormRowDescriptorTypeText
						 title:kEducationTag];
	row = [self layoutTextFieldCell:row];
	[_section addFormRow:row];


	row =  [self addRowWithTag:kReligion
					   rowType:XLFormRowDescriptorTypeText
						 title:kReligionTag];
	row = [self layoutTextFieldCell:row];
	[_section addFormRow:row];

	row = [self addRowWithTag:kVoterId
					  rowType:XLFormRowDescriptorTypeText
						title:kVoterIdTag];
	row = [self layoutTextFieldCell:row];
	[_section addFormRow:row];

	row = [self addRowWithTag:kAdharId
					  rowType:XLFormRowDescriptorTypeText
						title:kAdharIdTag];
	row = [self layoutTextFieldCell:row];
	[_section addFormRow:row];

	self.form = _PatientInfoForm;
}
- (void)showQuickRegistrationFlow {
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ICSMain" bundle:nil];
	UIViewController *vc = [storyboard instantiateInitialViewController];
	[self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - IBAction Methods
- (IBAction)submitTapped:(id)sender {
	NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:self.formValues];
	[params removeObjectsForKeys:@[kAddEmail, kAddPhone, kCreatedAtTag, kUpdatedAtTag, kPatientIdTag]];
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
	[kDataSource registerPatientWithParameters:params token:_token completionBlock:^(BOOL success, NSDictionary *result, NSError *error) {
		if (success) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Patient information saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			alert.tag = 1;
			[alert show];
		}
		else if (error ) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Patient information not saved." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
			alert.tag = 2;
		}
		[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
	}];

}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (alertView.tag) {
		case 0:
			if (buttonIndex == 1) {
				[self showQuickRegistrationFlow];
			}
			break;
		case 1:
			[self nextTapped:nil];
			break;
		case 2:
			[self.navigationController popViewControllerAnimated:YES];
			break;
   	default:
			break;
	}
}
@end
