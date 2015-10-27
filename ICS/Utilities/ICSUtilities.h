//
//  ICSUtilities.h
//  ICS
//
//  Created by Harshita
//  Copyright © 2015 Meraki. All rights reserved.
//

@import Foundation;

@interface ICSUtilities : NSObject

+ (BOOL)hasActiveConnection;
+ (BOOL)checkIfEmailIDIsValid:(NSString *)emailID ;
@end
