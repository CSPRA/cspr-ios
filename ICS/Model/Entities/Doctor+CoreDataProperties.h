//
//  Doctor+CoreDataProperties.h
//  
//
//  Created by aam-fueled on 16/10/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Doctor.h"

NS_ASSUME_NONNULL_BEGIN

@interface Doctor (CoreDataProperties)

@property (nonatomic) int64_t doctorId;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *specialization;
@property (nullable, nonatomic, retain) NSString *address;
@property (nonatomic) int64_t phoneNumber;
@property (nonatomic) float ratingValue;

@end

NS_ASSUME_NONNULL_END
