//
//  ICSDataSource.m
//  ICS
//
//  Created by aqsa-fueled on 17/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "ICSDataSource.h"
#import "SharedModel.h"

@implementation ICSDataSource


- (void)signinUserWithUsername:(NSString *)username password:(NSString *)password withCompletionBlock:(ICSApiInterfaceBlock)block {
  
}

- (void)fetchEventsWithCompletionBlock:(ICSApiInterfaceBlock)block {
  
  }


- (Patient*)patientWithId: (NSInteger)patientId {
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"patientId == %@", patientId];
  return (Patient*)[[SharedModel shared] objectWithEntityName:kPatientEntityName predicate:predicate];
}

- (Event*)eventWithId:(NSInteger)eventId {
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"eventId == %u", eventId];
  return (Event*)[[SharedModel shared] objectWithEntityName:kEventEntityName predicate:predicate];
}

- (Doctor*)doctorWithId:(NSInteger)doctorId {
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"doctorId == %@", doctorId];
  return (Doctor*)[[SharedModel shared] objectWithEntityName:kDoctorEntityName predicate:predicate];
}

- (Question*)questionWithId:(NSInteger)questionId {
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"questionId == %@", questionId];
  return (Question*)[[SharedModel shared] objectWithEntityName:kQuestionEntityName predicate:predicate];
}
@end
