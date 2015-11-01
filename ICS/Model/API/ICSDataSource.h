//
//  ICSDataSource.h
//  ICS
//
//  Created by aqsa-fueled on 17/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICSAPIError.h"
#import "APIInterface.h"
#import "Patient.h"
#import "Event.h"
#import "Question.h"
#import "Doctor.h"
#import "Volunteer.h"

typedef void (^ICSApiInterfaceBlock)(BOOL success,
                                        NSDictionary *result,
                                        NSError *error);

@interface ICSDataSource : NSObject

/** Signin using username and password.
 @param email Volunteer's registered username
 @param password Volunteer's account password
 @param block Completion block to be executed once call is completed
 */
- (void)signinUserWithUsername: (NSString*)username
                   password: (NSString*)password
        withCompletionBlock: (ICSApiInterfaceBlock)block;

/** Fetches latest events from the server
 @param block Completion block to be executed once call is completed
 */

- (void)fetchEventsWithToken: (NSString*)token
             completionBlock: (ICSApiInterfaceBlock)block;

/** Fetches registered patient list from the server
 @param block Completion block to be executed once call is completed
 */
- (void)fetchPatientsWithToken: (NSString *)token
                       eventId: (NSNumber *)patientId
               completionBlock: (ICSApiInterfaceBlock)block;


/** Fetches registered patient's personal info from the server
 @param token Token of current user
 @param patientId registered patient's id
 @param block Completion block to be executed once call is completed
 */
- (void)fetchPatientPersonalInfoWith: (NSString *)token
                       patienttId: (NSNumber *)eventId
               completionBlock: (ICSApiInterfaceBlock)block;

/** Register a patient with volunteer token number
 @param block Completion block to be executed once call is completed
 */
- (void)registerPatientWithParameters:(NSDictionary*)paramenters
                                token:(NSString*)token
                 completionBlock:(ICSApiInterfaceBlock)block;

/** Register a Volunteer 
 @param parameneters dictionary of Volunteer details
 @param block Completion block to be executed once call is completed
 */
- (void)registerVolunteerWithParameters: (NSDictionary*)parameters
                       completeionBlock:(ICSApiInterfaceBlock)block;

/** Login Volunteer
 @param email Registered email of volunteer
 @param password valid password of volunteer
 @param block Completion block to be executed once call is completed
 */
- (void)loginVolunteerWithEmail:(NSString*)email password:(NSString*)password completionBlock:(ICSApiInterfaceBlock)block;

- (void)fetchDiagnosisQuestions: (NSNumber*)formId
                          token: (NSString*)token
                completionBlock: (ICSApiInterfaceBlock)block;
@end
