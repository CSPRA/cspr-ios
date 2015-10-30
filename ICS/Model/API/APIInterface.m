//
//  APIInterface.m
//  ICS
//
//  Created by aqsa-fueled on 17/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "APIInterface.h"

@implementation APIInterface

+(instancetype)sharedInterface {
  static APIInterface *_instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _instance = [[APIInterface alloc] init];
    // Do any other initialisation stuff here
    
  });
  return _instance;
}

- (id)init {
  self = [super init];
  if (self) {
    [self setupRestkit];
    [self setupMapping];
  }
  return self;
}

- (void)setupRestkit {
  // Enable Restkit Logs
  //RKLogConfigureByName("*", RKLogLevelTrace);
  // Create a new model using the coredata model file
  NSManagedObjectModel *objectModel = [[NSManagedObjectModel alloc]
                                       initWithContentsOfURL:kModelURL];
  // Create a new shared model using the API Base URL
  RKObjectManager *sharedManager = [RKObjectManager managerWithBaseURL:kICSAPIBaseURL];
  
  
  // create a new managed object store with the new model
  RKManagedObjectStore *managedStore = [[RKManagedObjectStore alloc]
                                        initWithManagedObjectModel:objectModel];
  NSError *error;
  NSString *storePath = [RKApplicationDataDirectory()
                         stringByAppendingPathComponent:kDataStoreFileName];
  // these options allow for lightweight migration
  NSDictionary *options = @{
                            NSMigratePersistentStoresAutomaticallyOption: @(YES),
                            NSInferMappingModelAutomaticallyOption: @(YES)
                            };
  
  NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];
  
  // create a persistent SQLite store with a new sqlite db file
  [managedStore addSQLitePersistentStoreAtPath:storePath
                        fromSeedDatabaseAtPath:seedPath
                             withConfiguration:nil
                                       options:options
                                         error:&error];
  if (error) {
    
    NSLog(@"unresolved error %@, %@", error, [error userInfo]);
    abort();
  }
  // create a managed object context for the new store
  [managedStore createManagedObjectContexts];
  // set the shared manager store as the new store
  sharedManager.managedObjectStore = managedStore;
  // Set the shared manager
  
  [RKObjectManager setSharedManager:sharedManager];
  // Configure a managed object cache to ensure we do not create duplicate objects
  managedStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedStore.persistentStoreManagedObjectContext];
}

- (void)setupMapping {
  NSIndexSet *successSet = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
  RKManagedObjectStore *store = [RKObjectManager sharedManager].managedObjectStore;
  
  //Mapping for event
  RKEntityMapping *eventMapping = [Event restkitObjectMappingForStore:store];
  
  RKResponseDescriptor *eventResponseDiscriptor =
  [RKResponseDescriptor responseDescriptorWithMapping:eventMapping
                                          pathPattern:@"/volunteer/myScreeningAssignments"
                                              keyPath:@"results"
                                          statusCodes:successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:eventResponseDiscriptor];
  
  //Mapping for patient
  
  //Mapping for volunteer
  RKEntityMapping *volunteerMapping = [Volunteer restkitObjectMappingForStore:store];
  RKResponseDescriptor *volunteerResponseDescriptor =
  [RKResponseDescriptor responseDescriptorWithMapping:volunteerMapping
                                          pathPattern:@"/volunteer/register"
                                              keyPath:@"result"
                                          statusCodes:successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:volunteerResponseDescriptor];
  
  
  //Mapping for volunteer Login
  RKResponseDescriptor *loginDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:volunteerMapping
                                          pathPattern:kVolunteerLoginPath
                                              keyPath:@"result"
                                          statusCodes:successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:loginDescriptor];
  RKResponseDescriptor *loginError =
  [RKResponseDescriptor responseDescriptorWithMapping:volunteerMapping pathPattern:kVolunteerLoginPath keyPath:@"Error" statusCodes:successSet];
  [[RKObjectManager sharedManager] addResponseDescriptor:loginError];
}

@end
