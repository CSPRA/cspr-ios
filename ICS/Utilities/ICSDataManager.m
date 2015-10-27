//
//  ICSDataManager.m
//  ICS
//
//  Created by Harshita
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "ICSDataManager.h"

@implementation ICSDataManager


+ (id) sharedManager {
    static ICSDataManager *sharedHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHelper = [[self alloc] init];
    });
    return sharedHelper;
}

#pragma mark - 

+(BOOL)isVolunteerRegistered {
    return [[NSUserDefaults standardUserDefaults] boolForKey:icsVolunteerRegisteredStatusKey];
}

+(void)setVolunteerAsRegistered {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:icsVolunteerRegisteredStatusKey];
}

#pragma mark -

+(BOOL)hasWalkthroughBeenShown {
    return [[NSUserDefaults standardUserDefaults] boolForKey:icsVolunteerWalkthroughStatusKey];
}

+(void)disableAutomaticWalkthroughPreview {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:icsVolunteerWalkthroughStatusKey];
}

#pragma mark - Volunteer Onboarding

-(void)checkVolunteerAccessForPhoneNumber:(NSString*)phoneNumber withCompletion:(void (^)(id response, BOOL success))completion {
    completion(@"Success", YES);
}

-(void)loginVolunteerWithDetails:(NSDictionary*)vDetails withCompletion:(void (^)(id response, BOOL success))completion {
    BOOL successStatus = YES;
    if(successStatus) {
        [ICSDataManager setVolunteerAsRegistered];
    }
    completion(@"Success", successStatus);
}

#pragma mark - Patient Registration Flow

-(void)endDiagnosisForPatientID:(NSString*)patientID withData:(NSDictionary*)patientDetails withCompletion:(void (^)(id response, BOOL success))completion {
    completion(@"Success", YES);
}

@end
