//
//  Doctor.m
//  
//
//  Created by aam-fueled on 16/10/15.
//
//

#import "Doctor.h"

@implementation Doctor

- (Doctor*)fetchDoctor {
  return (Doctor*)[kSharedModel fetchManagedObjectWithEntityName:kDoctorEntityName];
}

+ (void)setupDoctorMapping:(NSString*)path {
  RKEntityMapping *doctorMapping = [Doctor restkitObjectMappingForStore:[RKObjectManager sharedManager].managedObjectStore];
  RKResponseDescriptor *doctorDescriptor =
  [RKResponseDescriptor responseDescriptorWithMapping:doctorMapping pathPattern:path
                                              keyPath:@"result"
                                          statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
  [[RKObjectManager sharedManager] addResponseDescriptor:doctorDescriptor];
  
  doctorDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:doctorMapping
                                                              pathPattern:path
                                                                 keyPath:@"error"
                                                              statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
  [[RKObjectManager sharedManager] addResponseDescriptor:doctorDescriptor];
}
+ (RKEntityMapping*)restkitObjectMappingForStore:(RKManagedObjectStore *)store {
  RKEntityMapping *doctorMapping = [RKEntityMapping mappingForEntityForName:kDoctorEntityName
                                                        inManagedObjectStore:store];
  [doctorMapping setIdentificationAttributes:@[@"doctorId"]];
  [doctorMapping addAttributeMappingsFromDictionary:@{
                                                      kDoctorID: @"doctorId",
                                                      kFirstName: @"firstName",
                                                      kLastName: @"lastName",
                                                      kPhoneNumber: @"phoneNumber",
                                                      kRating: @"ratingValue",
                                                      kSpecialization: @"specialization",
                                                      kLocation: @"address"
                                                      }];
  return doctorMapping;
}
@end
