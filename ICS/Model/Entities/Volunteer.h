//
//  Volunteer.h
//  
//
//  Created by Aqsa on 26/10/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Volunteer : NSManagedObject<RestKitAdditions>
+ (Volunteer*)fetchVolunteer;
@end

NS_ASSUME_NONNULL_END

#import "Volunteer+CoreDataProperties.h"
