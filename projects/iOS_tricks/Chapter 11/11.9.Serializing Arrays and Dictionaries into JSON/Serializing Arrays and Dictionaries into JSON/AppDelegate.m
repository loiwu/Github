//
//  AppDelegate.m
//  Serializing Arrays and Dictionaries into JSON
//
//  Created by Vandad NP on 24/06/2013.
//  Copyright (c) 2013 Pixolity Ltd. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

/* 1 */
/*- (BOOL)            application:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
      //create a simple dictionary with a few keys and values
    NSDictionary *dictionary =
    @{
      @"First Name" : @"Anthony",
      @"Last Name" : @"Robbins",
      @"Age" : @51,
      @"children" : @[
              @"Anthony's Son 1",
              @"Anthony's Daughter 1",
              @"Anthony's Son 2",
              @"Anthony's Son 3",
              @"Anthony's Daughter 2"
              ],
      };
    
      // serialize it into a JSON object
    NSError *error = nil;
      //The return value of the dataWithJSONObject:options:error: method is data of type NSData.
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:dictionary
                        options:NSJSONWritingPrettyPrinted
                        error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        NSLog(@"Successfully serialized the dictionary into data = %@",
              jsonData);
    }
    else if ([jsonData length] == 0 && error == nil){
        NSLog(@"No data was returned after serialization.");
    }
    else if (error != nil){
        NSLog(@"An error happened = %@", error);
    }
    
    self.window = [[UIWindow alloc]
                   initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
*/
/* 2 */

- (BOOL)            application:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{

    NSDictionary *dictionary =
    @{
      @"First Name" : @"Anthony",
      @"Last Name" : @"Robbins",
      @"Age" : @51,
      @"children" : @[
              @"Anthony's Son 1",
              @"Anthony's Daughter 1",
              @"Anthony's Son 2",
              @"Anthony's Son 3",
              @"Anthony's Daughter 2"
              ],
      };

    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:dictionary
                        options:NSJSONWritingPrettyPrinted
                        error:&error];

    if ([jsonData length] > 0 && error == nil){

        NSLog(@"Successfully serialized the dictionary into data.");
       //simply turn this data into a string and print it to the console using 
       //the initWithData:encoding: initializer of NSString.
        // serializes a dictionary into a JSON object, converts that object into a string,
        //and prints the string out to the console window
        NSString *jsonString =
        [[NSString alloc] initWithData:jsonData
                              encoding:NSUTF8StringEncoding];
        NSLog(@"JSON String = %@", jsonString);

    }
    else if ([jsonData length] == 0 && error == nil){
        NSLog(@"No data was returned after serialization.");
    }
    else if (error != nil){
        NSLog(@"An error happened = %@", error);
    }

    self.window = [[UIWindow alloc]
                   initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
