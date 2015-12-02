//
//  DoctorDummyObject.h
//  ICS
//
//  Created by aqsa-fueled on 03/12/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoctorDummyObject : NSObject
@property (nonatomic, strong) NSString *doctorId;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *specialization;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSNumber *doctorRatingValue;
@end
