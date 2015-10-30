//
//  Event.m
//  
//
//  Created by aam-fueled on 16/10/15.
//
//

#import "Event.h"

@implementation Event


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