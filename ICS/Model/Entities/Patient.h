//
//  Patient.h
//  
//
//  Created by aam-fueled on 16/10/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "APIInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface Patient : NSManagedObject<RestKitAdditions>

- (Patient*)fetchPatient;
+ (void)setupPatientMapping:(NSString*)path;

@end

NS_ASSUME_NONNULL_END

#import "Patient+CoreDataProperties.h"
