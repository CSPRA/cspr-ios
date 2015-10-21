//
//  Event+CoreDataProperties.h
//  
//
//  Created by aqsa-fueled on 16/10/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Event.h"

NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

@property (nonatomic) int64_t eventId;
@property (nullable, nonatomic, retain) NSString *eventName;
@property (nullable, nonatomic, retain) NSString *eventType;
@property (nonatomic) NSDate *startingDate;
@property (nonatomic) NSDate *endingDate;

@end

NS_ASSUME_NONNULL_END
