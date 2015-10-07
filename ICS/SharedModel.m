//
//  SharedModel.m
//  ICS
//
//  Created by aam-fueled on 07/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "SharedModel.h"

@implementation SharedModel

+ (instancetype)shared {
  static SharedModel *_instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _instance = [[SharedModel alloc] init];
  });
  return _instance;
}


- (id)init {
  self = [super init];
  if(self) {
    // other initialization.
  }
  return self;
}


- (NSString*)filePathWithPatientID :(NSString*)patientId {
  NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                      NSUserDomainMask,
                                                      YES);
  NSString *documentPath = [path firstObject];
  NSString *destinationPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"patientsImages-%@",patientId]];
  return [destinationPath stringByAppendingPathExtension:@"plist"];
}

@end
