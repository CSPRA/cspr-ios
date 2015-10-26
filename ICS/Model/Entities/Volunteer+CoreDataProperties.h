//
//  Volunteer+CoreDataProperties.h
//  
//
//  Created by Aqsa on 26/10/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Volunteer.h"

NS_ASSUME_NONNULL_BEGIN

@interface Volunteer (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *token;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSNumber *volunteerId;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSString *contactNumber;
@property (nullable, nonatomic, retain) NSString *email;

@end

NS_ASSUME_NONNULL_END
