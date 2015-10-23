//
//  ICSDataSource.m
//  ICS
//
//  Created by aqsa-fueled on 17/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "ICSDataSource.h"
#import "SharedModel.h"

@implementation ICSDataSource


- (void)signinUserWithUsername:(NSString *)username password:(NSString *)password withCompletionBlock:(ICSApiInterfaceBlock)block {
  
}

- (void)fetchEventsWithToken:(NSString*)token
             completionBlock:(ICSApiInterfaceBlock)block {
  NSDictionary *parameters = @{
                               @"token":token
                               };
  
  [[RKObjectManager sharedManager] getObjectsAtPath:@"/volunteer/myScreeningAssignments"
                                         parameters:parameters
                                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                              block(YES, [mappingResult array], nil);
                                            } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                              block(NO, nil, error);
                                            }];
  
}


- (void)registerPatientWithParameters:(NSDictionary *)paramenters
                 completionBlock:(ICSApiInterfaceBlock)block {

  [[RKObjectManager sharedManager] postObject:nil
                                         path:@"/volunteer/registerPatient"
                                   parameters:paramenters
                                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                        block(YES, [mappingResult array], nil);
                                      } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                        block(NO, nil, error);
                                      }];
}



@end
