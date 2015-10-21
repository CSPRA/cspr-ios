//
//  Event.m
//  
//
//  Created by aam-fueled on 16/10/15.
//
//

#import "Event.h"

@implementation Event

+ (Event*)eventWithId:(NSInteger)eventId {
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"eventId == %i", eventId];
  return (Event*)[kSharedModel objectWithEntityName:kEventEntityName predicate:predicate];
}

+ (RKEntityMapping*)restkitObjectMappingForStore:(RKManagedObjectStore *)store {
  
  RKEntityMapping *eventMapping = [RKEntityMapping mappingForEntityForName:kEventEntityName
                                                      inManagedObjectStore:store];
  [eventMapping setIdentificationAttributes:@[@"eventId"]];
  [eventMapping addAttributeMappingsFromDictionary:@{
                                                     @"eventId": @"eventId",
                                                     @"eventName": @"eventName",
                                                     @"eventType": @"eventType",
                                                     @"startingDate": @"startingDate",
                                                     @"endingDate": @"endingDate"
                                                     }];
  
  return eventMapping;
}

@end