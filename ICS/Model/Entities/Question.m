//
//  Question.m
//  
//
//  Created by aam-fueled on 16/10/15.
//
//

#import "Question.h"

@implementation Question

- (Question*)questionWithId:(NSInteger)questionId {
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"questionId == %@", questionId];
  return (Question*)[kSharedModel objectWithEntityName:kQuestionEntityName predicate:predicate];
}

+ (RKEntityMapping*)restkitObjectMappingForStore:(RKManagedObjectStore *)store {
  RKEntityMapping *questionMapping = [RKEntityMapping mappingForEntityForName:kQuestionEntityName
                                                        inManagedObjectStore:store];
  [questionMapping setIdentificationAttributes:@[@"questionId"]];
  [questionMapping addAttributeMappingsFromDictionary:@{
                                                       @"questionId": @"questionId",
                                                       @"type": @"questionType",
                                                       @"title": @"title",
                                                       }];
  return questionMapping;
}
@end
