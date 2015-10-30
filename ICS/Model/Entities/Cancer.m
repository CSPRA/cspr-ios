//
//  Cancer.m
//  
//
//  Created by aam-fueled on 21/10/15.
//
//

#import "Cancer.h"

@implementation Cancer

+ (RKEntityMapping*)restkitObjectMappingForStore:(RKManagedObjectStore *)store {
  
  RKEntityMapping *cancerMapping = [RKEntityMapping mappingForEntityForName:kCancerEntityName
                                                      inManagedObjectStore:store];
  [cancerMapping setIdentificationAttributes:@[kCancerID]];
  [cancerMapping addAttributeMappingsFromDictionary:@{
                                                     kCancerID: @"cancerId",
                                                     kCancerName: @"cancerName",
                                                     kCancerDescription: @"cancerDescription"
                                                     }];
  
  return cancerMapping;
}

@end
