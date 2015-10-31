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

- (NSManagedObject*)fetchManagedObjectWithEntityName:(NSString*)entityName {
  NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
  
  NSError *error = nil;
  NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
  
  NSManagedObject *fetchedObject = [fetchedObjects firstObject];
  return fetchedObject;
}

- (NSArray*)fetchObjectWithEntityName: (NSString*)entityName {
  NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
  
  NSError *error = nil;
  NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
  return fetchedObjects;
}

@end
