//
//  ICSHTTPClient.h
//  ICS
//
//  Created by Harshita
//  Copyright (c) 2015 Meraki. All rights reserved.
//

#import "AFNetworking.h"

@protocol ICSHTTPClientDelegate;

@interface ICSHTTPClient : AFHTTPRequestOperationManager

@property(weak) id<ICSHTTPClientDelegate> delegate;


/**
 *  Instance of ICS  HTTP Client
 *
 *  @return instance
 */
+ (ICSHTTPClient *)sharedICSClient;

/**
 *  Tasks that only perform function where result is of no value
 *
 *  @param task       Task Name
 *  @param params     Dictionary of parameters
 *  @param completion completion block
 */
- (void)performTask:(NSString *)task customParams:(NSDictionary *)params completion:(void (^)(id responseObject, BOOL success))completion;

/**
 *  Tasks that return JSON
 *
 *  @param task       Task Name
 *  @param params     Dictionary of parameters
 *  @param completion completion block
 */
- (void)fetchDataFor:(NSString *)task customParams:(NSDictionary *)params completion:(void (^)(id responseObject, BOOL success))completion;

/**
 *  User Login
 *
 *  @param task       Task Name
 *  @param params     Dictionary of parameters
 *  @param completion completion block
 */
- (void)performLoginTask:(NSString *)task customParams:(NSDictionary *)params completion:(void (^)(id responseObject, BOOL success))completion;

@end

/**
 *  Delegates
 */
@protocol ICSHTTPClientDelegate <NSObject>
-(void)ICSHTTPClient:(ICSHTTPClient *)client didReceiveData:(id)data; //Success
-(void)ICSHTTPClient:(ICSHTTPClient *)client didFailWithError:(NSError *)error; //Error
@end
