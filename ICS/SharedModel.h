//
//  SharedModel.h
//  ICS
//
//  Created by aam-fueled on 07/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedModel : NSObject

+ (instancetype)shared;
- (NSString*)filePathWithPatientID :(NSString*)patientId;

@end
