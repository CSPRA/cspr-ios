//
//  Cancer+CoreDataProperties.h
//  
//
//  Created by aam-fueled on 21/10/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Cancer.h"

NS_ASSUME_NONNULL_BEGIN

@interface Cancer (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *cancerId;
@property (nullable, nonatomic, retain) NSString *cancerName;
@property (nullable, nonatomic, retain) NSString *cancerDescription;

@end

NS_ASSUME_NONNULL_END
