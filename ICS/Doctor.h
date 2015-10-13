//
//  Doctor.h
//  ICS
//
//  Created by aam-fueled on 13/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Doctor : NSObject

@property (nonatomic, strong) NSString *doctorId;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *specialization;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSNumber *doctorRatingValue;
@end
