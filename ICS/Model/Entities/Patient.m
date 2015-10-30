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

+ (RKEntityMapping*)restkitObjectMappingForStore:(RKManagedObjectStore *)store {
  RKEntityMapping *patientMapping = [RKEntityMapping mappingForEntityForName:kPatientEntityName
                                                        inManagedObjectStore:store];
  [patientMapping setIdentificationAttributes:@[@"patientId"]];
  [patientMapping addAttributeMappingsFromDictionary:@{
                                                     @"eventId": @"eventId",
                                                     @"eventName": @"eventName",
                                                     @"eventType": @"eventType",
                                                     @"startingDate": @"startingDate",
                                                     @"endingDate": @"endingDate"
                                                     }];
  return patientMapping;
  
}

@end
