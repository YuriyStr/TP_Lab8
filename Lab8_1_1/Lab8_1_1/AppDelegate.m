//
//  AppDelegate.m
//  Lab8_1_1
//
//  Created by Admin on 07.05.17.
//  Copyright (c) 2017 Yury Struchkou. All rights reserved.
//

#import "AppDelegate.h"
#import "Record.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES
                                                forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        Record * firstFlight = [NSEntityDescription
                                insertNewObjectForEntityForName:@"Record"
                                inManagedObjectContext:self.managedObjectContext];
        firstFlight.cityFrom = @"Chelyabinsk";
        firstFlight.cityTo = @"Moscow";
        firstFlight.aviaCompany = @"Aeroflot";
        firstFlight.price = [NSNumber numberWithInt:1000.0];
        Record * secondFlight = [NSEntityDescription
                                 insertNewObjectForEntityForName:@"Record"
                                 inManagedObjectContext:self.managedObjectContext];
        secondFlight.cityFrom = @"Chelyabinsk";
        secondFlight.cityTo = @"Moscow";
        secondFlight.aviaCompany = @"ChelAvia";
        secondFlight.price = [NSNumber numberWithInt:2000.0];
        Record * thirdFlight = [NSEntityDescription insertNewObjectForEntityForName:@"Record"inManagedObjectContext:self.managedObjectContext];
        thirdFlight.cityFrom = @"Yekaterinburg";
        thirdFlight.cityTo = @"Ufa";
        thirdFlight.aviaCompany = @"Aeroflot";
        thirdFlight.price = [NSNumber numberWithInt:500.0];
        Record * fourthFlight = [NSEntityDescription
                                 insertNewObjectForEntityForName:@"Record"
                                 inManagedObjectContext:self.managedObjectContext];
        fourthFlight.cityFrom = @"Chelyabinsk";
        fourthFlight.cityTo = @"Ufa";
        fourthFlight.aviaCompany = @"RusLain";
        fourthFlight.price = [NSNumber numberWithInt:1500.0];
        Record * fivthFlight = [NSEntityDescription
                                insertNewObjectForEntityForName:@"Record"
                                inManagedObjectContext:self.managedObjectContext];
        fivthFlight.cityFrom = @"Yekaterinburg";
        fivthFlight.cityTo = @"Moscow";
        fivthFlight.aviaCompany = @"Aeroflot";
        fivthFlight.price = [NSNumber numberWithInt:800.0];
        [self saveContext];
    }
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "-.Lab8_1_1" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Lab8_1_1" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Lab8_1_1.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(NSArray*)getAllFlights
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Record" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    NSArray *fetchedRecords = [self.managedObjectContext
                               executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}


@end
