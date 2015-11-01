//
//  QuestionOptions.m
//  
//
//  Created by Aqsa on 01/11/15.
//
//

#import "QuestionOptions.h"

@implementation QuestionOptions

+ (RKEntityMapping*)restkitObjectMappingForStore:(RKManagedObjectStore *)store {
  RKEntityMapping *volunteerMapping = [RKEntityMapping mappingForEntityForName:kQuestionOptionsEntitiyName
                                                          inManagedObjectStore:store];
  [volunteerMapping addAttributeMappingsFromDictionary:@{
                                                        kOptionId:@"optionId",
                                                        kOptionName:@"name",
                                                        kOptionGroupId :@"groupId",
                                                        kOrder:@"order"
                                                        }];
  return volunteerMapping;
}

@end
