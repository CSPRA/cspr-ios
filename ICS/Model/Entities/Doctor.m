//
//  Doctor.m
//  
//
//  Created by aam-fueled on 16/10/15.
//
//

#import "Doctor.h"

@implementation Doctor

- (Doctor*)doctorWithId:(NSInteger)doctorId {
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"doctorId == %@", doctorId];
  return (Doctor*)[kSharedModel objectWithEntityName:kDoctorEntityName predicate:predicate];
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
