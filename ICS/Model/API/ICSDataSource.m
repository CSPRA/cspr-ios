//
//  ICSDataSource.m
//  ICS
//
//  Created by aqsa-fueled on 17/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "ICSDataSource.h"
#import "SharedModel.h"
#import "AppDelegate.h"
#import "KeychainWrapper.h"

#define kPasswordKey @"passwordkey"

@interface ICSDataSource()

@end

@implementation ICSDataSource

- (void)signinUserWithUsername:(NSString *)username password:(NSString *)password withCompletionBlock:(ICSApiInterfaceBlock)block {
  
}

- (void)fetchEventsWithToken:(NSString*)token
             completionBlock:(ICSApiInterfaceBlock)block {
  NSDictionary *parameters = @{
                               @"token":token
                               };
  
  [[RKObjectManager sharedManager] getObjectsAtPath:kFetchEventsPath
                                         parameters:parameters
                                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                              
                                              block(YES, [mappingResult dictionary], nil);
                                            } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                              block(NO, nil, error);
                                            }];
  
}

- (void)fetchPatientsWithToken:(NSString *)token
                       eventId:(NSNumber *)eventId
               completionBlock:(ICSApiInterfaceBlock)block {
  
  NSString *path = [NSString stringWithFormat:@"%@,%@",kFetchPatientsListPath,eventId];
  NSDictionary *param = @{
                          kToken: token
                          };
  [[RKObjectManager sharedManager] getObjectsAtPath:path
                                         parameters:param
                                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                              block(YES, [mappingResult dictionary], nil);
                                            } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                              block(NO, nil, error);
                                            }];
}


- (void)fetchPatientPersonalInfoWith:(NSString *)token
                          patienttId:(NSNumber *)patientId
                     completionBlock:(ICSApiInterfaceBlock)block {
  NSString *path = [NSString stringWithFormat:@"%@,%@",kFetchPatientsListPath,patientId];

  NSDictionary *param = @{
                          kToken: token
                          };
  [[RKObjectManager sharedManager] getObjectsAtPath:path parameters:param success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
    block(YES, [mappingResult dictionary], nil);

  } failure:^(RKObjectRequestOperation *operation, NSError *error) {
    block(NO, nil, error);

  }];
}

- (void)fetchDiagnosisQuestions:(NSNumber *)formId
                          token:(NSString *)token
                completionBlock:(ICSApiInterfaceBlock)block {
  
  NSString *path = [NSString stringWithFormat:@"%@/%@",kFetchQuestionsPath,formId];
  [self setupMappingWithPath:path];
  [[RKObjectManager sharedManager] getObjectsAtPath:path parameters:@{@"token": token}
                                            success:^(RKObjectRequestOperation *operation,
                                                      RKMappingResult *mappingResult) {
    block(YES, [mappingResult dictionary], nil);

  } failure:^(RKObjectRequestOperation *operation, NSError *error) {
    block(NO, nil, error);

  }];
}

- (void)registerPatientWithParameters:(NSDictionary *)paramenters
                                token:(NSString*)token
                      completionBlock:(ICSApiInterfaceBlock)block {
   NSString *path = [NSString stringWithFormat:@"%@?token=%@",kPatientRegisterPath,token];
//   RKManagedObjectRequestOperation *operation = [[RKObjectManager sharedManager] appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodPOST path:path parameters:paramenters];
//  [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//    block(YES, [mappingResult dictionary], nil);
//
//  } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//    block(NO, nil, error);
//
//  }];
//  [RKObjectManager.sharedManager enqueueObjectRequestOperation:operation];

  
  [[RKObjectManager sharedManager] postObject:nil
                                         path:path
                                   parameters:paramenters
                                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                        block(YES, [mappingResult dictionary], nil);
                                      } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                        block(NO, nil, error);
                                      }];
}

- (void)registerVolunteerWithParameters:(NSDictionary *)parameters
                       completeionBlock:(ICSApiInterfaceBlock)block {
  [[RKObjectManager sharedManager] postObject:nil path:kVolunteerRegisterPath
                                   parameters:parameters success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
    Volunteer *volunteer = [[mappingResult dictionary] valueForKey:@"result"];
    volunteer.firstName = parameters[kFirstName];
    volunteer.lastName = parameters[kLastName];
    volunteer.username = parameters[kUsername];
    volunteer.contactNumber = parameters[kPhoneNumber];
    volunteer.email = parameters[kEmail];
    block(YES, [mappingResult dictionary], nil);
  } failure:^(RKObjectRequestOperation *operation, NSError *error) {
    block(NO, nil, error);
  }];
}

- (void)loginVolunteerWithEmail:(NSString *)email
                       password:(NSString *)password
                completionBlock:(ICSApiInterfaceBlock)block {
  NSDictionary *params = @{
                           kEmail: email,
                           kPassword: password
                           };
  [[RKObjectManager sharedManager] postObject:nil
                                         path:kVolunteerLoginPath
                                   parameters:params
                                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                        [self saveIntoKeychain:email password:password];
                                        block(YES, [mappingResult dictionary], nil);
                                      } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                        block(NO, nil, error);
                                      }];
}



- (void)saveIntoKeychain: (NSString*)username password: (NSString*)password {
  BOOL loginKey = [[NSUserDefaults standardUserDefaults] boolForKey:kSession];
  if (!loginKey) {
    [[NSUserDefaults standardUserDefaults] setValue:username forKey:kUsername];
  }
  
  KeychainWrapper *keychainWrapper = [[KeychainWrapper alloc] init];
  [keychainWrapper mySetObject:password forKey:(id)kSecAttrService];
  [keychainWrapper writeToKeychain];
  [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kSession];
  [[NSUserDefaults standardUserDefaults] synchronize];
  
}

- (void)logoutVolunteer {
  [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kSession];
}

- (void)setupMappingWithPath:(NSString*)path {
  [[APIInterface sharedInterface] setupMappingWithPath:path];
}

@end
