//
//  Event.m
//  
//
//  Created by aam-fueled on 16/10/15.
//
//

#import "Event.h"
#import "Cancer.h"
#import "Form.h"

@implementation Event

- (void)fetchEvent {
  
}

+ (RKEntityMapping*)restkitObjectMappingForStore:(RKManagedObjectStore *)store {
  
  RKEntityMapping *eventMapping = [RKEntityMapping mappingForEntityForName:kEventEntityName
                                                      inManagedObjectStore:store];
  [eventMapping setIdentificationAttributes:@[@"eventId"]];
  
  RKEntityMapping *cancerMapping = [Cancer restkitObjectMappingForStore:store];
  RKEntityMapping *formMapping = [Form restkitObjectMappingForStore:store];
  
  [eventMapping addAttributeMappingsFromDictionary:@{
                                                     @"eventId": @"eventId",
                                                     @"eventName": @"eventName",
                                                     @"eventType": @"eventType",
                                                     @"startingDate": @"startingDate",
                                                     @"endingDate": @"endingDate"
                                                     }];
  [eventMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:kCancerType
                                                                              toKeyPath:@"cancer"
                                                                             withMapping:cancerMapping]];
  
  [eventMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"form"
                                                                               toKeyPath:@"form"
                                                                             withMapping:formMapping]];
  
  return eventMapping;
}



@end