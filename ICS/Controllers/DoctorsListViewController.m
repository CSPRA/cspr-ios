//
//  DoctorsListViewController.m
//  ICS
//
//  Created by Aqsa on 01/11/15.
//  Copyright © 2015 Meraki. All rights reserved.
//


#import "DoctorsListViewController.h"
#import <XLForm/XLForm.h>
#import "DoctorInformationCell.h"
#import "DoctorDummyObject.h"
#import "CustomFormButtonCell.h"

static NSString *const kDoctorBasicInfo = @"Doctor Basic Info";
static NSString *const kAssignDoctor = @"Click to show doctors";
static NSString * const kCustomRowFirstRatingTag = @"CustomRowFirstRatingTag";
static NSString * const kCustomRowSecondRatingTag = @"CustomRowSecondRatingTag";
static NSString * const khidesection = @"tag1";

@interface DoctorsListViewController()<DoctorInformationCellDelegate>
@property (nonatomic, strong) NSArray *doctorList;
@end

@implementation DoctorsListViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	[self setupForm];
	return self;
}

#warning dummy data: remove when api integrated.
- (void)initializeDummyData {
	DoctorDummyObject *doc1 = [[DoctorDummyObject alloc] init];
	doc1.doctorId = @"doc1";
	doc1.firstName= @"Arun";
	doc1.lastName = @"Jain";
	doc1.location = @"Bangalore";
	doc1.specialization = @"Cancer Specialist";
	doc1.doctorRatingValue = @(3);

	DoctorDummyObject *doc2 = [[DoctorDummyObject alloc] init];
	doc2.doctorId = @"doc2";
	doc2.firstName= @"Biswas";
	doc2.lastName = @"Rao";
	doc2.location = @"Delhi";
	doc2.specialization = @"Cancer Specialist";
	doc2.doctorRatingValue = @(3);


	DoctorDummyObject *doc3 = [[DoctorDummyObject alloc] init];
	doc3.doctorId = @"doc3";
	doc3.firstName= @"Arun";
	doc3.lastName = @"Jain";
	doc3.location = @"Bangalore";
	doc3.specialization = @"Cancer Specialist";
	doc3.doctorRatingValue = @(3);


	DoctorDummyObject *doc4 = [[DoctorDummyObject alloc] init];
	doc4.doctorId = @"doc4";
	doc4.firstName= @"Sunil";
	doc4.lastName = @"Jain";
	doc4.location = @"Bangalore";
	doc4.specialization = @"Cancer Specialist";
	doc1.doctorRatingValue = @(3);

	NSMutableArray *doctorArray = [[NSMutableArray alloc] initWithObjects:doc1,doc2,doc3,doc4, nil];
	self.doctorList = doctorArray;
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

#pragma mark - form intialization
- (void)setupForm {
	XLFormDescriptor *form = [XLFormDescriptor formDescriptorWithTitle:@"Doctor List"];
	XLFormSectionDescriptor *section = [XLFormSectionDescriptor formSectionWithTitle:@""];

	[form addFormSection:section];

 XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:kAssignDoctor rowType:XLFormRowDescriptorTypeCustomButton title:kAssignDoctor];
	row.value = kButtonTypeAssignDoctor;
	row.action.formSelector = @selector(didTappedAssignDoctor:);
	[section addFormRow:row];

	self.form = form;
}

#pragma mark - Handling assign doctors section

- (void)addDoctorInfoCell:(Doctor*)doctor section:(XLFormSectionDescriptor*)section {
	XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFirstRatingTag rowType:XLFormRowDescriptorTypeRate title:@"Rating"];
	NSDictionary *value =[NSDictionary dictionaryWithObjects:@[doctor,self] forKeys:@[@"doctorInfo",@"delegateInfo"]];
	row.value = value;
	[section addFormRow:row];
}

- (void)addAssignDoctorSectionWithDoctorList:(NSArray*)doctorsArray {

	XLFormSectionDescriptor *section = [XLFormSectionDescriptor formSectionWithTitle:@"Assign Doctor From List"];
	section.hidden = [NSString stringWithFormat:@"$%@==0", khidesection];
	[self.form addFormSection:section];
	[doctorsArray enumerateObjectsUsingBlock:^(Doctor *doctor, NSUInteger idx, BOOL * _Nonnull stop) {
		[self addDoctorInfoCell:doctor section:section];
	}];
}

- (void)didTappedAssignDoctor:(XLFormRowDescriptor*)sender {
	if (!self.doctorList) {
		[self initializeDummyData];
		[self addAssignDoctorSectionWithDoctorList:self.doctorList];
	}
	else{
		return;
	}
}

#pragma DoctorInformationCellDelegate
- (void)didAssignedDoctor:(DoctorInformationCell *)cell {
	NSLog(@"doctor assigned %@",cell.nameLabel.text);
}

@end
