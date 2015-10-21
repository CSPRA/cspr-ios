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

@end
