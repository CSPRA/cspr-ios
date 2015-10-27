//
//  DiagnosisPhoto.h
//  ICS
//
//  Created by Harshita on 27/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface DiagnosisPhoto : NSObject<NSCoding>
@property (nonatomic, strong) UIImage *dpImage;
@property (nonatomic, assign) BOOL dpSuspectStatus;

@end
