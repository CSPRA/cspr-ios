//
//  Event+CoreDataProperties.h
//  
//
//  Created by Aqsa on 30/10/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Event.h"
@class Cancer, Form;

NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *endingDate;
@property (nullable, nonatomic, retain) NSNumber *eventId;
@property (nullable, nonatomic, retain) NSString *eventName;
@property (nullable, nonatomic, retain) NSString *eventType;
@property (nullable, nonatomic, retain) NSDate *startingDate;
@property (nullable, nonatomic, retain) Form *form;
@property (nullable, nonatomic, retain) Cancer *cancer;

@end

NS_ASSUME_NONNULL_END
