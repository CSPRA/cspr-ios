//
//  Form+CoreDataProperties.h
//  
//
//  Created by aam-fueled on 21/10/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Form.h"

NS_ASSUME_NONNULL_BEGIN

@interface Form (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *formName;
@property (nullable, nonatomic, retain) NSNumber *formId;
@property (nullable, nonatomic, retain) NSString *formDescription;

@end

NS_ASSUME_NONNULL_END
