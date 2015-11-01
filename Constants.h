//
//  Constants.h
//  ICS
//
//  Created by aam-fueled on 08/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#ifndef Constants_h
#define Constants_h


#endif /* Constants_h */

#define kSession @"VolunteerSession"

#define kDataSource [[SharedModel shared] dataSource]
#define kSharedModel [SharedModel shared]

#define kAnimationFactor 0.5
#define kMinAlpha 0.0
#define kMaxAlpha 1.0

//ViewController's Storyboard Identifier
#define kPatientInfoVCIndetifier        @"PatientInfoVCIndetifier"
#define kDiagnosisFormVCIdentifier      @"DiagnosisFormVCIdentifier"
#define kHomeVCIdentifier               @"HomeViewControllerIdentifier"
#define kPatientsListVCIdentifier       @"PatientsListVCIdentifier"
#define kRegisterVCIdentifier           @"RegisterVCIdentifier"
#define kPhotoViewControllerIdentifier  @"PhotoViewControllerIdentifier"

//Storyboard segue Identifier
#define kshowRegisterViewSegue        @"showRegisterViewSegue"
#define kShowPhoneVaricationViewSegue @"ShowPhoneVaricationViewSegue"
#define kshowTabControllerSegue       @"showTabControllerSegue"

//UITableViewCell Identifiers
#define kEventDetailCellIdentifier @"EventDetailCellIdentifier"
#define kPatieltDetailsCellIdentifier @"PatieltDetailsCellIdentifier"

//Segue Identifier
#define kshowPatientRegisterFormIdentifier @"showPatientRegisterFormIdentifier"

//Inlist API & Model Constants

#define kModelURL [[NSBundle mainBundle] URLForResource:@"ICSModel" withExtension:@"momd"]
#define kICSAPIBaseURL [NSURL URLWithString:@"http://cspr-web-dev.elasticbeanstalk.com"]
#define kDataStoreFileName @"ICSDB.sqlite"
#define kMainStoryBoard [UIStoryboard storyboardWithName:@"Main" bundle:nil]
#define kLoginSignUpStoryboard [UIStoryboard storyboardWithName:@"LoginSignUp" bundle:nil]

//NSManagedObject Entities
#define kPatientEntityName @"Patient"
#define kDoctorEntityName @"Doctor"
#define kEventEntityName @"Event"
#define kVolunteerEntityName  @"Volunteer"
#define kQuestionEntityName @"Question"
#define kCancerEntityName @"Cancer"
#define kFormEntityName @"Form"
#define kQuestionOptionsEntitiyName @"QuestionOptions"

#define icsOCRTempImageKey @"icsOCRImageCaptured"

//ICS BOOL Keys
#define icsVolunteerRegisteredStatusKey  @"icsVolunteerRegisteredStatus"
#define icsVolunteerWalkthroughStatusKey @"icsVolunteerWalkthroughStatus"

//VCs
#define kVolunteerSignUpVCIdentifier        @"VolunteerSignUpVCIdentifier"
#define kPhotoVCIdentifier                  @"PhotoVCIdentifier"
#define kCameraVCIdentifier                 @"CamVCIdentifier"
#define kScanIDProofVCIdentifier            @"ScanIDProofVCIdentifier"

// API Paths
#define kVolunteerRegisterPath              @"/volunteer/register"
#define kPatientRegisterPath                @"/patient"
#define kVolunteerLoginPath                 @"/volunteer/login"
#define kFetchEventsPath                    @"/volunteer/myScreeningAssignments"
#define kFetchPatientsListPath              @"/volunteer/patients/"
#define kFetchDoctorsListPath               @"/doctors"
#define kFetchDoctorPath                    @"/doctor/3"
#define kPostDoctorRatingPath               @"/doctor/rating"
#define kPostDiagnosisResponsePath          @"/diagnosisResponses"
#define kFetchQuestionsPath                 @"/queries"


//Mapping keys
#define kEmail                  @"email"
#define kPassword               @"password"
#define kUsername               @"username"
#define kPhoneNumber            @"contactNumber"
#define kAddress                @"address"
#define kGender                 @"gender"
#define kFirstName              @"firstname"
#define kLastName               @"lastname"
#define kToken                  @"token"
#define kRole                   @"role"
#define kEventName              @"eventName"
#define kEventType              @"eventType"
#define kStartingDate           @"startingDate"
#define kEndingDate             @"endingDate"
#define kDOB                    @"dob"
#define kAnnualIncome           @"annualIncome"
#define kOccupation             @"occupation"
#define kEducation              @"education"
#define kMaritalStatus          @"maritalStatus"
#define kHomePhoneNumber        @"homePhoneNumber"
#define kMobileNumber           @"mobileNumber"
#define kReligion               @"religion"
#define kAliveChildrenCount     @"aliveChildrenCount"
#define kDeceasedChildrenCount  @"deceasedChildrenCount"
#define kVoterId                @"voterId"
#define kAdharId                @"adharId"
#define kName                   @"name"
#define kCancerType             @"cancerType"
#define kCancerName             @"cancerName"
#define kCancerDescription      @"description"
#define kFormName               @"formName"
#define kFormDescription        @"formDescription"
#define kEventID                @"eventId"
#define kFormID                 @"formId"
#define kCancerID               @"cancerId"
#define kCreatedAt              @"created_at"
#define kUpdatedAt              @"updated_at"
#define kQueryId                @"quesryId"
#define kQuestionsId            @"questionId"
#define kQuestionOptions        @"options"
#define kQuestionTitle          @"title"
#define kQuestionType           @"type"
#define kOrder                  @"order"
#define kUnits                  @"units"
#define kOptionId               @"id"
#define kOptionName             @"name"
#define kOptionGroupId          @"groupId"


