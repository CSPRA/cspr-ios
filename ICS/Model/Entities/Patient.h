//
//  Patient.h
//  
//
//  Created by aam-fueled on 16/10/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Patient : NSManagedObject

- (Patient*)patientWithId: (NSInteger)patientId;

@end

NS_ASSUME_NONNULL_END

#import "Patient+CoreDataProperties.h"
