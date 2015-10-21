//
//  RestKitAddition.h
//  ICS
//
//  Created by aqsa-fueled on 21/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/Restkit.h>

@protocol RestKitAdditions

@optional

+(RKObjectMapping *)restkitObjectMapping;
+(RKEntityMapping *)restkitObjectMappingForStore:(RKManagedObjectStore *)store;
+(RKEntityMapping *)serializationMapping;
+(RKObjectMapping *)serializationMappingForStore:(RKManagedObjectStore *)store;

@end
