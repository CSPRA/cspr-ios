//
//  Event.h
//  
//
//  Created by aam-fueled on 16/10/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Event : NSManagedObject<RestKitAdditions>

- (void)fetchEvent;
@end

NS_ASSUME_NONNULL_END

#import "Event+CoreDataProperties.h"
