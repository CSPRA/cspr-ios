//
//  VolunteerSignUpViewController.h
//  Wallet
//
//  Created by Harshita
//

#import <UIKit/UIKit.h>
#import "WalletSuperViewController.h"

typedef NS_ENUM(NSUInteger, ProfileChangeType) {
    ProfileChangeType_Details=0,
    ProfileChangeType_Password,
    ProfileChangeType_Verify,
    ProfileChangeType_Validate,
};

@interface VolunteerSignUpViewController : WalletSuperViewController

@property (nonatomic, assign) ProfileChangeType changeType;

@end
