//
//  Form.m
//  
//
//  Created by aam-fueled on 21/10/15.
//
//

#import "Form.h"

@implementation Form

+ (RKEntityMapping*)restkitObjectMappingForStore:(RKManagedObjectStore *)store {
  
  RKEntityMapping *cancerMapping = [RKEntityMapping mappingForEntityForName:kFormEntityName
                                                       inManagedObjectStore:store];
  [cancerMapping setIdentificationAttributes:@[kFormID]];
  [cancerMapping addAttributeMappingsFromDictionary:@{
                                                      kFormID: @"formId",
                                                      kFormName: @"formName",
                                                      kFormDescription: @"formDescription"
                                                      }];
  
  return cancerMapping;
}
@end
