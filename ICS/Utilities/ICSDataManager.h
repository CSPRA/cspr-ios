//
//  ICSDataManager.h
//  ICS
//
//  Created by Harshita
//  Copyright © 2015 Meraki. All rights reserved.
//

@import Foundation;
#include "ICSUtilities.h"

@interface ICSDataManager : NSObject

+ (id) sharedManager;

+(BOOL)hasWalkthroughBeenShown;
+(void)disableAutomaticWalkthroughPreview;

+(BOOL)isVolunteerRegistered;
+(void)setVolunteerAsRegistered;


//Volunteer Onboarding

-(void)checkVolunteerAccessForPhoneNumber:(NSString*)phoneNumber withCompletion:(void (^)(id response, BOOL success))completion;

-(void)loginVolunteerWithDetails:(NSDictionary*)vDetails withCompletion:(void (^)(id response, BOOL success))completion;


//Patient Registration Flow

-(void)endDiagnosisForPatientID:(NSString*)patientID withData:(NSDictionary*)patientDetails withCompletion:(void (^)(id response, BOOL success))completion;


@end
