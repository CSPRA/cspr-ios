//
//  Patient.m
//  
//
//  Created by aam-fueled on 16/10/15.
//
//

#import "Patient.h"

@implementation Patient

- (Patient*)patientWithId: (NSInteger)patientId {
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"patientId == %@", patientId];
  return (Patient*)[kSharedModel objectWithEntityName:kPatientEntityName predicate:predicate];
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
