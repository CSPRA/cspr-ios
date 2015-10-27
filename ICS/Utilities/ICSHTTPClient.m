//
//  ICSHTTPClient.m
//  ICS
//
//  Created by Harshita
//  Copyright (c) 2015 Meraki. All rights reserved.
//

#import "ICSHTTPClient.h"
#define IHCEnableUrlLogging NO
#define IHCNoInternetMessage @"No internet found"
#define IHCInvalidDataError  @"Data invalid"
@implementation ICSHTTPClient

#pragma mark - Initialization

+ (ICSHTTPClient *)sharedICSClient {
    NSString * baseURL = @"";
    static dispatch_once_t dispatchOnce;
    static ICSHTTPClient *_sharedICSClient = nil;
    dispatch_once(&dispatchOnce, ^{ _sharedICSClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseURL]]; });
    return _sharedICSClient;
}


+ (ICSHTTPClient *)stagingSCAClient {
    NSString * baseURL = @"";
    static dispatch_once_t dispatchOnce;
    static ICSHTTPClient *_sharedICSClient = nil;
    dispatch_once(&dispatchOnce, ^{ _sharedICSClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseURL]]; });
    return _sharedICSClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFCompoundResponseSerializer serializer];
    }
    return self;
}

#pragma mark - ICS APIs

- (void)performLoginTask:(NSString *)taskName customParams:(NSDictionary *)params completion:(void (^)(id responseObject, BOOL success))completion {
    if(![ICSUtilities hasActiveConnection]) {
        completion(IHCNoInternetMessage, NO);
        return;
    }
    
    
    [self GET:@""
   parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if(IHCEnableUrlLogging) {
              NSLog(@"Response: Success for Task: %@ \nURL: %@", taskName, operation.request.URL.absoluteString);
          }
          if (responseObject) {
              
              //Data
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
          if(IHCEnableUrlLogging) {
              NSLog(@"Response: Failure for Task: %@ \nURL: %@", taskName, operation.request.URL.absoluteString);
          }
          
          if (completion) {
              completion(IHCInvalidDataError, NO);
          }
      }];
}





- (void)performTask:(NSString *)taskName customParams:(NSDictionary *)params completion:(void (^)(id responseObject, BOOL success))completion {
    if(![ICSUtilities hasActiveConnection]) {
        completion(IHCNoInternetMessage, NO);
        return;
    }
    
    [self GET:@""
   parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if(IHCEnableUrlLogging) {
              NSLog(@"Response: Success for Task: %@ \nURL: %@", taskName, operation.		request.URL.absoluteString);
          }
          if (responseObject) {
              //Data
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if(IHCEnableUrlLogging) {
              NSLog(@"Response: Failure for Task: %@ \nURL: %@", taskName, operation.request.URL.absoluteString);
          }
          
          if (completion) {
              completion(IHCInvalidDataError, NO);
          }
      }];
}

- (void)fetchDataFor:(NSString *)taskName customParams:(NSDictionary *)params completion:(void (^)(id responseObject, BOOL success))completion {
    if(![ICSUtilities hasActiveConnection]) {
        completion(IHCNoInternetMessage, NO);
        return;
    }
    
    [self GET:taskName
   parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          
          if(IHCEnableUrlLogging) {
              NSLog(@"Response: Success for Task: %@ \nURL: %@", taskName, operation.request.URL.absoluteString);
          }
          
          if (responseObject) {

              NSError *error;
              
              NSDictionary * jsonData = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
              if(error) {
                  NSString *returnString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                  NSLog(@"Error task: %@ debug : %@ Response: %@", taskName, error.debugDescription, returnString);
                  completion(IHCInvalidDataError, NO);
              }
              else {
                  NSDictionary * responseData = [jsonData objectForKey:@""];
                  completion(responseData, YES);
              }
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if(IHCEnableUrlLogging) {
              NSLog(@"Response: Failure for Task: %@ \nURL: %@", taskName, operation.request.URL.absoluteString);
          }
          
          if (completion) {
              completion(IHCInvalidDataError, NO);
          }
      }];
}


@end