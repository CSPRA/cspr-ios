//
//  Volunteer.h
//  
//
//  Created by Aqsa on 26/10/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "APIInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface Volunteer : NSManagedObject<RestKitAdditions>

- (Volunteer*)volunteerWithId:(NSInteger)volunteer;

@end

NS_ASSUME_NONNULL_END

#import "Volunteer+CoreDataProperties.h"
