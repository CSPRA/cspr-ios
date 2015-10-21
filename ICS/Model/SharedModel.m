//
//  SharedModel.m
//  ICS
//
//  Created by aam-fueled on 07/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "SharedModel.h"
#import "AppDelegate.h"

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
    self.managedObjectContext = [(AppDelegate*)[UIApplication sharedApplication].delegate managedObjectContext];
  }
  return self;
}

- (NSString*)filePathWithPatientID :(NSInteger)patientId {
  NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                      NSUserDomainMask,
                                                      YES);
  NSString *documentPath = [path firstObject];
  NSString *destinationPath = [documentPath stringByAppendingPathComponent:
              [NSString stringWithFormat:@"patientsImages-%ld",(long)patientId]];
  return [destinationPath stringByAppendingPathExtension:@"plist"];
}

- (ICSDataSource*)dataSource {
  ICSDataSource *dataSource = [[ICSDataSource alloc] init];
  return dataSource;
}

- (NSManagedObject*)objectWithEntityName: (NSString*)entityName predicate: (NSPredicate*)predicate {
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                            inManagedObjectContext:self.managedObjectContext];
  request.predicate = predicate;
  [request setEntity:entity];
  NSError *error = nil;

  NSArray *objects = [self.managedObjectContext executeFetchRequest:request
                                                              error:&error];
  if (objects.count) {
    return [objects firstObject];
  }
  return nil;
}

@end
