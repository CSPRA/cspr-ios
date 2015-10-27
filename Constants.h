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


#define kDataSource [[SharedModel shared] dataSource]
#define kSharedModel [SharedModel shared]

#define kAnimationFactor 0.5
#define kMinAlpha 0.0
#define kMaxAlpha 1.0

//ViewController's Storyboard Identifier
#define kPatientInforamtionVCIndentifier  @"PatientInforamtionVCIndentifier"
#define kPatientHabitsVCIdentifier  @"PatientHabitsVCIdentifier"
#define kHomeVCIdentifier @"HomeViewControllerIdentifier"
#define kPatientsListVCIdentifier  @"PatientsListVCIdentifier"
#define kRegisterVCIdentifier @"RegisterVCIdentifier"
#define kPhotoViewControllerIdentifier @"PhotoViewControllerIdentifier"
#define ktabBarViewControllerIdentifier @"tabBarViewControllerIdentifier"

//Storyboard segue Identifier
#define kshowRegisterViewSegue @"showRegisterViewSegue"
#define kShowPhoneVaricationViewSegue @"ShowPhoneVaricationViewSegue"

//UITableViewCell Identifiers
#define kEventDetailCellIdentifier @"EventDetailCellIdentifier"
#define kPatieltDetailsCellIdentifier @"PatieltDetailsCellIdentifier"

//Segue Identifier
#define kshowPatientRegisterFormIdentifier @"showPatientRegisterFormIdentifier"

//Inlist API & Model Constants

#define kModelURL [[NSBundle mainBundle] URLForResource:@"ICSModel" withExtension:@"momd"]
#define kICSAPIBaseURL [NSURL URLWithString:@"http://cspr-web-dev.elasticbeanstalk.com"]
#define kDataStoreFileName @"ICSDB.sqlite"


//NSManagedObject Entities
#define kPatientEntityName @"Patient"
#define kDoctorEntityName @"Doctor"
#define kEventEntityName @"Event"
#define kVolunteerEntityName  @"Volunteer"
#define kQuestionEntityName @"Question"


#define icsOCRTempImageKey @"icsOCRImageCaptured"

//ICS BOOL Keys
#define icsVolunteerRegisteredStatusKey  @"icsVolunteerRegisteredStatus"
#define icsVolunteerWalkthroughStatusKey @"icsVolunteerWalkthroughStatus"

//VCs
#define kVolunteerSignUpVCIdentifier        @"VolunteerSignUpVCIdentifier"
#define kPatientRegistrationVCIndentifier   @"PatientRegistrationVCIdentifier"
#define kPhotoVCIdentifier                  @"PhotoVCIdentifier"
#define kCameraVCIdentifier                 @"CamVCIdentifier"
#define kScanIDProofVCIdentifier            @"ScanIDProofVCIdentifier"

