//
//  ICSDataSource.h
//  ICS
//
//  Created by aqsa-fueled on 17/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICSAPIError.h"
#import "APIInterface.h"
#import "Patient.h"
#import "Event.h"
#import "Question.h"
#import "Doctor.h"

typedef void (^ICSApiInterfaceBlock)(BOOL success,
                                        NSArray *result,
                                        NSError *error);

@interface ICSDataSource : NSObject

/** Signin using username and password.
 @param email Volunteer's registered username
 @param password Volunteer's account password
 @param block Completion block to be executed once call is completed
 */
- (void)signinUserWithUsername: (NSString*)username
                   password: (NSString*)password
        withCompletionBlock: (ICSApiInterfaceBlock)block;

/** Fetches latest events from the server
 @param block Completion block to be executed once call is completed
 */

- (void)fetchEventsWithToken: (NSString*)token
             completionBlock: (ICSApiInterfaceBlock)block;


@end
