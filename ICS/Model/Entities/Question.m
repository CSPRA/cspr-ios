//
//  Question.m
//  
//
//  Created by aam-fueled on 16/10/15.
//
//

#import "Question.h"
#import "QuestionOptions.h"

@implementation Question

- (Question*)fetchQuestion {
  return (Question*)[kSharedModel fetchManagedObjectWithEntityName:kQuestionEntityName];
}

+ (RKEntityMapping*)restkitObjectMappingForStore:(RKManagedObjectStore *)store {
  RKEntityMapping *questionMapping = [RKEntityMapping mappingForEntityForName:kQuestionEntityName
                                                        inManagedObjectStore:store];
  [questionMapping setIdentificationAttributes:@[@"questionId"]];
  [questionMapping addAttributeMappingsFromDictionary:@{
                                                       kQuestionsId: @"questionId",
                                                       kQuestionType: @"questionType",
                                                       kQuestionTitle: @"title",
                                                       kQueryId : @"queryId",
                                                       kUnits : @"units",
                                                       kOrder : @"order"
                                                       }];
  
  RKEntityMapping *optionsMapping = [QuestionOptions restkitObjectMappingForStore:store];
  [questionMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:kQuestionOptions
                                                                               toKeyPath:@"options"
                                                                             withMapping:optionsMapping]];
  return questionMapping;
}
@end
