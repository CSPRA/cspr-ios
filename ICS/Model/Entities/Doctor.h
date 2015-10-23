//
//  Doctor.h
//  
//
//  Created by aqsa-fueled on 16/10/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "APIInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface Doctor : NSManagedObject<RestKitAdditions>

- (Doctor*)doctorWithId:(NSInteger)doctorId;

@end

NS_ASSUME_NONNULL_END

#import "Doctor+CoreDataProperties.h"
