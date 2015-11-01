//
//  Question+CoreDataProperties.h
//  
//
//  Created by Aqsa on 01/11/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Question.h"

NS_ASSUME_NONNULL_BEGIN

@class QuestionOptions;

@interface Question (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *questionId;
@property (nullable, nonatomic, retain) NSString *questionType;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *queryId;
@property (nullable, nonatomic, retain) NSString *units;
@property (nullable, nonatomic, retain) NSNumber *order;
@property (nullable, nonatomic, retain) QuestionOptions *options;

@end

NS_ASSUME_NONNULL_END
