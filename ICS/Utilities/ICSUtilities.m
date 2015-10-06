//
//  ICSUtilities.m
//  ICS
//
//  Created by Harshita
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "ICSUtilities.h"
#import "Reachability.h"

@implementation ICSUtilities

+ (BOOL) hasActiveConnection {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

@end
