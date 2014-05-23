//
//  AppDelegate.m
//  iBAEN
//
//  Created by loi on 5/23/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//
#include <sys/types.h>
#include <sys/sysctl.h>

#import "AppDelegate.h"
#import "SplitViewController.h"
#import "NavigationController.h"
#import "MainTabBarController.h"

#import "EmptyController.h"

#import <NETKit/NETKit.h>
#import <NETKit/NETNetworkActivityController.h>

@implementation UINavigationController (AppDelegate)

- (BOOL)controllerBelongsOnLeft:(UIViewController *)controller {
    return [controller isKindOfClass:[MainTabBarController class]];
    //|| [controller isKindOfClass:[SessionListController class]]
    //|| [controller isKindOfClass:[SearchController class]]
    //|| [controller isKindOfClass:[ProfileController class]]
    //|| [controller isKindOfClass:[MoreController class]]
    //|| [controller isKindOfClass:[SubmissionListController class]];
}

- (void)willShowController:(UIViewController *)controller animated:(BOOL)animated {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if ([self controllerRequiresClearing:controller]) {
            [delegate clearLeafViewControllerAnimated:animated];
        }
    }
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    navigationController = [[NavigationController alloc] initWithRootViewController:sessionListController];
//    [navigationController setLoginDelegate:sessionListController];
    navigationController = [[NavigationController alloc] init];
    [navigationController setDelegate:self];
    [navigationController autorelease];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [window setRootViewController:navigationController];
        
        [NETObjectBodyRenderer setDefaultFontSize:13.0f];
    } else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        rightNavigationController = [[NavigationController alloc] init];
//        [rightNavigationController setLoginDelegate:sessionListController];
        [rightNavigationController setDelegate:self];
        [rightNavigationController autorelease];
        
        [self clearLeafViewControllerAnimated:NO];
        
        splitController = [[SplitViewController alloc] init];
        [splitController setViewControllers:[NSArray arrayWithObjects:navigationController, rightNavigationController, nil]];
        if ([splitController respondsToSelector:@selector(setPresentsWithGesture:)]) [splitController setPresentsWithGesture:YES];
        [splitController setDelegate:self];
        [splitController autorelease];
        
        [window setRootViewController:splitController];
        
        [NETObjectBodyRenderer setDefaultFontSize:16.0f];
    } else {
        NSAssert(NO, @"Invalid Device Type");
    }
    
    [window makeKeyAndVisible];
    return YES;
}

#pragma mark - View Controllers

- (void)navigationController:(UINavigationController *)navigation willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [navigation willShowController:viewController animated:animated];
}

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation {
    return UIInterfaceOrientationIsPortrait(orientation);
}

#pragma mark - Application Lifecycle

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NETSessionController sessionController] refresh];
    
   // [InstapaperSession logoutIfNecessary];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

- (void)dealloc {
    [window release];
    [navigationController release];
    [rightNavigationController release];
    [splitController release];
    
    [super dealloc];
}
@end
