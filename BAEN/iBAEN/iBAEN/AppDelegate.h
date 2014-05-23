//
//  AppDelegate.h
//  iBAEN
//
//  Created by loi on 5/23/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "SplitViewController.h"
#import "NavigationController.h"

@interface AppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, UINavigationControllerDelegate,UISplitViewControllerDelegate>
{
    UIWindow *window;
    
    SplitViewController *splitController;
    
    NavigationController *navigationController;
    NavigationController *rightNavigationController;
}

@end
