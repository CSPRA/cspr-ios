//
//  Volunteer.m
//  
//
//  Created by Aqsa on 26/10/15.
//
//

#import "Volunteer.h"

@implementation Volunteer

+ (Volunteer*)fetchVolunteer {
  return (Volunteer*)[kSharedModel fetchManagedObjectWithEntityName:kVolunteerEntityName];
}

+ (RKEntityMapping*)restkitObjectMappingForStore:(RKManagedObjectStore *)store {
  RKEntityMapping *volunteerMapping = [RKEntityMapping mappingForEntityForName:kVolunteerEntityName
                                                       inManagedObjectStore:store];
  [volunteerMapping addAttributeMappingsFromDictionary:@{
                                                         @"id" : @"volunteerId",
                                                         @"token": @"token",
                                                         @"email": @"email",
                                                         @"password": @"password",
                                                         @"username": @"username",
                                                         @"contactNumber": @"contactNumber",
                                                         @"firstname": @"firstName",
                                                         @"lastname": @"lastName",
                                                      }];
  return volunteerMapping;

}
@end
