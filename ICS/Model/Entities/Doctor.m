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

+ (RKEntityMapping*)restkitObjectMappingForStore:(RKManagedObjectStore *)store {
  RKEntityMapping *doctorMapping = [RKEntityMapping mappingForEntityForName:kDoctorEntityName
                                                        inManagedObjectStore:store];
  [doctorMapping setIdentificationAttributes:@[@"doctorId"]];
  [doctorMapping addAttributeMappingsFromDictionary:@{
                                                       @"doctorId": @"doctorId",
                                                       @"firstName": @"firstName",
                                                       @"lastName": @"lastName",
                                                       @"contactNumber": @"phoneNumber",
                                                       }];
  return doctorMapping;
}
@end
