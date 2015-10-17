//
//  AppDelegate.m
//  ICS
//
//  Created by Harshita
//  Copyright (c) 2015 Meraki. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <DigitsKit/DigitsKit.h>
#import <Crashlytics/Crashlytics.h>
#import <RestKit/RestKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[[Crashlytics class], [Digits class]]];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Core Data accessors
- (NSManagedObjectContext *) managedObjectContext {
  if (_managedObjectContext != nil) {
    return _managedObjectContext;
  }
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (coordinator != nil) {
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    _managedObjectContext.mergePolicy = NSOverwriteMergePolicy;
    [_managedObjectContext setPersistentStoreCoordinator: coordinator];
  }
  return _managedObjectContext;
}


- (NSManagedObjectModel *)managedObjectModel {
  if (_managedObjectModel != nil) {
    return _managedObjectModel;
  }
  _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
  return _managedObjectModel;
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  if (_persistentStoreCoordinator != nil) {
    return _persistentStoreCoordinator;
  }
  NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                             stringByAppendingPathComponent: @"ICSModel.sqlite"]];
  NSError *error = nil;
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                 initWithManagedObjectModel:[self managedObjectModel]];
  if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                configuration:nil URL:storeUrl options:nil error:&error]) {
    /*Error for store creation should be handled in here*/
  }
  return _persistentStoreCoordinator;
}


- (NSError*)saveContext
{
  NSError *error = nil;
  NSManagedObjectContext *context = self.managedObjectContext;
  if (context != nil) {
    if ([context hasChanges] && ![context save:&error]) {
      // Replace this implementation with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      return error;
    }
  }
  return nil;
}

- (NSString *)applicationDocumentsDirectory {
  return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
