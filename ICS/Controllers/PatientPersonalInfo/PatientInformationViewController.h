//
//  PatientInformationViewController.h
//  ICS
//
//  Created by aam-fueled on 09/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "XLFormViewController.h"

typedef enum {
  kRegisteredPatientFormType,
  kPatientRegistratinFormType
}kPatientInfoFormType;

@interface PatientInformationViewController : XLFormViewController

@property (nonatomic, assign) kPatientInfoFormType formType;
@property (nonatomic, strong) NSNumber *pId;
@property (nonatomic, strong) NSString *token;
@end
