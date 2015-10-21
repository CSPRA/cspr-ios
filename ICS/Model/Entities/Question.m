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
@end
