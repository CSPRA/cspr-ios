//
//  SharedModel.h
//  ICS
//
//  Created by aam-fueled on 07/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICSDataSource.h"

@interface SharedModel : NSObject
@property (nonatomic, strong) NSManagedObjectContext  *managedObjectContext;

+ (instancetype)shared;
- (NSString*)filePathWithPatientID :(NSInteger)patientId;
- (ICSDataSource*)dataSource;

- (NSArray*)fetchObjectWithEntityName: (NSString*)entityName;

/** Fetching Managed object
 @param entityName entity name of object
 */
- (NSManagedObject*)fetchManagedObjectWithEntityName:(NSString*)entityName;
@end
