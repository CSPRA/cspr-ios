//
//  DiagnosisPhoto.m
//  ICS
//
//  Created by Harshita on 27/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "DiagnosisPhoto.h"

@implementation DiagnosisPhoto

-(void)encodeWithCoder:(NSCoder*)coder {
    [coder encodeObject:self.dpImage        forKey:@"dp_image"];
    [coder encodeBool:self.dpSuspectStatus forKey:@"dp_s"];
}


-(instancetype)initWithCoder:(NSCoder*)aDecoder {
    if((self = [super init])) {
        self.dpImage          = [aDecoder decodeObjectForKey:@"dp_image"];
        self.dpSuspectStatus   = [aDecoder decodeBoolForKey:@"dp_s"];
    }
    return self;
}

@end
