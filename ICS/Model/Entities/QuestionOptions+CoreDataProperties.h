//
//  QuestionOptions+CoreDataProperties.h
//  
//
//  Created by Aqsa on 01/11/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "QuestionOptions.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuestionOptions (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *groupId;
@property (nullable, nonatomic, retain) NSNumber *optionId;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *order;

@end

NS_ASSUME_NONNULL_END
