//
//  Patient.m
//  
//
//  Created by aam-fueled on 16/10/15.
//
//

#import "Patient.h"

@implementation Patient

- (Patient*)fetchPatient {
  return (Patient*)[kSharedModel fetchManagedObjectWithEntityName:kPatientEntityName];
}

+ (void)setupPatientMapping:(NSString*)path {
  RKEntityMapping *patientMapping = [Patient restkitObjectMappingForStore:[RKObjectManager sharedManager].managedObjectStore];
  RKResponseDescriptor *patientDescriptor =
  [RKResponseDescriptor responseDescriptorWithMapping:patientMapping pathPattern:path
                                              keyPath:@"result"
                                          statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
  [[RKObjectManager sharedManager] addResponseDescriptor:patientDescriptor];
  
  patientDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:patientMapping
                                                               pathPattern:path keyPath:@"error"
                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
  [[RKObjectManager sharedManager] addResponseDescriptor:patientDescriptor];
}


+ (RKEntityMapping*)restkitObjectMappingForStore:(RKManagedObjectStore *)store {
  RKEntityMapping *patientMapping = [RKEntityMapping mappingForEntityForName:kPatientEntityName
                                                        inManagedObjectStore:store];
  [patientMapping setIdentificationAttributes:@[@"patientId"]];
  [patientMapping addAttributeMappingsFromDictionary:@{
                                                     kPatientId: @"patientId",
                                                     kName: @"name",
                                                     kDOB: @"dob",
                                                     kAddress: @"address",
                                                     kEmail: @"email",
                                                     kMaritalStatus: @"maritalStaus",
                                                     kGender: @"gender",
                                                     kAliveChildrenCount: @"aliveChildCount",
                                                     kDeceasedChildrenCount: @"deceasedChildCount",
                                                     kEducation: @"education",
                                                     kOccupation: @"occuption",
                                                     kRegisteredBy: @"registeredBy",
                                                     kAdharId: @"adharId",
                                                     kVoterId: @"volterId",
                                                     kCreatedAt: @"createdAt",
                                                     kUpdatedAt: @"updatedAt",
                                                     kPhoneNumber: @"phoneNumber",
                                                     kHomePhoneNumber: @"homePhoneNumber",
                                                     kReligion: @"religion"
                                                     }];
  return patientMapping;
  
}

@end
