//
//  Patient+CoreDataProperties.h
//  ICS
//
//  Created by Aqsa on 01/11/15.
//  Copyright © 2015 Meraki. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Patient.h"

NS_ASSUME_NONNULL_BEGIN

@interface Patient (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nonatomic) NSTimeInterval dob;
@property (nonatomic) int64_t patientId;
@property (nullable, nonatomic, retain) NSString *phoneNumber;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *occuption;
@property (nonatomic) int16_t aliveChildCount;
@property (nonatomic) int16_t deceasedChildCount;
@property (nullable, nonatomic, retain) NSString *maritalStatus;
@property (nullable, nonatomic, retain) NSString *education;
@property (nullable, nonatomic, retain) NSDecimalNumber *annualIncome;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *religion;
@property (nullable, nonatomic, retain) NSString *voterId;
@property (nullable, nonatomic, retain) NSString *adharId;
@property (nullable, nonatomic, retain) NSString *homePhoneNumber;
@property (nullable, nonatomic, retain) NSString *gender;
@property (nonatomic) NSTimeInterval createdAt;
@property (nonatomic) NSTimeInterval updatedAt;
@property (nonatomic) int16_t registeredBy;

@end

NS_ASSUME_NONNULL_END
