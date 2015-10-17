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
- (NSManagedObject*)objectWithEntityName: (NSString*)entityName predicate: (NSPredicate*)predicate;

@end
